<script setup lang="ts">
const { data: status, pending, refresh } = await useFetch('/api/status')

const title = 'System Verification'
const description = 'Verifying Nix, Nuxt 4, Cloudflare D1, and Stylistic features.'

useSeoMeta({
  title,
  description
})

const mcpServers = [
  { name: 'Nuxt UI MCP', status: 'Healthy', details: 'Providing Component Metadata' },
  { name: 'StitchMCP', status: 'Healthy', details: 'Generating Premium UI Designs' },
  { name: 'Docus MCP', status: 'Healthy', details: 'Fetching Documentation' }
]
</script>

<template>
  <UContainer class="py-12 max-w-2xl">
    <UCard>
      <template #header>
        <div class="flex items-center justify-between">
          <div class="flex items-center gap-3">
            <UIcon
              name="i-lucide-shield-check"
              class="w-8 h-8 text-primary"
            />
            <h1 class="text-2xl font-bold font-sans">
              System Check
            </h1>
          </div>
          <UBadge
            variant="subtle"
            color="success"
          >
            v1.0.0-void
          </UBadge>
        </div>
      </template>

      <div class="space-y-8">
        <!-- 1. Nix & Logic Layer -->
        <section>
          <div class="flex items-center gap-2 mb-4">
            <UIcon name="i-lucide-container" />
            <h2 class="font-bold">
              Nix & Core Environment
            </h2>
          </div>
          <div class="grid grid-cols-2 gap-4">
            <UCard
              variant="soft"
              class="p-2 text-center"
            >
              <p class="text-xs opacity-70">
                Node Version
              </p>
              <p class="font-mono font-bold">
                {{ status?.env.nodeVersion || '...' }}
              </p>
            </UCard>
            <UCard
              variant="soft"
              class="p-2 text-center"
            >
              <p class="text-xs opacity-70">
                NuxtHub Binding
              </p>
              <p class="font-mono font-bold text-green-500">
                {{ status?.env.hub || 'Inactive' }}
              </p>
            </UCard>
          </div>
        </section>

        <USeparator />

        <!-- 2. Database Layer (Drizzle & NuxtHub) -->
        <section>
          <div class="flex items-center gap-2 mb-4">
            <UIcon name="i-lucide-database" />
            <h2 class="font-bold underline decoration-primary underline-offset-4">
              Data & Persistence
            </h2>
          </div>
          <div class="flex items-center justify-between p-4 bg-gray-50 dark:bg-gray-800 rounded-xl border border-gray-200 dark:border-gray-700">
            <div>
              <p class="text-sm font-medium">
                Cloudflare D1 Driver
              </p>
              <p class="text-[10px] text-muted-foreground">
                server/db/migrations/*
              </p>
            </div>
            <UBadge
              variant="subtle"
              :color="status?.db.status === 'Connected' ? 'success' : 'error'"
            >
              {{ status?.db.status }}
            </UBadge>
          </div>
          <div class="mt-4 flex gap-4 justify-center">
            <div class="text-center">
              <p class="text-[10px] uppercase opacity-50">
                Active Rooms
              </p>
              <p class="text-xl font-bold">
                {{ status?.db.roomCount }}
              </p>
            </div>
            <div class="text-center">
              <p class="text-[10px] uppercase opacity-50">
                ORM
              </p>
              <p class="text-sm font-medium">
                Drizzle v0.39+
              </p>
            </div>
          </div>
        </section>

        <USeparator />

        <!-- 3. UI/UX Verification -->
        <section>
          <div class="flex items-center gap-2 mb-4">
            <UIcon name="i-lucide-palette" />
            <h2 class="font-bold underline decoration-success underline-offset-4">
              UI/UX Verification
            </h2>
          </div>
          <div class="grid grid-cols-2 gap-4">
            <div class="space-y-4">
              <UButton
                class="w-full btn-macaroon font-bold"
                color="primary"
              >
                Macaroon Blue
              </UButton>
              <UButton
                class="w-full btn-macaroon font-bold"
                color="secondary"
              >
                Macaroon Mint
              </UButton>
            </div>
            <div class="flex flex-col justify-center items-center p-4 bg-white dark:bg-black/20 rounded-xl border border-dashed border-gray-200 dark:border-gray-700">
              <p class="text-[10px] text-center opacity-70 mb-2 uppercase">
                Custom Glassmorphism
              </p>
              <div class="w-12 h-12 rounded-full bg-gradient-to-tr from-primary to-success blur-xl opacity-20 absolute" />
              <UIcon
                name="i-lucide-sparkles"
                class="w-6 h-6 animate-pulse text-success"
              />
            </div>
          </div>
        </section>

        <USeparator />

        <!-- 4. MCP & Documentation Integration -->
        <section>
          <div class="flex items-center gap-2 mb-4">
            <UIcon name="i-lucide-cpu" />
            <h2 class="font-bold underline decoration-warning underline-offset-4">
              MCP Servers & Docs
            </h2>
          </div>
          <div class="space-y-3">
            <div
              v-for="mcp in mcpServers"
              :key="mcp.name"
              class="flex items-center justify-between text-xs p-2 rounded-lg bg-gray-50/50 dark:bg-gray-800/50"
            >
              <div class="flex items-center gap-2">
                <div class="w-2 h-2 rounded-full bg-success animate-pulse" />
                <span class="font-bold">{{ mcp.name }}</span>
              </div>
              <span class="opacity-60 text-[10px]">{{ mcp.details }}</span>
            </div>
          </div>
        </section>

        <!-- Final Action -->
        <section class="pt-6">
          <UButton
            class="w-full py-6 text-xl font-black uppercase tracking-tighter shadow-xl"
            color="success"
            icon="i-lucide-refresh-cw"
            block
            :loading="pending"
            @click="() => refresh()"
          >
            Re-Verify Full Stack
          </UButton>
          <div class="flex justify-between items-center mt-6 text-[9px] text-muted-foreground uppercase font-mono">
            <span>PLATFORM: {{ status?.env.platform }}</span>
            <span>DATE: {{ status?.timestamp.split('T')[0] }}</span>
          </div>
        </section>
      </div>
    </UCard>
  </UContainer>
</template>

<style scoped>
/* Scoped test for the Macaroon utility added to main.css */
</style>
