# 🚂 BrainBrawler Railway.app Deployment Guide

## 🚀 Quick Deploy

1. **Fork/Clone** questo repository
2. **Connetti a Railway.app**:
   ```bash
   # Install Railway CLI
   npm install -g @railway/cli
   
   # Login to Railway
   railway login
   
   # Deploy from directory
   railway up
   ```

## 📦 Stack Completo

### Services Deployed:
- **PostgreSQL** - Database principale
- **Redis** - Cache e session storage  
- **Kafka + Zookeeper** - Message broker per real-time
- **Backend** - API Node.js + Socket.io + GameEngine
- **Frontend** - Static HTML/CSS/JS servito da Nginx

## ⚙️ Configurazione Automatica

### Environment Variables (auto-configured):
```bash
NODE_ENV=production
KAFKA_ENABLED=true
REDIS_ENABLED=true
SMTP_ENABLED=false          # Email disabled
GAME_ENGINE_ENABLED=true
SOCKET_IO_ENABLED=true
DEFAULT_QUESTION_TIME=15
DEFAULT_TOTAL_QUESTIONS=5
MAX_PLAYERS_PER_ROOM=8
JWT_SECRET=auto-generated
```

### 📡 Service Discovery:
- **Backend**: `http://backend:3000`
- **Frontend**: `http://frontend:80`
- **PostgreSQL**: `postgresql://postgres:5432/brainbrawler`
- **Redis**: `redis://redis:6379`
- **Kafka**: `kafka:9092`

## 🎮 Features Abilitati

✅ **Multiplayer Real-time** (Socket.io + Kafka)  
✅ **Game Engine** completo con timer e stati  
✅ **Cache Redis** per performance  
✅ **Database persistente** PostgreSQL  
✅ **Auto-scaling** via Railway  
✅ **Health checks** integrati  
❌ **Email SMTP** (disabilitato)  

## 🔧 Development

Per sviluppo locale con Docker:
```bash
docker-compose up -d
```

## 📊 Monitoring

- **Backend Health**: `https://your-app.railway.app/health`
- **Frontend Health**: `https://your-frontend.railway.app/health`
- **Railway Dashboard**: Monitoring automatico CPU/RAM/Network

## 🚦 Deployment Status

Dopo il deploy, verifica che tutti i servizi siano UP:
1. ✅ PostgreSQL - Database ready
2. ✅ Redis - Cache ready  
3. ✅ Kafka - Message broker ready
4. ✅ Backend - API + GameEngine ready
5. ✅ Frontend - Static assets served

## 🎯 Accesso

- **Frontend**: `https://your-frontend-url.railway.app`
- **API**: `https://your-backend-url.railway.app`
- **Admin Panel**: `/admin` (se configurato)

---

**🚀 Deploy Time**: ~5-10 minuti  
**💰 Cost**: Gratis (500h/mese su Railway)  
**🔄 Auto-Deploy**: Push to main branch 