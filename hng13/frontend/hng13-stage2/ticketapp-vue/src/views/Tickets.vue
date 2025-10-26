<template>
  <div class="min-h-screen flex flex-col">
    <AppHeader />
    <main class="flex-1 max-w-[1440px] mx-auto px-4 py-6">
      <div class="flex items-center justify-between">
        <h2 class="text-2xl font-semibold">Tickets</h2>
        <div class="flex gap-2">
          <button class="btn" @click="openCreate = true">Create</button>
        </div>
      </div>

      <div class="mt-4 grid grid-cols-1 md:grid-cols-3 gap-4">
        <div class="p-4 bg-white rounded shadow">
          <div>Total: {{ tickets.length }}</div>
          <div>Open: {{ counts.open }}</div>
          <div>In Progress: {{ counts.in_progress }}</div>
          <div>Closed: {{ counts.closed }}</div>
        </div>
        <div class="md:col-span-2 grid grid-cols-1 gap-4">
          <div v-if="tickets.length === 0" class="p-6 bg-white rounded shadow">
            No tickets yet.
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
import { defineComponent, reactive, computed } from "vue";
import AppHeader from "../components/AppHeader.vue";
import AppFooter from "../components/AppFooter.vue";
import TicketCard from "../components/TicketCard.vue";
import Modal from "../components/Modal.vue";

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
  components: { AppHeader, AppFooter, TicketCard, Modal },
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

    return {
      tickets,
      ...state,
      handleCreate,
      startEdit,
      handleEditSubmit,
      handleDelete,
      counts,
    };
  },
});
</script>
