<template>
  <header class="w-full border-b border-blue-600 bg-white">
    <div
      class="max-w-[1440px] mx-auto px-4 py-3 flex items-center justify-between"
    >
      <div class="flex items-center gap-3">
        <div
          class="w-10 h-10 rounded bg-gradient-to-br from-blue-600 to-indigo-600 flex items-center justify-center text-white font-bold"
        >
          T
        </div>
        <RouterLink to="/" class="text-lg font-semibold">TicketApp</RouterLink>
      </div>
      <nav class="flex items-center gap-4">
        <RouterLink
          to="/tickets"
          class="hidden md:inline-block font-bold"
          :class="
            isActive('/tickets')
              ? 'text-blue-600'
              : 'text-gray-600 hover:text-blue-500'
          "
        >
          Tickets
        </RouterLink>
        <RouterLink
          to="/dashboard"
          class="hidden md:inline-block font-bold"
          :class="
            isActive('/dashboard')
              ? 'text-blue-600'
              : 'text-gray-600 hover:text-blue-500'
          "
        >
          Dashboard
        </RouterLink>
        <template v-if="session">
          <button @click="logout" class="btn-ghost">Logout</button>
        </template>
        <template v-else>
          <div class="flex gap-2">
            <RouterLink
              to="/auth/login"
              class="btn"
              :class="isActive('/auth/login') ? 'bg-blue-600 text-white' : ''"
            >
              Login
            </RouterLink>
            <RouterLink
              to="/auth/signup"
              class="btn-outline"
              :class="
                isActive('/auth/signup') ? 'border-blue-600 text-blue-600' : ''
              "
            >
              Get Started
            </RouterLink>
          </div>
        </template>
      </nav>
    </div>
  </header>
</template>

<script lang="ts">
import { defineComponent, computed } from "vue";
import { RouterLink, useRoute, useRouter } from "vue-router";
import { getSession, clearSession } from "../services/session";

export default defineComponent({
  components: { RouterLink },
  setup() {
    const router = useRouter();
    const route = useRoute();
    const session = computed(() => getSession());

    function logout() {
      clearSession();
      router.push("/");
    }

    const isActive = (path: string) => {
      return route.path == path;
    };

    return { session, logout, isActive };
  },
});
</script>
