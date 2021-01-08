<template>
<ion-page>
  <ion-header >
    <ion-toolbar>
      <ion-buttons slot="start">
        <ion-back-button @click="router.replace('/tabs/stats')"></ion-back-button>
      </ion-buttons>
      <ion-title size="large">Localisation</ion-title>
    </ion-toolbar>
  </ion-header>
  <ion-content >
    <div  id="mapContainer" class="basemap w-full h-full"></div>
  </ion-content>
</ion-page>
</template>

<script>
import mapboxgl from "mapbox-gl";
import {
  IonContent,
  IonHeader,
  IonPage
} from "@ionic/vue";
import {useRouter} from "vue-router";
import {logIn, personAdd} from "ionicons/icons";

export default {
  name: "Maps",
  components:{IonPage, IonHeader, IonContent},
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
      accessToken: "pk.eyJ1IjoiYW5pY2V0ODgiLCJhIjoiY2tpeXpmazRzM3RhMDMzcDM3djZoZDl6NCJ9.fMlncdyZ6OtZglERZN5M8w",
    };
  },
  mounted() {
    mapboxgl.accessToken = this.accessToken;
    const nav = new mapboxgl.NavigationControl();
    const map = new mapboxgl.Map({
      container: "mapContainer",
      style: "mapbox://styles/mapbox/streets-v11",
      center: [11.498686, 3.8551091],
      zoom: 7,
      maxBounds: [
        [10.2, 3.1],
        [12.6, 4.1],
      ],

    });map.addControl(nav, "top-right");
    new mapboxgl.Marker()
        .setLngLat([11.498686, 3.8551091])
        .addTo(map);
  },


}
</script>

<style scoped>

</style>