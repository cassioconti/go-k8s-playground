package handlers

import (
	"cassio-test-k8s-ready-service/version"
	"encoding/json"
	"log"
	"net/http"
)

type versionDetails struct {
	BuildTime string `json:"buildTime"`
	Commit    string `json:"commit"`
	Release   string `json:"release"`
}

// home is a simple HTTP handler function which writes a response.
func home(w http.ResponseWriter, _ *http.Request) {
	info := versionDetails{
		BuildTime: version.BuildTime,
		Commit:    version.Commit,
		Release:   version.Release,
	}

	body, err := json.Marshal(info)
	if err != nil {
		log.Printf("Could not encode info data: %v", err)
		http.Error(w, http.StatusText(http.StatusServiceUnavailable), http.StatusServiceUnavailable)
		return
	}

	w.Header().Set("Content-Type", "application/json")
	w.Write(body)
}
