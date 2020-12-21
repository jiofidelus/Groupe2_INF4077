<template>
  <ion-page>
 <ion-header>
   <ion-toolbar>
     <ion-buttons slot="start">
       <ion-back-button></ion-back-button>
     </ion-buttons>
     <ion-title size="large">Ajouter un malade <ion-icon :icon=personAdd></ion-icon></ion-title>
   </ion-toolbar>
 </ion-header>
  <ion-content>

      <form @submit.prevent="handleLogin">
        <ion-card div="centerLogin pa-4" style="max-width: 500px; margin-right: auto; margin-left: auto" >

          <ion-grid >

            <ion-row >
              <ion-col>
                <ion-list style="text-align:center">
                  NOUVEAU PATIENT
                </ion-list>
              </ion-col>
            </ion-row>



            <ion-row >
              <ion-col>
                <ion-item>
                  <ion-label position="floating"><h2>Nom</h2></ion-label>
                  <ion-input type="nom" placeholder="votre nom" required v-model="form.name"></ion-input>
                </ion-item>
              </ion-col>
            </ion-row>

            <ion-row >
              <ion-col>
                <ion-item>
                  <ion-label position="floating"><h2>Telephone</h2></ion-label>
                  <ion-input type="phone" placeholder="numero de telephone" required v-model="form.number"></ion-input>
                </ion-item>
              </ion-col>
            </ion-row>

            <ion-row >
              <ion-col>
                <ion-item>
                  <ion-label position="floating"><h2>Date de naissance</h2></ion-label>
                  <ion-input type="date" placeholder="Date de naissance" required v-model="form.birthday"></ion-input>
                </ion-item>
              </ion-col>
            </ion-row>

            <ion-row >
              <ion-col>
                <ion-item>
                  <ion-label position="floating"><h2>Genre</h2></ion-label>
                  <ion-input type="text" placeholder="votre sexe" required v-model="form.gender"></ion-input>
                </ion-item>
              </ion-col>
            </ion-row>

            <ion-row >
              <ion-col>
                <ion-item>
                  <ion-label position="floating"><h2>Ville <ion-spinner v-if="searching"></ion-spinner></h2> </ion-label>
                  <ion-input type="text" placeholder="Votre ville ..." readonly required v-model="form.city"></ion-input>
                  <ion-input type="text" placeholder="Longitude" required v-model="long" readonly></ion-input>
                  <ion-input type="text" placeholder="Latitude" required v-model="lat" readonly></ion-input>

                </ion-item>
              </ion-col>
            </ion-row>


            <ion-row>
              <ion-col >
                <video autoplay="true" id="videoElement"></video>
                <ion-list style="text-align:center">
                <ion-button style="margin-left: auto; margin-right: auto" @click="afficherCamera()" v-if="!cameraActive">Prendre une photo</ion-button>
                <ion-button style="margin-left: auto; margin-right: auto" @click="afficherCamera()" v-else>Capturer l'image</ion-button>
                </ion-list>

              </ion-col>
            </ion-row>




            <ion-row >
              <ion-col>
                <ion-list style="text-align:center">
                  <ion-button size="default" color="tertiary" type="submit" shape="round" text-center>Soumettre</ion-button>
                </ion-list>
              </ion-col>
            </ion-row>

          </ion-grid>

        </ion-card>
      </form>

  </ion-content>
  </ion-page>
</template>

<script lang="ts">
import {IonBackButton, IonContent, IonHeader, IonPage, IonTitle, IonToolbar, alertController, IonCard, IonIcon, IonItem, IonLabel, IonButton, IonInput} from "@ionic/vue";
import { useRouter } from 'vue-router';
import { logIn, personAdd } from 'ionicons/icons';
import { mapActions, mapGetters } from "vuex"
export default {
  name: "Nouveau",
  components: { IonPage, IonCard, IonItem, IonLabel, IonButton, IonInput, IonIcon, IonBackButton, IonContent, IonHeader, IonTitle, IonToolbar },
  setup() {
    const router = useRouter();
    return {
      router,
      logIn,
      personAdd
    };
  },
  data() {
    return {
      cameraActive: false,
      gpsNondisponible: false,
      long: 'Searching ....',
      lat:'Searching ....',
      searching:false,
      form: {
        name: "Patient 1",

        birthday: "",
        gender: "M",
        city:''
      }
    };
  },
  computed: {
    ...mapGetters("auth", [
      "authenticating",
      "authenticationError",
      "authenticationErrorCode"
    ])
  },
  methods: {
    ...mapActions("auth", ["signIn"]),
    afficherCamera(){
      this.cameraActive = true
      const video = document.querySelector("#videoElement");

      if (navigator.mediaDevices.getUserMedia) {
        navigator.mediaDevices.getUserMedia({ video: true })
          .then(function (stream) {
            (video as any)!.srcObject = stream;

          })
          .catch(function () {
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
    async handleLogin() {
      this.signIn(this.form).then(() => {
        this.form.email = ""
        this.form.password = ""
        this.router.push("/tabs/tab1")
      }).catch(async (err: any) => {
        const errorAlert = await alertController
          .create({
            header: 'Failed',
            subHeader: 'Sign in Failed',
            message: err,
            buttons: ['OK'],
          });
        await errorAlert.present()
      })
    }
  },
  mounted(){
    (this as any).afficherGPS()
  }
}
</script>

<style scoped>

</style>
