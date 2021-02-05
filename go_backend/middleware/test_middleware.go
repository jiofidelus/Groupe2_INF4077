package middleware

import (
	"github.com/kataras/iris/v12"
	"log"
	"time"
)

func Logger() iris.Handler {
	return func(ctx iris.Context) {
		t := time.Now()

		// Set a shared variable between handlers

		// before request
		ctx.Next()

		// after request
		latency := time.Since(t)
		log.Print(latency)

		ctx.Header("Framework-Owner", "Hiro")

		// access the status we are sending
		status := ctx.GetStatusCode()
		log.Println(status)
	}
}
