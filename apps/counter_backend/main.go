package main

import (
	"encoding/json"
	"fmt"
	"io/ioutil"
	"log"
	"net/http"
)

type VisitorData struct {
	TotalVisitors  int    `json:"totalVisitors"`
	UniqueVisitors int    `json:"uniqueVisitors"`
	LastVisit      string `json:"lastVisit"`
}

func main() {
	// Serve static files from the "static_client" directory
	http.Handle("/", http.FileServer(http.Dir("../static_client")))

	// Handle the /count endpoint by proxying requests to the redis_backend
	http.HandleFunc("/count", func(w http.ResponseWriter, r *http.Request) {
		resp, err := http.Get("http://localhost:8081/update")
		if err != nil {
			http.Error(w, "Failed to connect to Redis backend", http.StatusInternalServerError)
			return
		}
		defer resp.Body.Close()

		body, err := ioutil.ReadAll(resp.Body)
		if err != nil {
			http.Error(w, "Failed to read response from Redis backend", http.StatusInternalServerError)
			return
		}

		var visitorData VisitorData
		err = json.Unmarshal(body, &visitorData)
		if err != nil {
			http.Error(w, "Failed to parse visitor data", http.StatusInternalServerError)
			return
		}

		w.Header().Set("Content-Type", "application/json")
		w.Write(body)
	})

	fmt.Println("Counter backend server is running on http://localhost:8080")
	log.Fatal(http.ListenAndServe(":8080", nil))
}
