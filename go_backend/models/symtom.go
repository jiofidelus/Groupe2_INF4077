package models

type Symptom struct {
	Name        string `json:"name"`
	Points      int    `json:"points"`
	Information string `json:"information"`
	Question    string `json:"question"`
}
