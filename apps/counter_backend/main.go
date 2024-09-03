package main

import (
	"fmt"
	"log"
	"net/http"
	"sync"
	"time"
)

var (
	totalVisitorCount  int
	uniqueVisitorCount int
	mu                 sync.Mutex
	visitors           = make(map[string]bool)
)

func incrementVisitorCount(w http.ResponseWriter, r *http.Request) {
	mu.Lock()
	defer mu.Unlock()

	// Check for unique visitor using a cookie
	cookie, err := r.Cookie("visitor_id")
	if err != nil {
		// New visitor
		uniqueVisitorCount++
		cookieValue := fmt.Sprintf("%d", uniqueVisitorCount)
		http.SetCookie(w, &http.Cookie{
			Name:    "visitor_id",
			Value:   cookieValue,
			Expires: time.Now().Add(365 * 24 * time.Hour),
		})
		visitors[cookieValue] = true
	} else {
		// Existing visitor
		visitors[cookie.Value] = true
	}

	// Increment the total visitor count
	totalVisitorCount++

	// Send response with both total and unique visitor count
	fmt.Fprintf(w, `{"totalVisitors": %d, "uniqueVisitors": %d, "lastVisit": "%s"}`, totalVisitorCount, len(visitors), time.Now().Format(time.RFC1123))
}

func resetVisitorCount(w http.ResponseWriter, r *http.Request) {
	mu.Lock()
	defer mu.Unlock()

	totalVisitorCount = 0
	visitors = make(map[string]bool)

	fmt.Fprintf(w, "Counter reset successfully")
}

func main() {
	// Adjust the file server path to serve from the sibling directory "static_client"
	http.Handle("/", http.FileServer(http.Dir("../static_client")))

	// Handle the /count endpoint
	http.HandleFunc("/count", incrementVisitorCount)

	// Handle the /reset endpoint
	http.HandleFunc("/reset", resetVisitorCount)

	// Start the server on http://localhost:8080
	fmt.Println("Server is running on http://localhost:8080")
	log.Fatal(http.ListenAndServe(":8080", nil))
}
