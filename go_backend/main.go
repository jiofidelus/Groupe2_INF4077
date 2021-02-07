package main

import (
	"backend/app"
	_ "backend/configs"
	_ "backend/controller"
	_ "backend/models"
)

func main() {
	app.Start()
}
