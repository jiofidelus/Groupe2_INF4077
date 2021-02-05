package controller

import (
	"backend/app"

	"github.com/kataras/iris/v12"

	"log"
)

func init() {
	log.Println("Index HTML Controller init()")
	app.App.HandleDir("/", iris.Dir("./html"))

}
