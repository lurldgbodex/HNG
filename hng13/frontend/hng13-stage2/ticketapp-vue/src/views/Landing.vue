<template>
  <div
    class="relative overflow-hidden min-h-screen flex flex-col items-center justify-center text-center bg-gradient-to-b from-blue-50 to-white"
  >
    <!-- Wavy Background -->
    <div class="absolute inset-0 z-0 pointer-events-none">
      <svg
        class="w-full h-full"
        viewBox="0 0 1200 800"
        preserveAspectRatio="none"
      >
        <path
          d="M0,96L48,112C96,128,192,160,288,186.7C384,213,480,235,576,213.3C672,192,768,128,864,128C960,128,1056,192,1152,208C1248,224,1344,192,1392,176L1440,160L1440,320L1392,320C1344,320,1248,320,1152,320C1056,320,960,320,864,320C768,320,672,320,576,320C480,320,384,320,288,320C192,320,96,320,48,320L0,320Z"
          fill="#3b82f6"
          fill-opacity="0.1"
        ></path>
        <path
          d="M0,256L48,261.3C96,267,192,277,288,266.7C384,256,480,224,576,224C672,224,768,256,864,261.3C960,267,1056,245,1152,229.3C1248,213,1344,203,1392,197.3L1440,192L1440,320L1392,320C1344,320,1248,320,1152,320C1056,320,960,320,864,320C768,320,672,320,576,320C480,320,384,320,288,320C192,320,96,320,48,320L0,320Z"
          fill="#60a5fa"
          fill-opacity="0.05"
        ></path>
      </svg>
    </div>

    <!-- Decorative Circles -->
    <div
      class="absolute top-20 left-10 w-20 h-20 bg-blue-200 rounded-full opacity-20 blur-xl pointer-events-none"
    ></div>
    <div
      class="absolute bottom-40 right-10 w-16 h-16 bg-indigo-300 rounded-full opacity-30 blur-lg pointer-events-none"
    ></div>
    <div
      class="absolute top-1/3 right-1/4 w-12 h-12 bg-purple-200 rounded-full opacity-25 blur-lg pointet-events-none"
    ></div>
    <div
      class="absolute bottom-1/4 left-1/3 w-24 h-24 bg-blue-100 rounded-full opacity-20 blur-xl pointer-events-none"
    ></div>

    <div class="relative z-20 w-full">
      <AppHeader />
    </div>
    <div class="z-10 px-4 max-w-3xl mt-10">
      <h1 class="text-4xl sm:text-5xl font-extrabold text-gray-900 mb-4">
        Manage Your <span class="text-blue-600">Event Tickets</span> with Ease
      </h1>
      <p class="text-gray-600 text-lg sm:text-xl mb-6">
        From planning to execution — simplify your ticket handling, streamline
        your events, and elevate attendee experiences.
      </p>
      <div class="flex flex-col sm:flex-row gap-4 justify-center">
        <template v-if="session">
          <router-link to="/tickets" class="btn"
            >Create a New Ticket</router-link
          >
          <router-link to="/dashboard" class="btn-outline"
            >View Dashboard</router-link
          >
        </template>
        <template v-else>
          <router-link to="/auth/signup" class="btn">Get Started</router-link>
          <router-link to="/auth/login" class="btn-outline">Login</router-link>
        </template>
      </div>
    </div>

    <section
      class="relative z-10 mt-20 grid grid-cols-1 md:grid-cols-3 gap-8 px-6 max-w-6xl w-full align-middle mx-auto"
    >
      <!-- Enhanced Feature Boxes -->
      <div
        class="bg-white rounded-2xl p-8 shadow-lg hover:shadow-2xl transition-all duration-300 border border-gray-100 transform hover:-translate-y-2"
      >
        <div
          class="w-16 h-16 bg-gradient-to-br from-blue-500 to-blue-600 rounded-2xl flex items-center justify-center text-white text-2xl font-bold mb-4 mx-auto"
        >
          ⚡
        </div>
        <h3 class="text-xl font-semibold text-gray-900 mb-3">
          Create Tickets Instantly
        </h3>
        <p class="text-gray-600 leading-relaxed">
          Quickly generate new tickets for your events and manage them all in
          one place with our intuitive interface.
        </p>
      </div>

      <div
        class="bg-white rounded-2xl p-8 shadow-lg hover:shadow-2xl transition-all duration-300 border border-gray-100 transform hover:-translate-y-2"
      >
        <div
          class="w-16 h-16 bg-gradient-to-br from-green-500 to-green-600 rounded-2xl flex items-center justify-center text-white text-2xl font-bold mb-4 mx-auto"
        >
          📊
        </div>
        <h3 class="text-xl font-semibold text-gray-900 mb-3">
          Track Ticket Status
        </h3>
        <p class="text-gray-600 leading-relaxed">
          Stay updated with ticket progress — open, in progress, or closed — in
          real time with detailed analytics.
        </p>
      </div>

      <div
        class="bg-white rounded-2xl p-8 shadow-lg hover:shadow-2xl transition-all duration-300 border border-gray-100 transform hover:-translate-y-2"
      >
        <div
          class="w-16 h-16 bg-gradient-to-br from-purple-500 to-purple-600 rounded-2xl flex items-center justify-center text-white text-2xl font-bold mb-4 mx-auto"
        >
          📈
        </div>
        <h3 class="text-xl font-semibold text-gray-900 mb-3">
          Analyze & Optimize
        </h3>
        <p class="text-gray-600 leading-relaxed">
          Gain insights into ticket performance and make informed decisions
          effortlessly with comprehensive reports.
        </p>
      </div>
    </section>

    <!-- Additional Content Section -->
    <section class="relative z-10 mt-20 px-6 max-w-4xl w-full">
      <div
        class="bg-gradient-to-br from-blue-50 to-indigo-50 rounded-3xl p-8 shadow-xl border border-blue-100"
      >
        <div class="grid grid-cols-1 md:grid-cols-2 gap-8 items-center">
          <div>
            <h2 class="text-3xl font-bold text-gray-900 mb-4">
              Ready to Transform Your Event Management?
            </h2>
            <p class="text-gray-600 text-lg mb-6">
              Join thousands of event organizers who trust our platform to
              handle their ticket management needs efficiently.
            </p>
            <router-link
              v-if="session"
              to="/tickets"
              class="btn bg-blue-600 hover:bg-blue-700 text-white"
            >
              Start Creating Tickets
            </router-link>
            <router-link
              v-else
              to="/auth/signup"
              class="btn bg-blue-600 hover:bg-blue-700 text-white"
            >
              Sign Up Free
            </router-link>
          </div>
          <div class="relative">
            <div
              class="w-64 h-64 bg-white rounded-2xl shadow-lg mx-auto flex items-center justify-center"
            >
              <div class="text-6xl">🎫</div>
            </div>
            <!-- Floating decorative elements -->
            <div
              class="absolute -top-4 -right-4 w-8 h-8 bg-yellow-400 rounded-full opacity-80"
            ></div>
            <div
              class="absolute -bottom-4 -left-4 w-6 h-6 bg-green-400 rounded-full opacity-80"
            ></div>
          </div>
        </div>
      </div>
    </section>

    <AppFooter />
  </div>
</template>

<script lang="ts">
import { defineComponent, computed } from "vue";
import AppHeader from "../components/AppHeader.vue";
import AppFooter from "../components/AppFooter.vue";
import { getSession } from "../services/session";

export default defineComponent({
  components: { AppHeader, AppFooter },
  setup() {
    const session = computed(() => getSession());

    return { session };
  },
});
</script>
