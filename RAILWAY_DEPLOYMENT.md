# 🚂 BrainBrawler Railway.app Deployment Guide

## 🚀 Quick Deploy - Opzione Semplificata

Railway gestisce meglio servizi separati che Docker Compose. Segui questa strategia:

### **Step 1: Deploy Database**
1. **Vai su Railway.app**
2. **Crea nuovo progetto**
3. **Aggiungi PostgreSQL** (template ufficiale)
4. **Aggiungi Redis** (template ufficiale)

### **Step 2: Deploy Backend**
1. **Connetti repository** `Polimar/bb-online`
2. **Root Directory**: `/backend`
3. **Environment Variables**:
   ```bash
   NODE_ENV=production
   KAFKA_ENABLED=false          # Disabilitato per semplicità
   REDIS_ENABLED=true
   SMTP_ENABLED=false
   GAME_ENGINE_ENABLED=true
   SOCKET_IO_ENABLED=true
   DEFAULT_QUESTION_TIME=15
   DEFAULT_TOTAL_QUESTIONS=5
   MAX_PLAYERS_PER_ROOM=8
   ```

### **Step 3: Deploy Frontend**
1. **Nuovo servizio** dallo stesso repository
2. **Root Directory**: `/frontend`
3. **Environment Variables**:
   ```bash
   API_BASE_URL=https://your-backend-url.railway.app
   ```

## 📦 Configurazione Semplificata

### **Senza Kafka (per iniziare):**
- ✅ **PostgreSQL** - Database
- ✅ **Redis** - Cache 
- ✅ **Backend** - API + Socket.io + GameEngine
- ✅ **Frontend** - Static files
- ❌ **Kafka** - Disabilitato (Socket.io sufficiente)

### **Vantaggi:**
- 🚀 **Deploy più veloce** (2-3 minuti)
- 💰 **Meno risorse** utilizzate
- 🔧 **Più semplice** da gestire
- ✅ **Tutte le funzionalità** core funzionanti

## 🎮 Features Disponibili

✅ **Multiplayer Real-time** (solo Socket.io)  
✅ **Game Engine** completo  
✅ **Cache Redis** per performance  
✅ **Database PostgreSQL**  
✅ **Auto-scaling Railway**  
❌ **Email SMTP** (disabilitato)  
❌ **Kafka** (disabilitato per semplicità)  

## 🔧 Per Riabilitare Kafka (Advanced)

Se vuoi Kafka completo, usa Docker Compose locale:
```bash
# Clone repository
git clone https://github.com/Polimar/bb-online.git
cd bb-online

# Run full stack with Docker
docker-compose up -d
```

## 📊 URLs di Accesso

Dopo il deploy:
- **Frontend**: `https://brainbrawler-frontend-xxx.railway.app`
- **Backend API**: `https://brainbrawler-backend-xxx.railway.app`
- **Health Check**: `https://your-backend.railway.app/health`

---

**⏱️ Deploy Time**: ~2-3 minuti  
**💰 Cost**: Gratis (500h/mese)  
**🎯 Focus**: Stabilità e semplicità prima di tutto 