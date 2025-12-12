FROM oven/bun:alpine AS builder
WORKDIR /app
COPY . /app/
# what the fuck man?
COPY package.json /
RUN bun install && bun run refresh-kbs && bun run build

FROM nginx:alpine-slim
COPY --from=builder /app/dist /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
