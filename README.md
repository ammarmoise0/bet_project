# ⚽ Premier League Match Prediction System

Système de prédiction de résultats de matchs de Premier League avec stratégie de paris basée sur l'Expected Value (EV).

## 🎯 Objectif

Construire un modèle ML qui bat les bookmakers en identifiant des paris à EV positif sur le marché 1X2 (Home/Draw/Away).

## 📊 Phases du Projet

### Phase 0 : Faisabilité ✅ (en cours)
- Notebook exploratoire avec données historiques Premier League
- Features basiques + modèle simple
- Backtesting naïf pour valider ROI > 0%

### Phase 1 : Pipeline End-to-End (MVP)
- ETL minimal (ingest + features)
- Entraînement avec calibration
- API FastAPI locale
- Tests unitaires

### Phase 2 : Automatisation + S3
- Déploiement sur AWS
- Cron jobs pour ingestion quotidienne
- Storage S3 (raw + processed)

### Phase 3 : Production
- API sur EC2 avec monitoring
- CI/CD avec GitHub Actions
- Alertes CloudWatch

## 🚀 Quick Start

```bash
# Setup
python -m venv venv
source venv/bin/activate
pip install -r requirements.txt

# Exploration (Phase 0)
jupyter notebook notebooks/00_feasibility.ipynb

# Entraînement
python models/train.py

# API locale
uvicorn app.main:app --reload

# Test API
curl -X POST http://localhost:8000/predict \
  -H "Content-Type: application/json" \
  -d '{"home_team": "Arsenal", "away_team": "Chelsea", "odds_home": 2.1, "odds_draw": 3.5, "odds_away": 3.8}'
```

## 📁 Structure

```
project/
├─ data/                    # Local storage (dev)
│  ├─ raw/                  # Données brutes (matches + odds)
│  └─ processed/            # Features engineered
├─ notebooks/               # Exploration & validation
├─ etl/                     # Ingestion & transformations
├─ models/                  # Training & registry
├─ app/                     # FastAPI API
├─ tests/                   # Tests unitaires
├─ config/                  # Configuration
└─ scripts/                 # Helpers
```

## 🔑 Configuration

Copier `.env.example` vers `.env` et remplir :
- API keys (football-data.org, The Odds API)
- AWS credentials (S3, EC2)
- Configuration modèle

## 📈 Métriques Clés

- **Brier Score** : < 0.25 (vs ~0.27 des bookmakers)
- **ROI** : > 3% sur backtest
- **Sharpe Ratio** : > 1.0
- **Max Drawdown** : < 20%

## ⚠️ Disclaimers

- Projet éducatif/recherche
- Pas de garantie de profit
- Gestion du capital stricte (Kelly fraction)
- Toujours parier de manière responsable

## 📚 Ressources

- [football-data.org](https://www.football-data.org/) - Données matches
- [The Odds API](https://the-odds-api.com/) - Historical odds
- [Dixon-Coles Model](https://www.researchgate.net/publication/222447402_Modelling_Association_Football_Scores_and_Inefficiencies_in_the_Football_Betting_Market)

