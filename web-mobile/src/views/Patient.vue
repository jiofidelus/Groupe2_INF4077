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

  }
}
</script>

<style scoped>

</style>
