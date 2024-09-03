package main

import (
	"context"
	"encoding/json"
	"fmt"
	"log"
	"net/http"
	"time"

	"github.com/go-redis/redis/v8"
)

var ctx = context.Background()

type VisitorData struct {
	TotalVisitors  int    `json:"totalVisitors"`
	UniqueVisitors int    `json:"uniqueVisitors"`
	LastVisit      string `json:"lastVisit"`
}

func main() {
	// Connect to Redis
	rdb := redis.NewClient(&redis.Options{
		Addr:     "localhost:6379", // Use default Redis port
		Password: "",               // No password set
		DB:       0,                // Use default DB
	})

	http.HandleFunc("/update", func(w http.ResponseWriter, r *http.Request) {
		// Fetch the current visitor data from Redis
		data, err := rdb.Get(ctx, "visitor_data").Result()
		if err == redis.Nil {
			// Initialize if no data exists
			data = `{"totalVisitors": 0, "uniqueVisitors": 0, "lastVisit": ""}`
		} else if err != nil {
			log.Fatal(err)
		}

		var visitorData VisitorData
		err = json.Unmarshal([]byte(data), &visitorData)
		if err != nil {
			log.Fatal(err)
		}

		// Update visitor data
		visitorData.TotalVisitors++
		visitorData.LastVisit = time.Now().Format(time.RFC1123)

		// Assuming uniqueness is handled by frontend (e.g., using cookies)
		visitorData.UniqueVisitors++ // For simplicity, increment as if each visit is unique

		// Store the updated data back into Redis
		updatedData, err := json.Marshal(visitorData)
		if err != nil {
			log.Fatal(err)
		}

		err = rdb.Set(ctx, "visitor_data", updatedData, 0).Err()
		if err != nil {
			log.Fatal(err)
		}

		// Respond with the updated visitor data
		w.Header().Set("Content-Type", "application/json")
		w.Write(updatedData)
	})

	fmt.Println("Redis backend server is running on http://localhost:8081")
	log.Fatal(http.ListenAndServe(":8081", nil))
}
