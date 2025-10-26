<template>
  <div class="min-h-screen flex flex-col">
    <AppHeader />
    <div class="max-w-[1440px] mx-auto px-4 py-6">
      <h2 class="text-2xl font-semibold mb-4">Login</h2>
      <form @submit.prevent="submit" class="max-w-md">
        <label class="block mb-2"
          >Username
          <input v-model="username" class="input" />
          <div v-if="errors.username" class="text-sm text-red-600">
            {{ errors.username }}
          </div>
        </label>
        <label class="block mb-2"
          >Password
          <input type="password" v-model="password" class="input" />
          <div v-if="errors.password" class="text-sm text-red-600">
            {{ errors.password }}
          </div>
        </label>
        <div class="flex gap-3 mt-3">
          <button class="btn" type="submit">Login</button>
          <router-link to="/auth/signup" class="btn-outline"
            >Create account</router-link
          >
        </div>
      </form>
    </div>
  </div>
</template>

<script lang="ts">
import { defineComponent, reactive } from "vue";
import AppHeader from "../components/AppHeader.vue";
import { createSession } from "../services/session";
import { useToast } from "../composables/useToast";
import { useRouter } from "vue-router";
import { toRefs } from "vue";

export default defineComponent({
  components: { AppHeader },
  setup() {
    const state = reactive({
      username: "",
      password: "",
      errors: {} as Record<string, string>,
    });
    const router = useRouter();
    const toast = useToast();

    function submit() {
      state.errors = {};
      if (!state.username) state.errors.username = "Username required";
      if (!state.password) state.errors.password = "Password required";
      if (Object.keys(state.errors).length) return;
      if (state.username.trim() && state.password.length >= 4) {
        createSession(state.username.trim());
        toast.push({ type: "success", message: "Signed in successfully" });
        router.push("/dashboard");
      } else {
        toast.push({ type: "error", message: "Invalid credentials" });
      }
    }

    return { ...toRefs(state), submit };
  },
});
</script>
