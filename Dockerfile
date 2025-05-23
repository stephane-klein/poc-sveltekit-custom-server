FROM node:22.16-slim AS base

RUN apt update -y; apt install -y curl python3 build-essential # dependency to build better-sqlite3
RUN npm install -g pnpm@10.11

WORKDIR /app/
COPY ./ /app/

RUN --mount=type=cache,id=pnpm,target=/pnpm/store \
    pnpm config set store-dir /pnpm/store && \
    pnpm install --frozen-lockfile

RUN pnpm run build

FROM node:22.16-slim
RUN apt update -y; apt install -y curl
RUN npm install -g pnpm@10.11

WORKDIR /app/

COPY --from=base /app/package.json /app/
COPY --from=base /app/node_modules/ /app/node_modules/
COPY --from=base /app/pnpm-lock.yaml /app/
COPY --from=base /app/src/lib/server/ /app/src/lib/server/
COPY --from=base /app/src/load-seed-data.js /app/src/load-seed-data.js
COPY --from=base /app/sqls/ /app/sqls/

COPY --from=base /app/build/ /app/build/

EXPOSE 3000

ENV SQLITE_PATH=/data/sqlite3.db
ENV ENV=production

HEALTHCHECK --interval=30s --timeout=10s --retries=3 CMD curl --fail http://localhost:3000/healthcheck || exit 1
COPY --chmod=0755 ./entrypoint.sh /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]
CMD [ "serve" ]
