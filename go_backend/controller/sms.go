package controller

import (
	"backend/app"
	. "backend/models"
	"bytes"
	"encoding/json"
	"fmt"
	"github.com/kataras/iris/v12"
	"io/ioutil"
	"log"
	"net/http"
	"strings"
	"time"
)

func init() {
	log.Println("SMS Controller init()")
	booksAPI := app.App.Party("/sms")

	booksAPI.Post("/", sendSMS)

}

var success []string = make([]string, 0, 100)
var failure []string = make([]string, 0, 100)

func sendSMS(ctx iris.Context) {
	success = []string{}
	failure = []string{}
	var data SMSData

	if err := ctx.ReadBody(&data); err != nil {
		ctx.StopWithJSON(http.StatusInternalServerError, ErrorModel{
			Error:      err.Error(),
			Suggestion: "Try fixing and try again",
		})
		return
	}

	log.Println(data)

	for i, number := range data.Numbers {
		log.Printf("Sendind SMS %d of %d. Number %s", i, len(data.Numbers), number)
		_sendSMSToAPI(number, data.Message, data.Token)
	}

	result := iris.Map{"result": "SMS send", "success": success, "failure": failure}

	fmt.Println(result)

	ctx.StopWithJSON(200, result)
}

func _sendSMSToAPI(number string, message string, apiToken string) {
	url := fmt.Sprint("https://api.orange.com/smsmessaging/v1/outbound/tel%3A%2B2370000/requests")

	type SMSTextMessage struct {
		Message string `json:"message"`
	}

	type SMS struct {
		Address                string         `json:"address"`
		SenderAddress          string         `json:"senderAddress"`
		OutboundSMSTextMessage SMSTextMessage `json:"outboundSMSTextMessage"`
	}

	sms := struct {
		OutboundSMSMessageRequest SMS `json:"outboundSMSMessageRequest"`
	}{
		OutboundSMSMessageRequest: SMS{
			Address:       "tel:+237" + number,
			SenderAddress: "tel:+2370000",
			OutboundSMSTextMessage: SMSTextMessage{
				Message: strings.TrimSpace(message),
			},
		},
	}

	data, err := json.Marshal(&sms)
	if err != nil {
		fmt.Println(err)
		return
	}
	fmt.Println(string(data))

	req, err := http.NewRequest("POST", url, bytes.NewBuffer(data))
	if err != nil {
		log.Fatal("Error reading request. ", err)
	}

	// Set headers
	req.Header.Set("Content-Type", "application/json")
	req.Header.Set("Authorization", "Bearer "+apiToken)

	// Set client timeout
	client := &http.Client{Timeout: time.Second * 10}

	// Validate cookie and headers are attached
	fmt.Println("Validating cookies and headers")
	fmt.Println(req.Cookies())
	fmt.Println(req.Header)

	// Send request
	resp, err := client.Do(req)
	if err != nil {
		log.Fatal("Error reading response. ", err)
	}
	defer resp.Body.Close()

	fmt.Println("response Status:", resp.Status)
	fmt.Println("response Headers:", resp.Header)

	if resp.StatusCode == 201 {
		success = append(success, number)
	} else {
		failure = append(failure, number)
	}
	body, err := ioutil.ReadAll(resp.Body)
	if err != nil {
		log.Fatal("Error reading body. ", err)
	}

	fmt.Printf("%s\n", body)
}
