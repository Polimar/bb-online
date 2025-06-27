# 🚂 BrainBrawler Railway.app Deployment Guide

## 📋 **GUIDA PASSO-PASSO COMPLETA**

### **STEP 1: Preparazione Account Railway**

1. **Vai su [Railway.app](https://railway.app)**
2. **Sign up** con GitHub account
3. **Verifica email** se richiesto
4. **Dashboard** dovrebbe essere vuoto

---

### **STEP 2: Deploy Database PostgreSQL**

1. **Click "New Project"**
2. **Seleziona "Deploy from Template"**
3. **Cerca "PostgreSQL"** nella lista
4. **Click "Deploy Now"**
5. **Nome progetto**: `brainbrawler-db`
6. **Aspetta deploy** (1-2 minuti)
7. **Copia DATABASE_URL** dal tab Variables

---

### **STEP 3: Deploy Redis Cache**

1. **Nel stesso progetto, click "+ New Service"**
2. **Seleziona "Deploy from Template"** 
3. **Cerca "Redis"** nella lista
4. **Click "Deploy Now"**
5. **Aspetta deploy** (1-2 minuti)
6. **Copia REDIS_URL** dal tab Variables

---

### **STEP 4: Deploy Backend API**

1. **Click "+ New Service"**
2. **Seleziona "Deploy from GitHub Repo"**
3. **Autorizza Railway** ad accedere a GitHub
4. **Seleziona repository**: `Polimar/bb-online`
5. **Root Directory**: `/backend`
6. **Aspetta che rilevi Dockerfile**

**IMPORTANT: Configura Environment Variables:**
```bash
NODE_ENV=production
PORT=3000
DATABASE_URL=<copia-da-postgres-service>
REDIS_URL=<copia-da-redis-service>
KAFKA_ENABLED=true
REDIS_ENABLED=true
SMTP_ENABLED=false
GAME_ENGINE_ENABLED=true
SOCKET_IO_ENABLED=true
DEFAULT_QUESTION_TIME=15
DEFAULT_TOTAL_QUESTIONS=5
MAX_PLAYERS_PER_ROOM=8
ROOM_CODE_LENGTH=6
AUTO_START_THRESHOLD=2
CONNECTION_POOL_SIZE=5
REDIS_TTL=3600
JWT_SECRET=your-super-secret-jwt-key-here
CORS_ORIGIN=*
```

7. **Click "Deploy"**
8. **Aspetta build e deploy** (3-5 minuti)
9. **Copia URL pubblico** del backend

---

### **STEP 5: Deploy Frontend**

1. **Click "+ New Service"**
2. **Seleziona "Deploy from GitHub Repo"**
3. **Repository**: `Polimar/bb-online` (stesso)
4. **Root Directory**: `/frontend`
5. **Aspetta che rilevi Dockerfile**

**Environment Variables Frontend:**
```bash
API_BASE_URL=<backend-url-da-step-4>
```

6. **Click "Deploy"**
7. **Aspetta build** (2-3 minuti)
8. **Copia URL pubblico** del frontend

---

### **STEP 6: Verifica Deploy**

1. **Check Backend Health**:
   - Vai su `<backend-url>/health`
   - Dovresti vedere: `{"status": "healthy", "timestamp": "..."}`

2. **Check Frontend**:
   - Vai su `<frontend-url>`
   - Dovresti vedere la homepage di BrainBrawler

3. **Test Registration**:
   - Clicca "Register" 
   - Crea account (email auto-verificata)
   - Login dovrebbe funzionare

---

## 🔧 **TROUBLESHOOTING**

### **Backend non si avvia?**
- ✅ Verifica `DATABASE_URL` sia copiato correttamente
- ✅ Verifica `REDIS_URL` sia copiato correttamente
- ✅ Check logs in Railway dashboard
- ✅ Prisma migrations dovrebbero essere automatiche

### **Frontend non carica?**
- ✅ Verifica `API_BASE_URL` punti al backend
- ✅ Backend deve essere UP prima del frontend
- ✅ Check console browser per errori CORS

### **Database connection error?**
- ✅ PostgreSQL service deve essere UP
- ✅ Copia esatta della `DATABASE_URL` 
- ✅ Railway auto-configura le connessioni

---

## 🎮 **STACK FINALE**

✅ **PostgreSQL** - Database persistente  
✅ **Redis** - Cache e sessioni  
✅ **Backend** - API + Socket.io + GameEngine  
✅ **Frontend** - Static HTML/CSS/JS  
✅ **Kafka** - Fallback automatico (Socket.io primary)  
❌ **Email SMTP** - Disabilitato  

## 📊 **URLs FINALI**

Salva questi URL:
- **🎮 Game**: `https://your-frontend-xxx.railway.app`
- **🔧 API**: `https://your-backend-xxx.railway.app`
- **❤️ Health**: `https://your-backend-xxx.railway.app/health`
- **📊 Metrics**: Railway Dashboard

---

**⏱️ Deploy Time**: 5-8 minuti totali  
**💰 Cost**: Gratis (500h/mese Railway)  
**🚀 Auto-Deploy**: Ogni push su main branch  
**📈 Scaling**: Automatico Railway 