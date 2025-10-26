<template>
  <div
    class="relative overflow-hidden min-h-screen flex flex-col items-center justify-center text-center bg-gradient-to-b from-blue-50 to-white"
  >
    <AppHeader />

    <!-- Decorative circles -->
    <!-- <div
      class="absolute top-16 left-10 w-24 h-24 bg-blue-200 rounded-full blur-2xl opacity-40 animate-pulse"
    ></div>
    <div
      class="absolute bottom-16 right-10 w-32 h-32 bg-indigo-300 rounded-full blur-3xl opacity-50 animate-pulse"
    ></div> -->

    <div class="z-10 px-4 max-w-3xl mt-10">
      <h1 class="text-4xl sm:text-5xl font-extrabold text-gray-900 mb-4">
        Manage Your <span class="text-blue-600">Event Tickets</span> with Ease
      </h1>
      <p class="text-gray-600 text-lg sm:text-xl mb-6">
        From planning to execution — simplify your ticket handling, streamline
        your events, and elevate attendee experiences.
      </p>
      <div class="flex flex-col sm:flex-row gap-4 justify-center">
        <router-link to="/auth/signup" class="btn">Get Started</router-link>
        <router-link to="/auth/login" class="btn-outline">Login</router-link>
      </div>
    </div>

    <section
      class="relative z-10 mt-20 grid grid-cols-1 md:grid-cols-3 gap-6 px-6 max-w-6xl w-full align-middle mx-auto"
    >
      <div
        class="bg-white shadow-md rounded-2xl p-6 hover:shadow-xl transition"
      >
        <h3 class="text-xl font-semibold text-gray-900 mb-2">
          Create Tickets Instantly
        </h3>
        <p class="text-gray-600">
          Quickly generate new tickets for your events and manage them all in
          one place.
        </p>
      </div>
      <div
        class="bg-white shadow-md rounded-2xl p-6 hover:shadow-xl transition"
      >
        <h3 class="text-xl font-semibold text-gray-900 mb-2">
          Track Ticket Status
        </h3>
        <p class="text-gray-600">
          Stay updated with ticket progress — open, in progress, or closed — in
          real time.
        </p>
      </div>
      <div
        class="bg-white shadow-md rounded-2xl p-6 hover:shadow-xl transition"
      >
        <h3 class="text-xl font-semibold text-gray-900 mb-2">
          Analyze & Optimize
        </h3>
        <p class="text-gray-600">
          Gain insights into ticket performance and make informed decisions
          effortlessly.
        </p>
      </div>
    </section>

    <AppFooter />
  </div>
</template>

<script lang="ts">
import { defineComponent } from "vue";
import AppHeader from "../components/AppHeader.vue";
import AppFooter from "../components/AppFooter.vue";

export default defineComponent({ components: { AppHeader, AppFooter } });
</script>
