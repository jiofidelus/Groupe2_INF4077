package models

type Results struct {
	Start       int      `json:"start"`
	End         int      `json:"end"`
	Overview    string   `json:"overview"`
	Description string   `json:"description"`
	Advices     []string `json:"advices"`
}
