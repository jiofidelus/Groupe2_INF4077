<template>
  <ion-page>
    <ion-header>
      <ion-toolbar  color="secondary" >
        <ion-buttons slot="start">
          <ion-back-button></ion-back-button>
        </ion-buttons>
        <ion-title size="large">Liste Patients</ion-title>
      </ion-toolbar>
    </ion-header>
    <ion-content fullscreen>
      <ion-list>
        <ion-item v-for="item in patients" :key="item.id">
          <ion-avatar slot="start">
            <ion-img :src="item.picture"></ion-img>
          </ion-avatar>
          <ion-label>
            <h2>{{ item.name }}</h2>
            <p>Born on: {{ item.birthday }} at {{ regions.find(x => x.id === item.birthCity).name }}</p>
            <p>Registered on {{ item.createdOn }} </p>
            <p>Phone: {{ item.phone }} </p>
          </ion-label>
        </ion-item>

      </ion-list>
    </ion-content>
  </ion-page>
</template>

<script >

import consult from "@/assets/mocks/consultation1.json"
import regions from "@/assets/mocks/regions.json"
import patients from "@/assets/mocks/patients.json"

window.consult = consult;
window.regions = regions;
window.patients = patients;
import {IonContent, IonHeader, IonPage, IonTitle, IonToolbar, IonBackButton, IonImg} from "@ionic/vue";

export default {
  name: "Patient",
  components: { IonHeader, IonToolbar, IonTitle, IonContent, IonPage, IonBackButton, IonImg },


  data() {
    return {
      number: 0,
      gpsNondisponible: false,
      long: '',
      lat: '',
      searching : false,
      patients : window.patients,
      regions: window.regions,
    }
  },

  methods: {

  }
}
</script>

<style scoped>

</style>