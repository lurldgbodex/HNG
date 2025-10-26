<template>
  <div class="min-h-screen flex flex-col">
    <AppHeader />
    <main class="flex-1 max-w-[1440px] mx-auto px-4 py-6">
      <h2 class="text-2xl font-semibold mb-4">Dashboard</h2>
      <div class="grid grid-cols-1 sm:grid-cols-3 gap-4">
        <div class="p-4 bg-white rounded shadow">
          Total Tickets<br /><span class="text-2xl font-bold">{{ total }}</span>
        </div>
        <div class="p-4 bg-white rounded shadow">
          Open<br /><span class="text-2xl font-bold">{{ open }}</span>
        </div>
        <div class="p-4 bg-white rounded shadow">
          Resolved<br /><span class="text-2xl font-bold">{{ resolved }}</span>
        </div>
      </div>
      <div class="mt-6">
        <router-link to="/tickets" class="btn">Manage tickets</router-link>
      </div>
    </main>
    <AppFooter />
  </div>
</template>

<script lang="ts">
import { defineComponent, computed } from "vue";
import AppHeader from "../components/AppHeader.vue";
import AppFooter from "../components/AppFooter.vue";
import { useLocalState } from "../composables/useLocalState";
import type { Ticket } from "../types/index";

export default defineComponent({
  components: { AppHeader, AppFooter },
  setup() {
    const ticketsRef = useLocalState<Ticket[]>("ticketapp_tickets", []);
    const tickets = ticketsRef.value;
    const total = computed(() => tickets.length);
    const open = computed(
      () => tickets.filter((t) => t.status === "open").length
    );
    const resolved = computed(
      () => tickets.filter((t) => t.status === "closed").length
    );
    return { total, open, resolved };
  },
});
</script>
