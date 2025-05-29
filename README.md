# POC SvelteKit custom server

Implementation of a [Custom Server](https://svelte.dev/docs/kit/adapter-node#Custom-server) for a SvelteKit 2 [SSR](https://svelte.dev/docs/kit/glossary#SSR) project with [Hydration](https://svelte.dev/docs/kit/glossary#Hydration).

Here's what this example project contains:

- Integration of [SQLite](https://en.wikipedia.org/wiki/SQLite) database.
- At each server startup, the model migration scripts [`sqls/migrations/*.sql`](sqls/migrations/) are automatically executed.
  This applies both in development mode (`pnpm run dev`) and in production mode (`pnpm run build; pnpm run preview`).  
  This model migration system is powered by [`@beenotung/better-sqlite3-helper`](https://github.com/beenotung/better-sqlite3-schema).
- Integration of a scheduler based on "[Cron for Node.js](https://github.com/kelektiv/node-cron/)".
- Seed data loading script.

**Important information**: This technique is no longer necessary [since SvelteKit version 2.10 released in December 2024](https://github.com/sveltejs/kit/discussions/13841#discussioncomment-13306394). I recommend using the [Shared hooks init](https://svelte.dev/docs/kit/hooks#Shared-hooks-init) feature instead.

```sh
$ mise install
$ pnpm install
$ pnpm run load-seed-data
```

Launch the project in dev mode:

```
$ pnpm run dev
Server started on http://localhost:5173 in development mode
```

Launch the project in production mode:

```sh
$ pnpm run build
$ pnpm run preview
Server started on http://localhost:3000 in production mode
```
