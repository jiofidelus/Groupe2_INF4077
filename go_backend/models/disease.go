package models

type Disease struct {
	Name        string `json:"name"`
	CausedBy    string `json:"causedBy"`
	Description string `json:"description"`
	Causes      string `json:"causes"`
}
