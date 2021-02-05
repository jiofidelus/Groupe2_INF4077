package models

type SMSData struct {
	Message string   `json:"message" binding:"required"`
	Token   string   `json:"token" binding:"required"`
	Numbers []string `json:"numbers" binding:"required"`
}
