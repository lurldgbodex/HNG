<template>
  <article class="bg-white rounded-lg shadow p-4 flex flex-col gap-3">
    <div class="flex items-start justify-between">
      <div>
        <h4 class="font-semibold">{{ ticket.title }}</h4>
        <p class="text-sm text-slate-500">{{ ticket.description }}</p>
      </div>
      <div class="text-right">
        <span
          :class="[
            'inline-block px-2 py-1 text-xs rounded-full',
            statusColor(ticket.status),
          ]"
          >{{ ticket.status.replace("_", " ") }}</span
        >
        <div class="mt-2 flex gap-2">
          <button class="text-sm btn-ghost" @click="$emit('edit', ticket)">
            Edit
          </button>
          <button
            class="text-sm btn-ghost text-red-600"
            @click="$emit('delete', ticket.id)"
          >
            Delete
          </button>
        </div>
      </div>
    </div>
    <div class="text-xs text-slate-400">
      Created: {{ new Date(ticket.createdAt).toLocaleString() }}
    </div>
  </article>
</template>

<script lang="ts">
import { defineComponent, type PropType } from "vue";
import type { Ticket } from "../types/index";

export default defineComponent({
  props: { ticket: { type: Object as PropType<Ticket>, required: true } },
  methods: {
    statusColor(s: Ticket["status"]) {
      if (s === "open") return "bg-green-100 text-green-800";
      if (s === "in_progress") return "bg-amber-100 text-amber-800";
      return "bg-gray-100 text-gray-700";
    },
  },
});
</script>
