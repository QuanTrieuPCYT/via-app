FROM oven/bun:alpine AS builder
WORKDIR /app
COPY package.json bun.lockb* ./
COPY package.json /
RUN bun install && bun run refresh-kbs
COPY . .
RUN bun run build

FROM nginx:alpine-slim
COPY --from=builder /app/dist /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
