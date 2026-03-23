<script setup lang="ts">
const { data: status, pending, refresh } = await useFetch('/api/status')

const title = 'System Verification'
const description = 'Verifying Nix, Nuxt 4, Cloudflare D1, and Stylistic features.'

useSeoMeta({
  title,
  description
})
</script>

<template>
  <div class="min-h-screen py-12 font-rounded">
    <UContainer class="max-w-2xl">
      <UCard
        class="mb-8 duo-card"
        :ui="{ body: 'p-5' }"
      >
        <div class="flex items-center justify-between">
          <div class="flex items-center gap-4">
            <div class="w-12 h-12 bg-duo-green rounded-xl flex items-center justify-center shadow-[0_3px_0_0_#46a302]">
              <UIcon
                name="i-lucide-shield-check"
                class="w-7 h-7 text-white"
              />
            </div>
            <div>
              <h1 class="text-2xl font-black text-[#4b4b4b] dark:text-white tracking-tight uppercase">
                System Check
              </h1>
              <p class="text-xs font-bold text-duo-gray uppercase">
                Level 1: Initialization
              </p>
            </div>
          </div>
          <div class="flex items-center gap-2 px-3 py-1 bg-[#fff8e1] border-2 border-[#ffc800] rounded-full shadow-[0_2px_0_0_#ffc800]">
            <UIcon
              name="i-lucide-flame"
              class="text-[#ff9600]"
            />
            <span class="font-black text-[#ff9600]">14</span>
          </div>
        </div>
      </UCard>

      <div class="space-y-6">
        <UCard
          class="relative overflow-hidden duo-card"
          :ui="{ body: 'p-5' }"
        >
          <div class="absolute top-0 right-0 w-16 h-16 bg-duo-green opacity-5 -mr-4 -mt-4 rounded-full" />

          <div class="flex items-center gap-3 mb-6">
            <span class="w-8 h-8 rounded-full bg-duo-blue text-white flex items-center justify-center font-black text-sm shadow-[0_2px_0_0_#1899d6]">1</span>
            <h2 class="text-lg font-black text-[#4b4b4b] dark:text-white uppercase tracking-wide">
              Environment
            </h2>
          </div>

          <div class="grid grid-cols-2 gap-4">
            <div class="p-4 border-2 border-duo-border dark:border-duo-dark-border rounded-xl bg-gray-50/50 dark:bg-duo-dark-surf/50">
              <p class="text-[10px] font-black text-duo-gray uppercase mb-1">
                Node Agent
              </p>
              <p class="text-lg font-black text-[#4b4b4b] dark:text-white">
                {{ status?.env.nodeVersion }}
              </p>
            </div>
            <div class="p-4 border-2 border-duo-border dark:border-duo-dark-border rounded-xl bg-gray-50/50 dark:bg-duo-dark-surf/50">
              <p class="text-[10px] font-black text-duo-gray uppercase mb-1">
                Platform
              </p>
              <p class="text-lg font-black text-duo-green uppercase italic">
                {{ status?.env.platform }}
              </p>
            </div>
          </div>
        </UCard>

        <UCard
          class="duo-card"
          :ui="{ body: 'p-5' }"
        >
          <div class="flex items-center gap-3 mb-6">
            <span class="w-8 h-8 rounded-full bg-duo-red text-white flex items-center justify-center font-black text-sm shadow-[0_2px_0_0_#d33131]">2</span>
            <h2 class="text-lg font-black text-[#4b4b4b] dark:text-white uppercase tracking-wide">
              Persistence
            </h2>
          </div>

          <div class="space-y-4">
            <div class="flex items-center justify-between p-4 border-2 border-duo-border dark:border-duo-dark-border rounded-2xl bg-[#fdfdfd] dark:bg-duo-dark-surf">
              <div class="flex items-center gap-4">
                <UIcon
                  name="i-lucide-database"
                  class="w-8 h-8 text-duo-blue"
                />
                <div>
                  <p class="font-black text-[#4b4b4b] dark:text-white">
                    Cloudflare D1 Stack
                  </p>
                  <p class="text-[10px] font-bold text-duo-gray uppercase">
                    SQLite Determinism
                  </p>
                </div>
              </div>
              <UBadge
                size="sm"
                variant="subtle"
                :color="status?.db.status === 'Connected' ? 'success' : 'error'"
                class="font-black border-2 rounded-full px-4 dark:bg-opacity-20"
              >
                {{ status?.db.status }}
              </UBadge>
            </div>

            <div class="space-y-2">
              <UProgress
                :value="Math.min((status?.db.roomCount ?? 0) * 10, 100)"
                size="xl"
                class="h-4"
                :ui="{
                  indicator: 'bg-duo-blue shadow-[inset_0_-2px_0_0_#1899d6]',
                  base: 'bg-duo-border dark:bg-duo-dark-border rounded-full'
                }"
              />
              <div class="flex justify-between text-[10px] font-black text-duo-gray uppercase">
                <span>Rooms Occupied</span>
                <span class="text-duo-blue">{{ status?.db.roomCount }} / 100</span>
              </div>
            </div>
          </div>
        </UCard>

        <footer class="pt-8 text-center space-y-6">
          <UButton
            class="btn-duo btn-duo-green w-full text-xl h-16 justify-center !p-0"
            :loading="pending"
            @click="() => refresh()"
          >
            <span class="font-black tracking-wider uppercase">Click Here</span>
          </UButton>

          <p class="text-[10px] font-black text-duo-gray uppercase tracking-widest">
            Void • {{ status?.timestamp?.split('T')[0] }}
          </p>
        </footer>
      </div>
    </UContainer>
  </div>
</template>

<style scoped>
</style>
