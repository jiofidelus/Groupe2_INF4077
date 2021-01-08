<template>
  <ion-page>
 <ion-header>
   <ion-toolbar color="secondary">
     <ion-buttons slot="start">
       <ion-back-button></ion-back-button>
     </ion-buttons>
     <ion-title size="large">New Patient</ion-title>
   </ion-toolbar>
 </ion-header>
  <ion-content>
    <form class="mt-4 " id="contact">

      <h2 class="text-2xl mt-4 font-bold text-purple-500 text-center">Patient information</h2>

      <div class="rounded-lg border-gray-500 my-4 border p-8 mx-auto max-w-xl">

        <div>
          <label class="text-gray-800 font-bold">Patient's Name
          <input type="text" required name="name" class="p-2 mt-2 border rounded-lg w-full"
                 placeholder="Full name"/>
          </label>
        </div>

        <div class="mt-4">
          <label class="text-gray-800 font-bold">Patient's Phone
            <input type="tel" required name="name" class="p-2 mt-2 border rounded-lg w-full"
                   placeholder="Telephone"/>
          </label>
        </div>
        <div class="mt-4">
          <label class="text-gray-800 font-bold">Patient's Email
          <input type="text" name="email" class="p-2 mt-2 border rounded-lg w-full"
                 placeholder="email address"/>
          </label>

        </div>

        <div class="mt-4">
          <label class="text-gray-800 font-bold">Patient's Location
            <input type="text" name="email" class="p-2 mt-2 border rounded-lg w-full"
                   placeholder="email address" readonly v-model="long"/>
            <input type="text" name="email" class="p-2 mt-2 border rounded-lg w-full"
                   placeholder="email address" readonly v-model="lat"/>

            <input type="text" name="email" class="p-2 mt-2 border rounded-lg w-full"
                   placeholder="email address" readonly v-model="form.city"/>
          </label>

        </div>

        <div class="col-md-6 mt-4">
          <p class="text-gray-800 font-bold">Take Picture</p>

          <div class="border">
            <figure class="figure" v-if="img">
              <img :src="img" class="img-responsive" />
            </figure>
            <div v-else>
              <video id="webcam" autoplay playsinline width="640" height="100"></video>
              <canvas id="canvas" class="d-none"></canvas>
            </div>

          </div>

          <div class="row mt-4">

            <div class="col-md-12">
              <button type="button" class="rell-button" @click="onStart">Start</button>
              <button type="button" class="rell-button bg-green-800 ml-4" @click="onCapture">Take</button>
            </div>
          </div>
        </div>


        <div class="mt-4">
          <button type="submit" class="rell-button ml-auto block">Save</button>
        </div>
      </div>
    </form>
  </ion-content>
  </ion-page>
</template>

<script>


import Webcam from 'webcam-easy';
import {
  IonContent,
  IonHeader,
  IonPage,
  IonTitle,
  IonToolbar,
  IonBackButton,
} from "@ionic/vue";

export default {
  name: "Patient",
  components: { IonHeader, IonToolbar, IonTitle, IonContent, IonPage, IonBackButton},

  mounted() {
    const webcamElement = document.getElementById('webcam');
    const canvasElement = document.getElementById('canvas');
    const snapSoundElement = document.getElementById('snapSound');
    this.camera = new Webcam(webcamElement, 'user', canvasElement, snapSoundElement);
    this.afficherGPS();
  },

  data() {
    return {
      number: 0,
      gpsNondisponible: false,
      long: 'Searching ...',
      lat: 'Searching ...',
      searching : false,
      img: null,
      camera: null,
      deviceId: null,
      devices: [],
      cameraActive: false,
      form: {
        name: "Patient 1",

        birthday: "",
        gender: "M",
        city:''
      }
    }
  },


  methods: {
    afficherGPS(){
      this.searching = true
      if (navigator.geolocation) {
        navigator.geolocation.getCurrentPosition((position) =>{
              this.searching = false
              console.log(position)
              this.long = position.coords.longitude
              this.lat = position.coords.latitude
              this.form.city = "Yaoundé"
            },
            (e) =>{
              console.log(e)
              this.searching = false
              this.gpsNondisponible = true
            });
      } else {
        this.gpsNondisponible = true
      }
    },
    onCapture() {
      this.img =this.webcam.snap();
      this.webcam.stop();
    },
    onStarted(stream) {
      console.log("On Started Event", stream);
    },
    onStopped(stream) {
      console.log("On Stopped Event", stream);
    },
    onStop() {
      console.log("Stop")
    },
    onStart() {
      this.camera.start()
          .then(result =>{
            console.log("webcam started");
          })
          .catch(err => {
            console.log(err);
          });
    },
    onError(error) {
      console.log("On Error Event", error);
    },
  }
}
</script>

<style scoped>

</style>
