<template>
  <div class="min-h-screen flex flex-col bg-gray-50">
    <AppHeader />
    <main class="flex-1 max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
      <!-- Header Section -->
      <div class="mb-8">
        <h1 class="text-3xl font-bold text-gray-900">Dashboard</h1>
        <p class="text-gray-600 mt-2">
          Overview of your ticket management system
        </p>
      </div>

      <!-- Key Metrics Grid -->
      <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6 mb-8">
        <!-- Total Tickets Card -->
        <div
          class="bg-white rounded-xl shadow-sm border border-gray-200 p-6 hover:shadow-md transition-shadow duration-200"
        >
          <div class="flex items-center justify-between">
            <div>
              <p class="text-sm font-medium text-gray-600">Total Tickets</p>
              <p class="text-3xl font-bold text-gray-900 mt-2">{{ total }}</p>
            </div>
            <div
              class="w-12 h-12 bg-gradient-to-r from-blue-500 to-blue-600 rounded-lg flex items-center justify-center"
            >
              <span class="text-white text-xl">📊</span>
            </div>
          </div>
          <div class="mt-4">
            <div class="flex items-center text-sm text-gray-600">
              <span>All time tickets</span>
            </div>
          </div>
        </div>

        <!-- Open Tickets Card -->
        <div
          class="bg-white rounded-xl shadow-sm border border-gray-200 p-6 hover:shadow-md transition-shadow duration-200"
        >
          <div class="flex items-center justify-between">
            <div>
              <p class="text-sm font-medium text-gray-600">Open Tickets</p>
              <p class="text-3xl font-bold text-gray-900 mt-2">{{ open }}</p>
            </div>
            <div
              class="w-12 h-12 bg-gradient-to-r from-red-500 to-red-600 rounded-lg flex items-center justify-center"
            >
              <span class="text-white text-xl">🔴</span>
            </div>
          </div>
          <div class="mt-4">
            <div class="flex items-center text-sm text-gray-600">
              <span>Requiring attention</span>
            </div>
          </div>
        </div>

        <!-- In Progress Card -->
        <div
          class="bg-white rounded-xl shadow-sm border border-gray-200 p-6 hover:shadow-md transition-shadow duration-200"
        >
          <div class="flex items-center justify-between">
            <div>
              <p class="text-sm font-medium text-gray-600">In Progress</p>
              <p class="text-3xl font-bold text-gray-900 mt-2">
                {{ inProgress }}
              </p>
            </div>
            <div
              class="w-12 h-12 bg-gradient-to-r from-yellow-500 to-yellow-600 rounded-lg flex items-center justify-center"
            >
              <span class="text-white text-xl">🟡</span>
            </div>
          </div>
          <div class="mt-4">
            <div class="flex items-center text-sm text-gray-600">
              <span>Currently being worked on</span>
            </div>
          </div>
        </div>

        <!-- Resolved Card -->
        <div
          class="bg-white rounded-xl shadow-sm border border-gray-200 p-6 hover:shadow-md transition-shadow duration-200"
        >
          <div class="flex items-center justify-between">
            <div>
              <p class="text-sm font-medium text-gray-600">Resolved</p>
              <p class="text-3xl font-bold text-gray-900 mt-2">
                {{ resolved }}
              </p>
            </div>
            <div
              class="w-12 h-12 bg-gradient-to-r from-green-500 to-green-600 rounded-lg flex items-center justify-center"
            >
              <span class="text-white text-xl">🟢</span>
            </div>
          </div>
          <div class="mt-4">
            <div class="flex items-center text-sm text-green-600 font-medium">
              <span>{{ resolutionRate }}% resolution rate</span>
            </div>
          </div>
        </div>
      </div>

      <div class="grid grid-cols-1 lg:grid-cols-2 gap-8">
        <!-- Priority Overview -->
        <div class="bg-white rounded-xl shadow-sm border border-gray-200 p-6">
          <h3 class="text-lg font-semibold text-gray-900 mb-6">
            Priority Overview
          </h3>
          <div class="space-y-4">
            <!-- High Priority -->
            <div
              class="flex items-center justify-between p-3 bg-red-50 rounded-lg border border-red-200"
            >
              <div class="flex items-center gap-3">
                <div class="w-3 h-3 bg-red-500 rounded-full"></div>
                <span class="font-medium text-gray-900"> High Priority </span>
              </div>
              <div class="flex items-center gap-2">
                <span class="text-lg font-bold text-gray-900">
                  {{ highPriority }}
                </span>
                <span class="text-sm text-gray-600">tickets</span>
              </div>
            </div>

            <!-- Medium Priority -->
            <div
              class="flex items-center justify-between p-3 bg-yellow-50 rounded-lg border border-yellow-200"
            >
              <div class="flex items-center gap-3">
                <div class="w-3 h-3 bg-yellow-500 rounded-full"></div>
                <span class="font-medium text-gray-900"> Medium Priority </span>
              </div>
              <div class="flex items-center gap-2">
                <span class="text-lg font-bold text-gray-900">
                  {{ mediumPriority }}
                </span>
                <span class="text-sm text-gray-600">tickets</span>
              </div>
            </div>

            <!-- Low Priority -->
            <div
              class="flex items-center justify-between p-3 bg-blue-50 rounded-lg border border-blue-200"
            >
              <div class="flex items-center gap-3">
                <div class="w-3 h-3 bg-blue-500 rounded-full"></div>
                <span class="font-medium text-gray-900"> Low Priority </span>
              </div>
              <div class="flex items-center gap-2">
                <span class="text-lg font-bold text-gray-900">
                  {{ lowPriority }}
                </span>
                <span class="text-sm text-gray-600">tickets</span>
              </div>
            </div>
          </div>
        </div>

        <!-- Recent Activity -->
        <div class="bg-white rounded-xl shadow-sm border border-gray-200 p-6">
          <div class="flex items-center justify-between mb-6">
            <h3 class="text-lg font-semibold text-gray-900">Recent Tickets</h3>
            <span class="text-sm text-gray-600">
              {{ recentTickets.length }} of {{ total }}
            </span>
          </div>
          <div class="space-y-4">
            <div
              v-if="recentTickets.length === 0"
              class="text-center py-8 text-gray-500"
            >
              <svg
                class="w-12 h-12 mx-auto mb-3 text-gray-400"
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
              <p>No tickets yet</p>
            </div>
            <div
              v-else
              v-for="ticket in recentTickets"
              :key="ticket.id"
              class="flex items-center justify-between p-3 hover:bg-gray-50 rounded-lg transition-colors duration-200"
            >
              <div class="flex items-center gap-3 min-w-0">
                <div
                  class="w-2 h-2 rounded-full"
                  :class="{
                    'bg-red-500': ticket.priority === 'high',
                    'bg-yellow-500': ticket.priority === 'medium',
                    'bg-blue-500': ticket.priority === 'low',
                  }"
                ></div>
                <div class="min-w-0 flex-1">
                  <p class="font-medium text-gray-900 truncate">
                    {{ ticket.title }}
                  </p>
                  <p class="text-sm text-gray-600 capitalize">
                    {{ ticket.status.replace("_", " ") }}
                  </p>
                </div>
              </div>
              <div class="text-sm text-gray-500 whitespace-nowrap ml-4">
                {{ formatDate(ticket.createdAt) }}
              </div>
            </div>
          </div>
        </div>
      </div>

      <!-- Quick Actions -->
      <div
        class="mt-8 bg-white rounded-xl shadow-sm border border-gray-200 p-6"
      >
        <h3 class="text-lg font-semibold text-gray-900 mb-6">Quick Actions</h3>
        <div class="flex flex-col sm:flex-row gap-4">
          <router-link
            to="/tickets"
            class="inline-flex items-center justify-center px-6 py-3 bg-blue-600 hover:bg-blue-700 text-white font-semibold rounded-lg transition-colors duration-200 shadow-sm hover:shadow-md"
          >
            <svg
              class="w-5 h-5 mr-2"
              fill="none"
              stroke="currentColor"
              viewBox="0 0 24 24"
            >
              <path
                stroke-linecap="round"
                stroke-linejoin="round"
                stroke-width="2"
                d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2"
              />
            </svg>
            Manage All Tickets
          </router-link>
          <router-link
            to="/tickets?create=true"
            class="inline-flex items-center justify-center px-6 py-3 bg-green-600 hover:bg-green-700 text-white font-semibold rounded-lg transition-colors duration-200 shadow-sm hover:shadow-md"
          >
            <svg
              class="w-5 h-5 mr-2"
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
            Create New Ticket
          </router-link>
        </div>
      </div>

      <!-- Stats Summary -->
      <div class="mt-8 grid grid-cols-1 md:grid-cols-3 gap-6">
        <div
          class="bg-gradient-to-r from-blue-500 to-blue-600 rounded-xl p-6 text-white"
        >
          <div class="text-sm opacity-90">Avg. Resolution Time</div>
          <div class="text-2xl font-bold mt-2">-</div>
          <div class="text-sm opacity-90 mt-2">Data not tracked</div>
        </div>
        <div
          class="bg-gradient-to-r from-purple-500 to-purple-600 rounded-xl p-6 text-white"
        >
          <div class="text-sm opacity-90">Customer Satisfaction</div>
          <div class="text-2xl font-bold mt-2">-</div>
          <div class="text-sm opacity-90 mt-2">Data not tracked</div>
        </div>
        <div
          class="bg-gradient-to-r from-gray-500 to-gray-600 rounded-xl p-6 text-white"
        >
          <div class="text-sm opacity-90">Team Performance</div>
          <div class="text-2xl font-bold mt-2">-</div>
          <div class="text-sm opacity-90 mt-2">Data not tracked</div>
        </div>
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
    const inProgress = computed(
      () => tickets.filter((t) => t.status === "in_progress").length
    );

    const resolved = computed(
      () => tickets.filter((t) => t.status === "closed").length
    );
    // Priority counts
    const highPriority = computed(
      () => tickets.filter((t) => t.priority === "high").length
    );
    const mediumPriority = computed(
      () => tickets.filter((t) => t.priority === "medium").length
    );
    const lowPriority = computed(
      () => tickets.filter((t) => t.priority === "low").length
    );

    const recentTickets = computed(() =>
      tickets
        .sort(
          (a, b) =>
            new Date(b.createdAt).getTime() - new Date(a.createdAt).getTime()
        )
        .slice(0, 5)
    );

    const formatDate = (dateString: string) => {
      return new Date(dateString).toLocaleDateString();
    };

    const resolutionRate = computed(() => {
      return total.value > 0
        ? Math.round((resolved.value / total.value) * 100)
        : 0;
    });

    return {
      total,
      open,
      inProgress,
      resolved,
      highPriority,
      mediumPriority,
      lowPriority,
      recentTickets,
      resolutionRate,
      formatDate,
    };
  },
});
</script>
