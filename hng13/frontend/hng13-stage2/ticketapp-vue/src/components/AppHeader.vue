<template>
  <header class="w-full border-b bg-white">
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
        <RouterLink to="/tickets" class="hidden md:inline-block"
          >Tickets</RouterLink
        >
        <RouterLink to="/dashboard" class="hidden md:inline-block"
          >Dashboard</RouterLink
        >
        <template v-if="session">
          <button @click="logout" class="btn-ghost">Logout</button>
        </template>
        <template v-else>
          <div class="flex gap-2">
            <RouterLink to="/auth/login" class="btn">Login</RouterLink>
            <RouterLink to="/auth/signup" class="btn-outline"
              >Get Started</RouterLink
            >
          </div>
        </template>
      </nav>
    </div>
  </header>
</template>

<script lang="ts">
import { defineComponent, computed } from "vue";
import { RouterLink, useRouter } from "vue-router";
import { getSession, clearSession } from "../services/session";

export default defineComponent({
  components: { RouterLink },
  setup() {
    const router = useRouter();
    const session = computed(() => getSession());
    function logout() {
      clearSession();
      router.push("/");
    }
    return { session, logout };
  },
});
</script>
