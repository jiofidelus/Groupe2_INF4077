<template>
  <div>Mon numero est {{ number }}</div>

  <ion-button size="large" @click="number++">Incrementer</ion-button>
  <ion-button size="large" @click="ajouterparcent()">Ajouter par 100</ion-button>
  <ion-button color="danger" @click="number--">Decrementer</ion-button>
  <ion-button @click="afficherCamera()">Afficher la camera</ion-button>
  <ion-button @click="afficherGPS()">Afficher le GPS</ion-button>
  <ion-button @click="recordSound()">Enregistreur</ion-button>

  <ion-spinner v-if="searching"></ion-spinner>

  <p v-if="gpsNondisponible">Le GPS n'est pas disponible</p>



  <p>Longitude : {{long}} et Latitude: {{lat}}</p>

  <div id="number"></div>

  <video autoplay="true" id="videoElement">

  </video>
</template>

<script>
export default {
  name: "Page",



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
