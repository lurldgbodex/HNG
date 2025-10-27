<template>
  <div class="min-h-screen flex flex-col bg-gray-50">
    <AppHeader />
    <main class="flex-1 max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
      <!-- Header Section -->
      <div
        class="flex flex-col sm:flex-row sm:items-center sm:justify-between mb-8"
      >
        <div class="mb-4 sm:mb-0">
          <h1 class="text-3xl font-bold text-gray-900">Tickets</h1>
          <p class="text-gray-600 mt-2">
            Manage and track all your support tickets
          </p>
        </div>
        <button
          class="btn-primary flex items-center gap-2 px-6 py-3 bg-blue-600 hover:bg-blue-700 text-white font-semibold rounded-lg transition-colors duration-200"
          @click="openCreate = true"
        >
          <svg
            class="w-5 h-5"
            fill="none"
            stroke="currentColor"
            viewBox="0 0 24 24"
          >
            <path
              stroke-linecap="round"
              stroke-linejoin="round"
              stroke-width="2"
              d="M12 4v16m8-8H4"
            />
          </svg>
          Create Ticket
        </button>
      </div>

      <!-- Stats Grid -->
      <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6 mb-8">
        <StatsCard
          title="Total Tickets"
          :value="tickets.length"
          icon="📊"
          gradient="from-blue-500 to-blue-600"
        />
        <StatsCard
          title="Open"
          :value="counts.open"
          icon="🔴"
          gradient="from-red-500 to-red-600"
        />
        <StatsCard
          title="In Progress"
          :value="counts.in_progress"
          icon="🟡"
          gradient="from-yellow-500 to-yellow-600"
        />
        <StatsCard
          title="Closed"
          :value="counts.closed"
          icon="🟢"
          gradient="from-green-500 to-green-600"
        />
      </div>

      <!-- Priority Overview -->
      <div class="grid grid-cols-1 md:grid-cols-3 gap-6 mb-8">
        <div class="bg-white rounded-xl shadow-sm p-6 border border-gray-200">
          <div class="flex items-center gap-3 mb-4">
            <div class="w-3 h-3 bg-red-500 rounded-full"></div>
            <h3 class="font-semibold text-gray-900">High Priority</h3>
          </div>
          <p class="text-2xl font-bold text-gray-900">
            {{ priorityCounts.high }}
          </p>
          <p class="text-sm text-gray-600 mt-1">Requires immediate attention</p>
        </div>
        <div class="bg-white rounded-xl shadow-sm p-6 border border-gray-200">
          <div class="flex items-center gap-3 mb-4">
            <div class="w-3 h-3 bg-yellow-500 rounded-full"></div>
            <h3 class="font-semibold text-gray-900">Medium Priority</h3>
          </div>
          <p class="text-2xl font-bold text-gray-900">
            {{ priorityCounts.medium }}
          </p>
          <p class="text-sm text-gray-600 mt-1">Normal priority tasks</p>
        </div>
        <div class="bg-white rounded-xl shadow-sm p-6 border border-gray-200">
          <div class="flex items-center gap-3 mb-4">
            <div class="w-3 h-3 bg-blue-500 rounded-full"></div>
            <h3 class="font-semibold text-gray-900">Low Priority</h3>
          </div>
          <p class="text-2xl font-bold text-gray-900">
            {{ priorityCounts.low }}
          </p>
          <p class="text-sm text-gray-600 mt-1">Can be addressed later</p>
        </div>
      </div>

      <!-- Tickets List -->
      <div
        class="bg-white rounded-xl shadow-sm border border-gray-200 overflow-hidden"
      >
        <div class="px-6 py-4 border-b border-gray-200">
          <h2 class="text-lg font-semibold text-gray-900">All Tickets</h2>
        </div>
        <div class="divide-y divide-gray-200">
          <div v-if="tickets.length === 0" class="text-center py-12">
            <div class="text-gray-400 mb-4">
              <svg
                class="w-16 h-16 mx-auto"
                fill="none"
                stroke="currentColor"
                viewBox="0 0 24 24"
              >
                <path
                  stroke-linecap="round"
                  stroke-linejoin="round"
                  stroke-width="1"
                  d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"
                />
              </svg>
            </div>
            <h3 class="text-lg font-medium text-gray-900 mb-2">
              No tickets yet
            </h3>
            <p class="text-gray-600 mb-4">
              Get started by creating your first ticket
            </p>
            <button
              class="btn-primary inline-flex items-center gap-2 px-4 py-2 bg-blue-600 hover:bg-blue-700 text-white font-medium rounded-lg transition-colors duration-200"
              @click="openCreate = true"
            >
              Create Ticket
            </button>
          </div>
          <TicketCard
            v-for="t in tickets"
            :key="t.id"
            :ticket="t"
            @edit="startEdit"
            @delete="handleDelete"
          />
        </div>
      </div>

      <Modal :open="openCreate" @close="openCreate = false">
        <template #title>Create ticket</template>
        <form @submit.prevent="handleCreate" class="space-y-3">
          <label>Title<input v-model="form.title" class="input" /></label>
          <div v-if="errors.title" class="text-sm text-red-600">
            {{ errors.title }}
          </div>
          <label
            >Status
            <select v-model="form.status" class="input">
              <option value="open">open</option>
              <option value="in_progress">in_progress</option>
              <option value="closed">closed</option>
            </select>
          </label>
          <div v-if="errors.status" class="text-sm text-red-600">
            {{ errors.status }}
          </div>
          <label
            >Description<textarea
              v-model="form.description"
              class="input h-24"
            />
          </label>
          <div class="flex gap-2">
            <button class="btn" type="submit">Create</button>
            <button
              type="button"
              class="btn-outline"
              @click="openCreate = false"
            >
              Cancel
            </button>
          </div>
        </form>
      </Modal>

      <Modal :open="!!editing" @close="editing = null">
        <template #title>Edit ticket</template>
        <form
          v-if="editing"
          @submit.prevent="handleEditSubmit"
          class="space-y-3"
        >
          <label>Title<input v-model="editing.title" class="input" /></label>
          <div v-if="errors.title" class="text-sm text-red-600">
            {{ errors.title }}
          </div>
          <label
            >Status
            <select v-model="editing.status" class="input">
              <option value="open">open</option>
              <option value="in_progress">in_progress</option>
              <option value="closed">closed</option>
            </select>
          </label>
          <div v-if="errors.status" class="text-sm text-red-600">
            {{ errors.status }}
          </div>
          <label
            >Description<textarea
              v-model="editing.description"
              class="input h-24"
            />
          </label>
          <div class="flex gap-2">
            <button class="btn" type="submit">Save</button>
            <button type="button" class="btn-outline" @click="editing = null">
              Cancel
            </button>
          </div>
        </form>
      </Modal>
    </main>
    <AppFooter />
  </div>
</template>

<script lang="ts">
import { useLocalState } from "../composables/useLocalState";
import type { Ticket } from "../types";
import { validateTicketInput } from "../utils/validator";
import { useToast } from "../composables/useToast";
import { defineComponent, reactive, computed, toRefs } from "vue";
import AppHeader from "../components/AppHeader.vue";
import AppFooter from "../components/AppFooter.vue";
import TicketCard from "../components/TicketCard.vue";
import Modal from "../components/Modal.vue";
import StatsCard from "../components/StatsCard.vue";

function createTicket(payload: Partial<Ticket>): Ticket {
  const now = new Date().toISOString();
  return {
    id: Math.random().toString(36).slice(2),
    title: payload.title || "Untitled",
    description: payload.description || "",
    priority: payload.priority || "medium",
    status: (payload.status as Ticket["status"]) || "open",
    createdAt: now,
  };
}

export default defineComponent({
  components: { AppHeader, AppFooter, TicketCard, Modal, StatsCard },
  setup() {
    const ticketsRef = useLocalState<Ticket[]>("ticketapp_tickets", []);
    const tickets = ticketsRef.value;
    const state = reactive({
      openCreate: false,
      editing: null as Ticket | null,
      form: { title: "", status: "open", description: "" } as Partial<Ticket>,
      errors: {} as Record<string, string>,
    });
    const toast = useToast();

    function reloadEmptyForm() {
      state.form = { title: "", status: "open", description: "" };
      state.errors = {};
    }

    function handleCreate() {
      state.errors = validateTicketInput({
        title: state.form.title,
        status: state.form.status,
      });
      if (Object.keys(state.errors).length) return;
      const t = createTicket(state.form);
      tickets.unshift(t);
      toast.push({ type: "success", message: "Ticket created" });
      state.openCreate = false;
      reloadEmptyForm();
    }

    function startEdit(t: Ticket) {
      state.editing = { ...t };
    }

    function handleEditSubmit() {
      if (!state.editing) return;
      state.errors = validateTicketInput({
        title: state.editing.title,
        status: state.editing.status,
      });
      if (Object.keys(state.errors).length) return;
      const idx = tickets.findIndex((x) => x.id === state.editing!.id);
      if (idx !== -1) {
        tickets[idx] = {
          ...state.editing!,
          updatedAt: new Date().toISOString(),
        };
      }
      state.editing = null;
      toast.push({ type: "success", message: "Ticket updated" });
    }

    function handleDelete(id: string) {
      if (confirm("Delete this ticket?")) {
        const idx = tickets.findIndex((x) => x.id === id);
        if (idx !== -1) tickets.splice(idx, 1);
        toast.push({ type: "success", message: "Ticket deleted" });
      }
    }

    const counts = computed(() => ({
      open: tickets.filter((t) => t.status === "open").length,
      in_progress: tickets.filter((t) => t.status === "in_progress").length,
      closed: tickets.filter((t) => t.status === "closed").length,
    }));

    const priorityCounts = computed(() => ({
      high: tickets.filter((t) => t.priority === "high").length,
      medium: tickets.filter((t) => t.priority === "medium").length,
      low: tickets.filter((t) => t.priority === "low").length,
    }));

    return {
      tickets,
      ...toRefs(state),
      handleCreate,
      startEdit,
      handleEditSubmit,
      handleDelete,
      counts,
      priorityCounts,
    };
  },
});
</script>
