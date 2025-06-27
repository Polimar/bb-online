# 🧠 BrainBrawler Online - Render.com Deployment

**Repository dedicato al deployment su Render.com**

## 🚀 Quick Deploy

Questo repository è configurato per il deployment automatico su Render.com utilizzando il Blueprint.

### Deployment Steps

1. **Push su GitHub**:
   ```bash
   git add .
   git commit -m "Ready for Render deployment"
   git push origin main
   ```

2. **Render Dashboard**:
   - New → Blueprint
   - Connect this GitHub repository  
   - Deploy automatically

### 🏗️ Architettura

- **Backend**: Node.js + Socket.io + GameEngine integrato
- **Frontend**: HTML/CSS/JavaScript statico
- **Database**: PostgreSQL con Prisma ORM
- **Cache**: Redis per game state
- **Real-time**: Socket.io WebSockets

### 🔧 Services

| Service | Type | URL |
|---------|------|-----|
| Backend API | Web Service | `brainbrawler-api.onrender.com` |
| Frontend | Static Site | `brainbrawler-app.onrender.com` |
| Database | PostgreSQL | Auto-managed |
| Redis | Cache | Auto-managed |

### 📝 Configuration

Il deployment è completamente configurato tramite `render.yaml`:

- **Database**: PostgreSQL con auto-migration
- **Environment Variables**: Pre-configurate per production
- **Security Headers**: HTTPS, CORS, Security headers
- **Performance**: Connection pooling, Redis caching

### 🔗 Repository Originale

Per sviluppo locale: [brainbrawler repository](../brainbrawler)

### 📊 Monitoring

Dopo il deploy, monitora tramite:
- **Health Check**: `https://brainbrawler-api.onrender.com/health`
- **Metrics**: `https://brainbrawler-api.onrender.com/metrics`
- **Render Dashboard**: Logs e performance

---

**Deploy automatico**: Ogni push su `main` triggera il re-deploy su Render.com

## 🚀 Quick Start

```bash
# Clona il repository
git clone https://github.com/Polimar/brainbrawler.git
cd brainbrawler

# Avvia tutti i servizi con Docker
docker-compose -f docker-compose.dev.yml up -d

# Accedi all'app
open http://localhost:3001
```

## 🔐 Configurazione Google OAuth

### Passo 1: Creare un Progetto Google Cloud

1. Vai su [Google Cloud Console](https://console.cloud.google.com/)
2. Crea un nuovo progetto o seleziona uno esistente
3. Abilita la **Google Identity API**:
   - Nel menu di navigazione, vai su "APIs & Services" > "Library"
   - Cerca "Google Identity" e clicca su "Google Identity API"
   - Clicca "Enable"

### Passo 2: Configurare OAuth 2.0

1. Vai su "APIs & Services" > "Credentials"
2. Clicca "Create Credentials" > "OAuth 2.0 Client IDs"
3. Se è la prima volta, configura la schermata di consenso OAuth:
   - Scegli "External" se per testing pubblico
   - Compila i campi obbligatori:
     - **App name**: BrainBrawler
     - **User support email**: La tua email
     - **Developer contact information**: La tua email
   - Aggiungi scope (opzionale per testing): `email`, `profile`
   - Aggiungi test users se in modalità testing

4. Torna a "Credentials" e crea le credenziali OAuth:
   - **Application type**: Web application
   - **Name**: BrainBrawler Web Client
   - **Authorized JavaScript origins**:
     - `http://localhost:3001` (sviluppo locale)
     - `http://10.40.10.180:3001` (il tuo IP server se diverso)
     - `https://yourdomain.com` (produzione)
   - **Authorized redirect URIs**:
     - `http://localhost:3001` (sviluppo)
     - `https://yourdomain.com` (produzione)

### Passo 3: Ottenere le Credenziali

Dopo aver creato le credenziali OAuth, otterrai:
- **Client ID**: Una stringa come `123456789-abcdefghijklmnop.apps.googleusercontent.com`
- **Client Secret**: Una stringa segreta come `GOCSPX-abcdefghijklmnopqrstuvwxyz`

### Passo 4: Configurare l'Applicazione

1. **Per Docker (Raccomandato)**:
   
   Modifica il file `docker-compose.dev.yml` nella sezione backend:
   ```yaml
   environment:
     GOOGLE_CLIENT_ID: "TUO_GOOGLE_CLIENT_ID_QUI"
     GOOGLE_CLIENT_SECRET: "TUO_GOOGLE_CLIENT_SECRET_QUI"
   ```

2. **Per sviluppo locale**:
   
   Crea un file `.env` nella cartella `backend/`:
   ```bash
   GOOGLE_CLIENT_ID="TUO_GOOGLE_CLIENT_ID_QUI"
   GOOGLE_CLIENT_SECRET="TUO_GOOGLE_CLIENT_SECRET_QUI"
   ```

### Passo 5: Riavviare l'Applicazione

```bash
# Con Docker
docker-compose -f docker-compose.dev.yml restart backend frontend

# Oppure ricrea i container
docker-compose -f docker-compose.dev.yml down
docker-compose -f docker-compose.dev.yml up -d
```

### ✅ Verificare la Configurazione

1. Apri http://localhost:3001
2. Vai nella sezione "Registrati"
3. Dovresti vedere il pulsante "Continua con Google" funzionante
4. Il login Google dovrebbe funzionare correttamente

### 🔧 Troubleshooting Google OAuth

**Errore: "This app is blocked"**
- Il tuo app è in modalità testing e l'utente non è nella lista dei test users
- Aggiungi l'email dell'utente in Google Cloud Console > OAuth consent screen > Test users

**Errore: "redirect_uri_mismatch"**
- L'URL da cui stai accedendo non è nella lista degli "Authorized JavaScript origins"
- Aggiungi l'URL corretto nella configurazione OAuth

**Errore: "Token used too early"**
- Problema di sincronizzazione dell'orario del server
- Verifica che l'orario del sistema sia corretto

**Il pulsante Google non appare**
- Controlla che `GOOGLE_CLIENT_ID` sia configurato correttamente
- Verifica nei log del browser se ci sono errori JavaScript
- Controlla che l'API Google Identity sia abilitata

## 📊 Servizi e Porte

| Servizio | Porta | URL | Descrizione |
|----------|-------|-----|-------------|
| Frontend | 3001 | http://localhost:3001 | Web client |
| Backend API | 3000 | http://localhost:3000 | API REST + Socket.io |
| PostgreSQL | 5432 | - | Database principale |
| Redis | 6379 | - | Cache e sessioni |
| Kafka | 9092 | - | Message broker |
| Kafka UI | 8090 | http://localhost:8090 | Interfaccia Kafka |
| Adminer | 8080 | http://localhost:8080 | Database manager |

## 🎮 Credenziali di Test

### Account Demo Preconfigurati
- **Admin**: admin@brainbrawler.com / admin123
- **Test User**: test@brainbrawler.com / test123  
- **Player**: player@brainbrawler.com / player123

### Database Access (Adminer)
- **Server**: postgres
- **Username**: postgres
- **Password**: dev_password_123
- **Database**: brainbrawler

## 🛠️ Sviluppo

### Comandi Utili

```bash
# Vedere i logs
docker logs bb_backend -f
docker logs bb_frontend -f

# Riavviare servizi
docker-compose -f docker-compose.dev.yml restart backend frontend

# Accesso al database
docker exec -it bb_postgres psql -U postgres -d brainbrawler

# Reset database
docker-compose -f docker-compose.dev.yml exec backend npm run db:reset

# Seed database
docker-compose -f docker-compose.dev.yml exec backend npm run db:seed
```

### Database Schema

Il database include:
- **Users**: Gestione utenti con Google OAuth
- **Categories**: Categorie delle domande (Tech, Storia, Sport, etc.)
- **Questions**: Database domande con risposte multiple
- **Games**: Sessioni di gioco multiplayer
- **GameResults**: Risultati e statistiche giocatori

### API Endpoints

**Autenticazione:**
- `POST /api/auth/register` - Registrazione
- `POST /api/auth/login` - Login tradizionale
- `POST /api/auth/google` - Login con Google OAuth
- `GET /api/auth/google/config` - Configurazione Google
- `GET /api/auth/profile` - Profilo utente
- `PUT /api/auth/profile` - Aggiorna profilo

**Gioco:**
- `GET /api/game/categories` - Lista categorie
- `GET /api/game/questions` - Lista domande
- `POST /api/game/room` - Crea stanza
- Via Socket.io: `create-room`, `join-room`, `start-game`

## 🚀 Deploy in Produzione

Per il deploy segui le istruzioni in `brainbrawler_render_deployment.md`.

Configurazioni necessarie per produzione:
- Impostare `NODE_ENV=production`
- Configurare `JWT_SECRET` sicuro
- Configurare correttamente `GOOGLE_CLIENT_ID` e `GOOGLE_CLIENT_SECRET`
- Aggiornare gli "Authorized JavaScript origins" in Google Cloud Console

## 📁 Struttura Progetto

```
brainbrawler/
├── backend/                 # Node.js API + Socket.io
│   ├── src/
│   │   ├── routes/         # API routes
│   │   ├── middleware/     # Auth middleware  
│   │   ├── services/       # Game engine
│   │   └── kafka/          # Kafka producers/consumers
│   ├── prisma/             # Database schema e migrations
│   └── Dockerfile
├── frontend/               # Web client
│   ├── index.html         # Single page app
│   ├── server.js          # Static file server
│   └── Dockerfile
├── docker-compose.dev.yml # Setup completo sviluppo
└── README.md             # Questo file
```

## 🔧 Environment Variables

**Backend (.env o docker-compose.yml):**
```bash
# Database
DATABASE_URL="postgresql://postgres:password@localhost:5432/brainbrawler"

# Redis
REDIS_URL="redis://localhost:6379"

# Kafka
KAFKA_BROKERS="localhost:9092"

# Auth
JWT_SECRET="your-super-secret-jwt-key"
JWT_EXPIRES_IN="7d"

# Google OAuth (RICHIESTO PER SSO)
GOOGLE_CLIENT_ID="your-google-client-id"
GOOGLE_CLIENT_SECRET="your-google-client-secret"

# Server
PORT=3000
NODE_ENV="development"
CORS_ORIGIN="*"
```

## 🎯 Prossimi Passi

1. **Flutter Mobile App**: Sostituire web client con app Flutter
2. **Game Engine Completo**: Implementare logica di gioco avanzata con Kafka
3. **Real-time Leaderboard**: Sistema classifiche live
4. **Achievement System**: Badge e riconoscimenti
5. **Admin Panel**: Gestione domande e utenti
6. **Analytics**: Tracking performance e metriche gioco

## 📝 Note

- Il progetto segue le specifiche del documento `brainbrawler_kafka_prompt.md`
- L'architettura è pronta per migliaia di utenti simultanei
- Kafka gestisce tutti gli eventi real-time per scalabilità
- Il sistema di auth supporta sia credenziali tradizionali che Google OAuth
- Pronto per deploy su Render, Heroku, o qualsiasi provider cloud

---

**Happy Gaming! 🎮** 