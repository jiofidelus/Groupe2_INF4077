import {createRouter, createWebHistory} from '@ionic/vue-router';
import {RouteRecordRaw} from 'vue-router';
import Tabs from '../views/Tabs.vue'
import Login from '../views/Login.vue'
import Home from '../views/Home.vue'
import Patient from '../views/Patient.vue'
import NewPatient from "@/views/NewPatient.vue";
import Page from "@/views/Page.vue";
import Statistics from "@/views/Statistics.vue";
import Maps from "@/views/Maps.vue";
import Checker from "@/views/Checker.vue";

const routes: Array<RouteRecordRaw> = [
    {
        path: '/',
        redirect: '/login/'
    },{
        path: '/page/',
      component: Page
    },


    {
        path: '/login/',
        component: Login
    },

    {
        path: '/tabs/',
        component: Tabs,
        children: [
            {
                path:"home",
                component: Home
            },
            {
                path: "patients",
                component: Patient
            },
            {
                path: 'patients/new',
                component: NewPatient
            },
            {
                path:"checker",
                component: Checker
            },
            {
                path:"stats/maps",
                component: Maps
            },
            {
                path:"stats",
                component: Statistics
            },
            {
                path: '',
                redirect: 'home'
            },
            {
                path: 'tab1',
                component: () => import('@/views/Tab1.vue')
            },
            {
                path: 'tab2',
                component: () => import('@/views/Tab2.vue')
            },
            {
                path: 'tab3',
                component: () => import('@/views/Tab3.vue')
            },
            {
                path: 'tab4',
                component: () => import('@/views/Patient.vue')
            },
            {
                path: 'tab5',
                component: () => import('@/views/Nouveau.vue')
            }
        ]
    }
]

const router = createRouter({
    history: createWebHistory(process.env.BASE_URL),
    routes
})

export default router
