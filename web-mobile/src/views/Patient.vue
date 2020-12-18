<template>
  <ion-page>
 <ion-header>
   <ion-toolbar>
     <ion-buttons slot="start">
       <ion-back-button></ion-back-button>
     </ion-buttons>
     <ion-title size="large">Liste Patients</ion-title>
   </ion-toolbar>
 </ion-header>
  <ion-content></ion-content>
  </ion-page>
</template>

<script lang="ts">
import ExploreContainer from "@/components/ExploreContainer.vue";
import {IonContent, IonHeader, IonPage, IonTitle, IonToolbar, IonBackButton} from "@ionic/vue";

export default {
  name: "Patient",
  components: { IonHeader, IonToolbar, IonTitle, IonContent, IonPage, IonBackButton },


  data() {
    return {
      number: 0,
      gpsNondisponible: false,
      long: '',
      lat: '',
      searching : false
    }
  },

  methods: {
    ajouterparcent() {
      this.number = this.number + 100
    },

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
    afficherCamera(){
      const video = document.querySelector("#videoElement");

      if (navigator.mediaDevices.getUserMedia) {
        navigator.mediaDevices.getUserMedia({ video: true })
          .then(function (stream) {
            video.srcObject = stream;
          })
          .catch(function (err0r) {
            alert("Something went wrong!");
          });
      }
    },

    afficherGPS(){
      this.searching = true
      if (navigator.geolocation) {
        navigator.geolocation.getCurrentPosition((position) =>{
          this.searching = false
          console.log(position)
          this.long = position.coords.longitude
          this.lat = position.coords.latitude
        },
          (e) =>{
          console.log(e)
          this.searching = false
          this.gpsNondisponible = true
        });
      } else {
        this.gpsNondisponible = true
      }
    }
  }
}
</script>

<style scoped>

</style>
