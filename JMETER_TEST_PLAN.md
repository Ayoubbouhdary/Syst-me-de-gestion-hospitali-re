# 🎯 GUIDE COMPLET JMETER - SYSTÈME DE GESTION HOSPITALIÈRE

## ✅ **AVANT DE DÉMARRER**

**Le localhost DOIT afficher quelque chose :**

```
http://localhost:8081/api/patients
```

Tu dois voir : `[]` ou une liste JSON → Cela signifie que le backend fonctionne ✅

---

## 📋 **TOUS LES ENDPOINTS À TESTER**

### **1️⃣ AUTHENTIFICATION (Auth)**
| Path | Méthode | Body |
|------|---------|------|
| `/api/auth/login` | **POST** | `{"email": "admin@hospital.com", "motDePasse": "password123"}` |
| `/api/auth/logout` | **POST** | Vide |
| `/api/auth/setup-password` | **POST** | `{"email": "admin@hospital.com", "newPassword": "newpass"}` |
| `/api/auth/change-password` | **POST** | `{"currentPassword": "...", "newPassword": "..."}` |
| `/api/auth/verify` | **GET** | Vide (Nécessite JWT) |

### **2️⃣ PATIENTS**
| Path | Méthode | Description |
|------|---------|-------------|
| `/api/patients` | **GET** | Récupérer tous les patients |
| `/api/patients/{id}` | **GET** | Récupérer un patient |
| `/api/patients` | **POST** | Créer un patient |
| `/api/patients/{id}` | **PUT** | Modifier un patient |
| `/api/patients/{id}` | **DELETE** | Supprimer un patient |
| `/api/patients/search?q=...` | **GET** | Rechercher des patients |

### **3️⃣ SERVICES**
| Path | Méthode | Description |
|------|---------|-------------|
| `/api/services` | **GET** | Récupérer tous les services |
| `/api/services/{id}` | **GET** | Récupérer un service |
| `/api/services` | **POST** | Créer un service |
| `/api/services/{id}` | **PUT** | Modifier un service |
| `/api/services/{id}` | **DELETE** | Supprimer un service |

### **4️⃣ SOINS**
| Path | Méthode | Description |
|------|---------|-------------|
| `/api/soins` | **GET** | Récupérer tous les soins |
| `/api/soins/{id}` | **GET** | Récupérer un soin |
| `/api/soins` | **POST** | Créer un soin |
| `/api/soins/{id}` | **PUT** | Modifier un soin |
| `/api/soins/{id}` | **DELETE** | Supprimer un soin |

### **5️⃣ RENDEZ-VOUS**
| Path | Méthode | Description |
|------|---------|-------------|
| `/api/rendez-vous` | **GET** | Récupérer tous les RDV |
| `/api/rendez-vous/{id}` | **GET** | Récupérer un RDV |
| `/api/rendez-vous` | **POST** | Créer un RDV |
| `/api/rendez-vous/{id}` | **PUT** | Modifier un RDV |
| `/api/rendez-vous/{id}` | **DELETE** | Supprimer un RDV |

### **6️⃣ FINANCE**
| Path | Méthode | Description |
|------|---------|-------------|
| `/api/finance/cout-soin` | **POST** | Calculer le coût d'un soin |
| `/api/finance/budget-service` | **POST** | Calculer budget d'un service |
| `/api/finance/historique` | **GET** | Récupérer l'historique des dépenses |

### **7️⃣ ALERTES**
| Path | Méthode | Description |
|------|---------|-------------|
| `/api/alertes` | **GET** | Récupérer toutes les alertes |
| `/api/alertes/service/{serviceId}` | **GET** | Alertes d'un service |
| `/api/alertes/budget` | **GET** | Alertes de budget |
| `/api/alertes/{id}` | **POST** | Créer une alerte |

### **8️⃣ FACTURES & PAIEMENTS**
| Path | Méthode | Description |
|------|---------|-------------|
| `/api/factures` | **GET** | Récupérer les factures |
| `/api/paiements` | **GET** | Récupérer les paiements |

---

## 🚀 **CRÉER LE TEST JMETER - ÉTAPE PAR ÉTAPE**

### **ÉTAPE 1 : Ouvre JMeter**
Cherche et lance **jmeter.bat** sur ton ordinateur

### **ÉTAPE 2 : Crée un Thread Group**
1. Clique droit sur **Test Plan**
2. **Ajouter** → **Thread Groups** → **Thread Group**
3. Nomme-le : `Hospital-Test`
4. Configure :
   - **Number of Threads**: `1`
   - **Loop Count**: `1`

### **ÉTAPE 3 : Ajoute tes requêtes HTTP**

**Pour chaque endpoint, clique droit sur Thread Group :**
→ **Ajouter** → **Sampler** → **HTTP Request**

#### **Exemple 1 : GET /api/patients**
```
Server: localhost
Port: 8081
Path: /api/patients
Method: GET
```

#### **Exemple 2 : POST /api/auth/login**
```
Server: localhost
Port: 8081
Path: /api/auth/login
Method: POST
Body Data (JSON):
{
  "email": "admin@hospital.com",
  "motDePasse": "password123"
}
```

### **ÉTAPE 4 : Ajoute un Listener**
1. Clique droit sur **Thread Group**
2. **Ajouter** → **Listener** → **View Results Tree**

### **ÉTAPE 5 : Lance les tests**
1. Clique sur **▶️ START** (ou Ctrl+R)
2. Tu verras des points :
   - ✅ **VERT** = Succès
   - ❌ **ROUGE** = Erreur
3. Clique sur chaque requête pour voir la réponse

---

## 💡 **TESTS RECOMMANDÉS**

### **Test 1 : Authentification**
```
1. POST /api/auth/login → Récupère le token JWT
2. Copie le token
3. L'utilise dans les autres requêtes (Header : Authorization: Bearer <token>)
```

### **Test 2 : CRUD Patients**
```
1. GET /api/patients → Voir tous les patients
2. POST /api/patients → Créer un patient
3. GET /api/patients/{id} → Récupérer le patient créé
4. PUT /api/patients/{id} → Modifier le patient
5. DELETE /api/patients/{id} → Supprimer le patient
```

### **Test 3 : Test de Charge**
```
1. Crée un Thread Group avec :
   - Number of Threads: 10 (10 utilisateurs)
   - Loop Count: 5 (5 requêtes chacun)
   - Ramp-up: 5 secondes
2. Lance et observe les performances
```

---

## 📊 **INTERPRÉTER LES RÉSULTATS**

| Status | Signification |
|--------|---------------|
| ✅ Vert | Requête réussie (200 OK) |
| ❌ Rouge | Erreur (401, 404, 500, etc.) |
| ⏱️ Temps | Temps de réponse en millisecondes |

---

## 🔒 **AJOUTER UN TOKEN JWT DANS JMeter**

Si tu veux tester les endpoints qui nécessitent un token :

1. D'abord, teste le **login** pour récupérer le token
2. Copie le token de la réponse
3. Pour les autres requêtes, ajoute un **HTTP Header Manager** :
   - Clique droit sur **HTTP Request**
   - **Ajouter** → **Config Elements** → **HTTP Header Manager**
   - Ajoute : `Authorization: Bearer <ton_token>`

---

## ✨ **TU ES PRÊT !**

Suis ce guide étape par étape et tu auras un test complet de ton API ! 🚀

Des questions ? Dis-moi où tu es bloqué ! 👍
