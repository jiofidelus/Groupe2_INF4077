<template>
  <ion-page>
    <ion-header>
      <ion-toolbar>
        <ion-buttons slot="start">
          <ion-back-button></ion-back-button>
          <ion-button @click="router.push('/tabs/stats/maps')"> SEE MAP</ion-button>
        </ion-buttons>
        <ion-title size="large">Statistics</ion-title>
      </ion-toolbar>
    </ion-header>
    <ion-content>
      <div id="stats" class="max-w-5xl px-4 mx-auto mt-4 lg:flex lg:px-0">
        <div>
          <p class="uppercase subtitle">Statistics</p>
          <div class="flex flex-col mt-4">
            <label for="countries">Select a location </label>
            <select name="countries" id="countries" class="py-4 mt-2 rounded-lg" v-model="selected">
              <option v-for="country in countries" :key="country.id" :value="country.code">
                {{ country.name }}
              </option>
            </select>
            <button class="mt-2 rell-button" @click="selectCountry">
              Display
            </button>
          </div>
          <div v-if="selectedCountry" class="w-full mt-4 overflow-hidden border border-gray-500 rounded-lg">
            <p class="p-4">Cases overview</p>


            <div class="p-4 border-b border-gray-500" v-if="selectedCountry">
              <div class="flex items-center text-sm">
                <img
                    src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAMAAADXqc3KAAAARVBMVEUAAABChfRChfRBhfRChfRBhPVAhvVBhfRChfRChPRBhfNChPRChfNChPRAh/dAhfRChfNBhPRBhPNBhPRBhPNAhfRBhPS7Bx6gAAAAF3RSTlMAYJ/P/09Q35DgwI/wcCAwgKCw0O9vv5uoiNwAAACdSURBVHgBndAFFsJAEATRhhQrcb//UXmDS/yvu+i40zmB5HzRN+d58E4fAsRImlpO9tmfFyWUloqc8NqHvFJNI7UUquC5W6SQOms6EqnAP+7DHyfT8KeR6aik+n5ksF0rEhmQDdR6FTA/MLNVN3/43HX/H9hJBfH1JX2l4vklDpweAv3w+kQIX9/uPWNqOUEfXOQhOn1zTQdd43TYFdiMB87SSSztAAAAAElFTkSuQmCC"
                    alt="Total"/>
                <p class="ml-2">Total</p>
              </div>
              <div class="flex mt-2">
                <div class="w-1/3">
                  <p class="text-xs text-gray-600">Consulted Patients</p>
                  <p class="mt-2">
                    {{ prettyNumber(Object.keys(globalData).length) }}
                  </p>
                </div>
                <div class="w-1/3 pl-2 border-l border-r border-gray-500">
                  <p class="text-xs text-gray-6Cameroon00">Registered Patients</p>
                  <p class="mt-2">
                    {{ prettyNumber(patients.length) }}
                  </p>
                </div>
                <div class="w-1/3 pl-2">
                  <p class="text-xs text-gray-600">Total consultation</p>
                  <p class="mt-2">
                    {{ prettyNumber(consultations.length) }}
                  </p>
                </div>
              </div>
            </div>

          </div>

          <div class="w-full mt-4 overflow-hidden border border-gray-500 rounded-lg">
            <div class="flex items-center p-4">
              <img :src="`https://www.countryflags.io/CM/flat/32.png`"
                   :alt="CM"/>
              <p class="ml-2" v-if="selectedCountry">
                {{ selectedCountry.name }} - Consultation Evolution
              </p>
            </div>
            <div class="p-4 border-t border-b border-gray-500" id="chart"></div>
            <div class="flex flex-col p-4 border-gray-500">

            </div>
          </div>

          <div class="w-full mt-4 overflow-hidden border border-gray-500 rounded-lg">
            <div class="flex items-center p-4">
              <img
                  src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAMAAADXqc3KAAAARVBMVEUAAABChfRChfRBhfRChfRBhPVAhvVBhfRChfRChPRBhfNChPRChfNChPRAh/dAhfRChfNBhPRBhPNBhPRBhPNAhfRBhPS7Bx6gAAAAF3RSTlMAYJ/P/09Q35DgwI/wcCAwgKCw0O9vv5uoiNwAAACdSURBVHgBndAFFsJAEATRhhQrcb//UXmDS/yvu+i40zmB5HzRN+d58E4fAsRImlpO9tmfFyWUloqc8NqHvFJNI7UUquC5W6SQOms6EqnAP+7DHyfT8KeR6aik+n5ksF0rEhmQDdR6FTA/MLNVN3/43HX/H9hJBfH1JX2l4vklDpweAv3w+kQIX9/uPWNqOUEfXOQhOn1zTQdd43TYFdiMB87SSSztAAAAAElFTkSuQmCC"
                  alt="Total"/>
              <p class="ml-2">Nation Wide Overview</p>
            </div>
            <div class="p-4 border-t border-b border-gray-500">
              <table class="w-full table-fixed">
                <thead class="py-2 font-light text-left border-b border-gray-500">
                <th @click='fsortBy("Country")' class="md:w-1/2 text-sm font-normal text-gray-500 cursor-pointer">
                  Regions
                </th>
                <th @click='fsortBy("TotalConfirmed")'
                    class="text-xs font-normal text-gray-500 cursor-pointer w-1/8">
                  Patients
                </th>
                <th @click='fsortBy("TotalRecovered")'
                    class="text-xs font-normal text-gray-500 cursor-pointer w-1/8">
                  Consultation
                </th>
                <th @click='fsortBy("TotalDeaths")'
                    class="text-xs font-normal text-gray-500 cursor-pointer w-1/8">
                  Individuel
                </th>
                </thead>
                <tbody>
                <tr class="text-sm border-b border-gray-500" v-for="(country, index) of sortedCountry"
                    :key="index">
                  <td class="flex items-center py-2">
                    <img :src="`https://www.countryflags.io/CM/flat/32.png`"
                         :alt="CM"/>
                    <p class="ml-2 hidden md:block">{{ country.name }}</p>
                    <p class="ml-2 md:hidden">{{country.code}}</p>
                  </td>
                  <td class="py-2 text-xs  md:text-base">
                    {{ prettyNumber(patients.filter(x => x.createdAt=== country.id).length) }}
                  </td>
                  <td class="py-2 text-xs  md:text-base">
                    {{ prettyNumber(consultations.filter(x => x.consultedAt=== country.id).length) }}
                  </td>
                  <td class="py-2 text-xs  md:text-base">
                    {{ prettyNumber(patients.filter(x => x.createdAt=== country.id).length) }}
                  </td>
                </tr>
                </tbody>
              </table>
            </div>

          </div>
        </div>
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
import {useRouter} from "vue-router";
import {logIn, personAdd} from "ionicons/icons";

window.consult = consult;
window.regions = regions;
window.patients = patients;
export default {
  name: "Statistics",
  setup() {
    const router = useRouter();
    return {
      router,

    };
  },
  // eslint-disable-next-line no-undef
  components: {IonPage, IonHeader, IonContent},
  data: () => ({
    data: {
      cameroon: {},
      Global: {},
    },
    countryData: null,
    selectedCountry: null,
    selected: 0,
    countries: window.regions,
    consultations: window.consult,
    patients: window.patients,
    sortBy: "TotalConfirmed",
    desc: true,
  }),
  methods: {
    prettyNumber(num) {
      return num ? window.Sugar.Number.format(num) : 0;
    },


    createChart() {
      const ctx = document.getElementById("chart");
      ctx.innerHTML = "";
      const canvas = document.createElement("canvas");
      //canvas.style.border = '1px solid red'
      ctx.appendChild(canvas);
      console.log(
          this.countryData.map((x) => ({
            x: new Date(x.date),
            y: x.data,
          })).sort((a, b) => a.date - b.date)
      );
      const myChart = new window.Chart(canvas, {
        type: "line",

        data: {
          labels: [
            new Date(this.countryData[0].date).toLocaleString(),
            new Date(
                this.countryData[this.countryData.length - 1].date
            ).toLocaleString(),
          ],
          datasets: [
            {
              label: "Tested",
              data: this.countryData.map((a) => ({
                x: new Date(a.date),
                y: a.data,
              })).sort((a, b) => a.date - b.date),

              borderWidth: 1,
              fill: false,
              borderColor: "#0080ff",
            },

          ],
        },
        options: {
          title: {
            display: false,
            text: `Batches statistics`,
          },
          scales: {
            xAxes: [
              {
                type: "time",
                distribution: "linear",
                time: {
                  unit: "day",
                  tooltipFormat: "MMM D YYYY",
                },
                bounds: "data",
              },
            ],
            yAxes: [
              {
                ticks: {
                  beginAtZero: true,
                  precision: 0,
                  padding: 0,
                },
              },
            ],
          },
        },
      });
    },
    selectCountry() {
      if (
          !this.selectedCountry ||
          (this.selectedCountry &&
              this.selectedCountry.code !== this.selected)
      ) {
        this.selectedCountry = this.countries.find(
            (x) => x.code === this.selected
        );
        this.fetchFor(this.selectedCountry);
      }
    },
    fsortBy(value) {
      if (value === this.sortBy) {
        this.desc = !this.desc;
      } else {
        this.sortBy = value;
        this.desc = false;
      }
    },
    async fetch() {
      this.selected = this.countries[1].code;
      this.selectedCountry = this.countries[1];
      await this.fetchFor(this.countries[1]);
    },

    async fetchFor(region) {
      console.log(region)
      let data = this.consultations.filter(x => x.consultedAt === region.id)
      console.log(data);
      data = window.Sugar.Array.groupBy(data, "date");
      data = Object.entries(data).map(x => ({"date": x[0], "data": x[1].length}));
      data = window.Sugar.Array(data)
      data.sortBy((x) => new Date(x.date), false)
      data = data.raw
      console.log(data);
      this.countryData = data;
      this.createChart();
    },
  },
  mounted() {

    console.log("Gobal data")
    console.log(this.globalData)
    this.fetch();
  },
  computed: {
    globalData() {
      const array = window.Sugar.Array.groupBy(this.consultations, "patientID");


      return array;
    },
    sortedCountry() {
      const array = window.Sugar.Array([...this.countries]);
      array.sortBy(this.sortBy, this.desc);
      console.log(array);
      return array.raw;
    },
  },
}
</script>

<style scoped>

</style>