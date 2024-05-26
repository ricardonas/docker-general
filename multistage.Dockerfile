# Applying multistage building here, reduces the final image size by 523MB.

# Step 1: Just to easily install required application files.
FROM node:lts-alpine3.20 AS builder
WORKDIR /usr/app
RUN yes '' | npx create-next-app@latest . && npm run build

# Step 2: Copy generated files to a lightly Linux release.
FROM alpine:3.20.0
WORKDIR /usr/app
RUN apk add --no-cache nodejs npm
COPY --from=builder /usr/app /usr/app
CMD [ "npm", "run", "start" ]
EXPOSE 3000