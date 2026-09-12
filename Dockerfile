FROM node:20-alpine

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . .

# --- Variables nécessaires PENDANT le build ---
# (lib/better-auth/auth.ts se connecte à MongoDB dès le chargement du
# module, ce qui est exécuté par Next.js pendant "next build". Ces ARG
# rendent ces valeurs disponibles pour cette étape, peu importe comment
# l'orchestrateur (Portainer, etc.) gère ses propres fichiers .env.)
ARG NODE_ENV=production
ARG MONGODB_URI
ARG BETTER_AUTH_SECRET
ARG BETTER_AUTH_URL
ARG NEXT_PUBLIC_FINNHUB_API_KEY
ARG FINNHUB_BASE_URL
ARG GEMINI_API_KEY
ARG AI_PROVIDER
ARG INNGEST_SIGNING_KEY
ARG NODEMAILER_EMAIL
ARG NODEMAILER_PASSWORD

ENV NODE_ENV=$NODE_ENV \
    MONGODB_URI=$MONGODB_URI \
    BETTER_AUTH_SECRET=$BETTER_AUTH_SECRET \
    BETTER_AUTH_URL=$BETTER_AUTH_URL \
    NEXT_PUBLIC_FINNHUB_API_KEY=$NEXT_PUBLIC_FINNHUB_API_KEY \
    FINNHUB_BASE_URL=$FINNHUB_BASE_URL \
    GEMINI_API_KEY=$GEMINI_API_KEY \
    AI_PROVIDER=$AI_PROVIDER \
    INNGEST_SIGNING_KEY=$INNGEST_SIGNING_KEY \
    NODEMAILER_EMAIL=$NODEMAILER_EMAIL \
    NODEMAILER_PASSWORD=$NODEMAILER_PASSWORD

RUN npm run build

EXPOSE 3000

CMD ["npm", "start"]
