package main

import (
	"fmt"
	"log"
	"net/http"
)

func main() {
	http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		fmt.Fprintf(w, "Hello, World!")
	})

	fmt.Println("Server running at http://127.0.0.1:80")
	log.Fatal(http.ListenAndServe("0.0.0.0:80", nil))
}
