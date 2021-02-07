package app

import (
	"github.com/kataras/iris/v12"
	"log"
)

var App *iris.Application

func init() {
	log.Println("App init()")
	App = iris.Default()
}

func Start() {
	App.Listen(":8100")
}
