import { sqliteTable, text, integer } from 'drizzle-orm/sqlite-core'

export const rooms = sqliteTable('rooms', {
  id: integer('id').primaryKey({ autoIncrement: true }),
  code: text('code').notNull().unique(),
  name: text('name').notNull(),
  status: text('status').default('open'),
  createdAt: integer('created_at', { mode: 'timestamp' }).$defaultFn(() => new Date())
})

export const players = sqliteTable('players', {
  id: integer('id').primaryKey({ autoIncrement: true }),
  roomId: integer('room_id').references(() => rooms.id, { onDelete: 'cascade' }),
  nickname: text('nickname').notNull(),
  coins: integer('coins').default(0),
  energy: integer('energy').default(5),
  isReady: integer('is_ready', { mode: 'boolean' }).default(false)
})
