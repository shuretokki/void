import { useDb } from '../utils/db'

export default defineEventHandler(async () => {
  const db = useDb()

  // 1. Test Drizzle/D1 Connection
  let dbStatus = 'Disconnected'
  let roomCount = 0
  try {
    const res = await db.select({ count: tables.rooms.id }).from(tables.rooms)
    roomCount = res.length
    dbStatus = 'Connected'
  } catch (e) {
    dbStatus = `Error: ${(e as Error).message}`
  }

  // 2. Environment Info
  const envInfo = {
    nodeVersion: process.version,
    platform: process.platform,
    memory: `${Math.round(process.memoryUsage().heapUsed / 1024 / 1024)} MB`,
    hub: 'Active'
  }

  return {
    status: 'Operational',
    db: {
      status: dbStatus,
      roomCount
    },
    env: envInfo,
    timestamp: new Date().toISOString()
  }
})
