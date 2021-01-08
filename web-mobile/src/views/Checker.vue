<template>
  <ion-page>
    <ion-header>
      <ion-toolbar>
        <ion-buttons slot="start">
          <ion-back-button></ion-back-button>
        </ion-buttons>
        <ion-title size="large">Symptom Checker</ion-title>
      </ion-toolbar>
    </ion-header>
    <ion-content>
      <div id="questionaire">
        <main class="max-w-5xl mx-auto px-4 lg:px-0 my-4 " v-if='!response'>

          <div class="relative py-16 mt-2 bg-gray-300 border rounded-lg">
            <p
                class="relative z-10 font-sans text-xl font-bold text-center md:text-3xl"
            >
              Rell'Care COVID-19 Screening
            </p>

            <img
                src="/assets/img/screening.png"
                class="absolute right-0 z-0"
                style="margin-top: -3.9rem;"
                alt=""
            />
          </div>
          <div

              class="flex flex-col w-full p-4 font-sans font-bold text-white bg-gray-800 md:p-16 "
          >
            <p class="text-sm text-gray-300" v-if="!answeredAll">
              Question {{ questionIndex + 1 }} / {{ questions.length }} <span
                v-if="questions[questionIndex]">: {{ questions[questionIndex].name }}</span>
            </p>

            <p class="text-sm text-gray-300" v-if="answeredAll">
              Where are you situated
            </p>
            <div
                v-if="!answeredAll"
                class="flex items-center justify-center h-32 mt-4 paragraph text-3xl text-center md:text-5xl"
                style="min-height: 16rem"
            >
              {{ displayText || questions[questionIndex].question }}
            </div>
            <div
                v-if="!answeredAll"
                :class="{'opacity-0 pointer-events-none':displayText}"
                class="flex mt-8"
            >
              <button
                  class="flex-grow text-2xl rounded-lg paragraph rell-button"
                  @click="answer(true)"
              >
                Yes
              </button>
              <button
                  class="flex-grow ml-8 text-2xl rounded-lg paragraph rell-button"
                  @click="answer(false)"
              >
                No
              </button>
            </div>

            <div class="flex flex-col" v-if="!displayText && answeredAll">


              <div class="flex flex-col py-4 ">
                <span class="text-xl ">Your region :</span>
                <select
                    name="test"

                    v-model='region'
                    class="flex-grow px-4 mt-2 text-xl text-black bg-white border-b "
                >
                  <option v-for='country in countries' :key='country.code' :value='country.id'>{{ country.name }}
                  </option>

                </select>

              </div>

              <div class="flex flex-col py-4">
                <span class="text-xl ">Patients phone :</span>
                <input
                    type="tel"
                    v-model='phone'

                    class="flex-grow px-4 mt-2 text-xl text-white bg-transparent border-b"
                />


                <button class="w-full mt-8 text-xl rell-button" @click='sendData'>Results</button>
              </div>

            </div>
          </div>
        </main>
        <main v-if='response'>
          <div class="bg-gray-300">
            <div class="relative h-48 max-w-5xl mx-auto">
              <img
                  src="/assets/img/results.png"
                  alt=""
                  class="absolute bottom-0 ml-12 -mb-5"
              />
            </div>
          </div>
          <div class="max-w-4xl px-4 py-4 mx-auto md:px-0">
            <div class="flex text-lg">
              <button class="p-2 font-bold text-blue-600" @click='sendSMS'>Send SMS to Patient</button>
              <button class="p-2 font-bold text-blue-600 ml-auto"  @click='recordSound'>Record Audio</button>
              <button class="p-2 ml-auto font-bold text-blue-600" @click='printDoc'>
                Print
              </button>
            </div>
            <div class="mt-8 md:flex">
              <div class="md:w-1/2">
                <p class="text-3xl font-black">
                  {{ response.description }}
                </p>
                <p class="mt-4">
                  Based on your responses, {{ response.overview }}
                </p>

                <p class="mt-16 text-2xl font-bold">We advice you to</p>

                <div class="py-4 border-b" v-for="(conseil,index) of response.advices" :key='index'>
                  <div class="flex text-xl font-bold">
                  <span
                      class="flex items-center justify-center w-8 h-8 text-white bg-purple-500 rounded-full"
                  >{{ index + 1 }}</span
                  >

                  </div>

                  <div class="mt-2 ml-12">
                    <p>
                      {{ conseil }}
                    </p>

                  </div>
                </div>

              </div>
              <div class="md:w-1/2 md:pl-24">
                <div class="md:mt-56">
                  <p class="text-xl font-bold">Your answers</p>
                  <div class="mt-4">
                    <div class="flex items-center mt-2" v-for='(answer) of answers' :key="answer.id">
                      <span class="w-2 h-2 bg-black rounded"></span>
                      <span class="ml-2 flex-grow">{{ questions[answer.id].question }} </span>
                      <span class="text-red-700" v-if='answer.answer'>Yes</span>
                      <span class="text-green-700 ml-2" v-else>No</span>
                    </div>

                  </div>
                </div>
              </div>
            </div>

            <div
                class="flex justify-center py-8 mt-16 text-base font-bold text-purple-500"
            >
              <span class="px-4">Screening Tool</span>
              <span class="px-4 border-l">
              Legal
            </span>
            </div>
          </div>
        </main>
      </div>
    </ion-content>
  </ion-page>
</template>

<script>

import {

  IonContent,
  IonHeader,
  IonPage
} from "@ionic/vue";

import consult from "@/assets/mocks/consultation1.json"
import regions from "@/assets/mocks/regions.json"
import patients from "@/assets/mocks/patients.json"
import disease from "@/assets/mocks/disease.json"

window.consult = consult;
window.regions = regions;
window.patients = patients;
window.disease = disease;

export default {
  name: "Checker",
  // eslint-disable-next-line no-undef
  components: {IonPage, IonHeader, IonContent,},
  data: function () {
    return {
      points: 0,
      countries: [],
      regions: [],
      country: '',
      region: 0,
      phone: "",
      appreciation: [
        "Noted",
        "Recorded",
        "Got it",
        "I see",
        "Interesting",
        "Continue",
      ],

      displayText: "",


      questions: [...window.disease.symptomes, ...window.disease.additional],
      questionIndex: 0,
      answers: [],
      response: null,
    };
  },
  methods: {
    recordSound(){
      navigator.mediaDevices.getUserMedia({ audio: true })
          .then(stream => {
            const mediaRecorder = new MediaRecorder(stream);
            mediaRecorder.start();

            const audioChunks = [];
            mediaRecorder.addEventListener("dataavailable", event => {
              audioChunks.push(event.data);
            });

            mediaRecorder.addEventListener("stop", () => {
              const audioBlob = new Blob(audioChunks);
              const audioUrl = URL.createObjectURL(audioBlob);
              const audio = new Audio(audioUrl);
              audio.play();
            });

            setTimeout(() => {
              mediaRecorder.stop();
            }, 3000);
          });
    },
    async sendSMS() {
      const r = await window.axios.post('https://api.orange.com/smsmessaging/v1/outbound/tel%3A%2B2370000/requests',
          {
            "outboundSMSMessageRequest": {

              "address": "tel:+237"+this.phone.trim(),
              "senderAddress": "tel:+2370000",
              "outboundSMSTextMessage": {
                "message": "Hello! ,  From your consultation, This is the overview : " + this.response.description + "\nTP INFO4077 Groupe 2"
              }
            }
          },
          {
            headers: {'Authorization': "Bearer JgfBxKmAPeeYtovgK0GZAHEGkKUw"}
          }
      );

      console.log(r);
      alert("SMS sent successfully to "+ "+237 "+this.phone)
    },
    async sendData() {
      this.response = window.disease.results.find(x => x.start <= this.points && this.points <= x.end)
    }
    ,
    async getCountries() {
      this.countries = window.regions
    },

    printDoc() {
      print()
    }
    ,
    reset() {
      this.questionIndex = 0
      this.config.data.answers = []
      this.appreciation = []
      this.response = null
    }
    ,
    async answer(response) {
      if (response) {
        this.points += this.questions[this.questionIndex].points
      }
      this.answers.push({
        id: this.questionIndex,
        answer: response,
      });

      if (this.questionIndex + 1 === this.questions.length) {

        this.displayText =
            "Congratulation your are done"

      } else {
        this.displayText = this.appreciation[this.questionIndex % this.appreciation.length];
      }

      setTimeout(() => {
        this.displayText = "";
        this.questionIndex++;
      }, 500);
    },
  },
  computed: {
    answeredAll() {
      return this.questionIndex + 1 > this.questions.length;
    }
  },
  mounted() {
    console.log()
    this.getCountries()
  }

}
</script>

<style scoped>

</style>