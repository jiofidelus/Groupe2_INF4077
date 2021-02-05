package models

type ErrorModel struct {
	Error      string `json:"error"`
	Suggestion string `json:"suggestion"`
}
