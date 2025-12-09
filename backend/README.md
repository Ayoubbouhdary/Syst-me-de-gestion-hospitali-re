# Hospital Dashboard Backend API

## 📦 Structure du Projet

```
backend/
├── src/main/
│   ├── java/com/hospital/
│   │   ├── HospitalDashboardApplication.java  # Main Spring Boot
│   │   ├── config/
│   │   │   └── WebConfig.java                 # CORS Configuration
│   │   ├── model/                             # Entités JPA
│   │   │   ├── Patient.java
│   │   │   ├── Soin.java
│   │   │   ├── Service.java
│   │   │   ├── Utilisateur.java
│   │   │   └── Role.java (enum)
│   │   ├── repository/                        # Spring Data JPA
│   │   │   ├── PatientRepository.java
│   │   │   ├── SoinRepository.java
│   │   │   ├── ServiceRepository.java
│   │   │   └── UtilisateurRepository.java
│   │   ├── service/                           # Business Logic
│   │   │   ├── PatientService.java
│   │   │   ├── SoinService.java
│   │   │   └── ServiceService.java
│   │   └── controller/                        # REST Controllers
│   │       ├── PatientController.java
│   │       ├── SoinController.java
│   │       └── ServiceController.java
│   └── resources/
│       ├── application.properties             # Configuration
│       └── data.sql                           # Données initiales
├── pom.xml                                    # Maven dependencies
└── Dockerfile                                 # Docker image

```

## ✅ Fichiers Créés

### Entités JPA (5 fichiers)
- ✅ `Patient.java` - Entité patient avec relations
- ✅ `Soin.java` - Entité soin (care record)
- ✅ `Service.java` - Entité service hospitalier
- ✅ `Utilisateur.java` - Entité utilisateur
- ✅ `Role.java` - Enum des rôles (ADMIN, FINANCIER, MEDECIN)

### Repositories (4 fichiers)
- ✅ `PatientRepository.java` - Avec recherche personnalisée
- ✅ `SoinRepository.java` - Avec filtres par patient/service
- ✅ `ServiceRepository.java`
- ✅ `UtilisateurRepository.java` - Avec recherche par email

### Services (3 fichiers)
- ✅ `PatientService.java` - CRUD + recherche
- ✅ `SoinService.java` - CRUD + filtres
- ✅ `ServiceService.java` - CRUD

### Controllers REST (3 fichiers)
- ✅ `PatientController.java` - `/api/patients`
- ✅ `SoinController.java` - `/api/soins`
- ✅ `ServiceController.java` - `/api/services`

### Configuration (2 fichiers)
- ✅ `WebConfig.java` - CORS configuration
- ✅ `application.properties` - PostgreSQL + JWT config

### Autres (3 fichiers)
- ✅ `HospitalDashboardApplication.java` - Main class
- ✅ `data.sql` - Données de test
- ✅ `Dockerfile` - Image Docker

## 🚀 Démarrage Rapide

### Prérequis
- Java 17+
- Maven 3.8+
- PostgreSQL 15+ (ou Docker)

### Option 1: Docker (Recommandé)

```bash
# Depuis la racine du projet
docker-compose up -d

# Vérifier les logs
docker-compose logs -f backend
```

### Option 2: Local

```bash
# 1. Démarrer PostgreSQL
# Créer la base de données 'hospital_db'

# 2. Build et Run
cd backend
mvn clean install
mvn spring-boot:run
```

### Vérification

```bash
# Health check
curl http://localhost:8080/actuator/health

# Test API
curl http://localhost:8080/api/patients
curl http://localhost:8080/api/services
```

## 📡 API Endpoints

### Patients
```
GET    /api/patients           - Liste tous les patients
GET    /api/patients/{id}      - Détails d'un patient
POST   /api/patients           - Créer un patient
PUT    /api/patients/{id}      - Modifier un patient
DELETE /api/patients/{id}      - Supprimer un patient
GET    /api/patients/search?q= - Rechercher patients
```

### Soins
```
GET    /api/soins                  - Liste tous les soins
GET    /api/soins/{id}             - Détails d'un soin
GET    /api/soins/patient/{id}     - Soins d'un patient
GET    /api/soins/service/{id}     - Soins d'un service
POST   /api/soins                  - Créer un soin
DELETE /api/soins/{id}             - Supprimer un soin
```

### Services
```
GET    /api/services       - Liste tous les services
GET    /api/services/{id}  - Détails d'un service
POST   /api/services       - Créer un service
PUT    /api/services/{id}  - Modifier un service
```

## 📊 Données de Test

Le fichier `data.sql` contient :
- **5 services** : Cardiologie, Urgences, Chirurgie, Pédiatrie, Radiologie
- **5 patients** : Dupont, Martin, Bernard, Dubois, Petit
- **6 soins** : Consultations, ECG, Radiographies, etc.
- **3 utilisateurs** : admin, financier, medecin (password: `password`)

## 🔧 Technologies

| Technologie | Version | Usage |
|-------------|---------|-------|
| Spring Boot | 3.2.0 | Framework |
| Spring Data JPA | 3.2.0 | ORM |
| PostgreSQL | 15+ | Database |
| Lombok | Latest | Code reduction |
| Maven | 3.8+ | Build tool |

## 📝 Configuration

### application.properties

```properties
# Database
spring.datasource.url=jdbc:postgresql://localhost:5432/hospital_db
spring.datasource.username=postgres
spring.datasource.password=postgres

# JPA
spring.jpa.hibernate.ddl-auto=update
spring.jpa.show-sql=true

# Server
server.port=8080
```

## 🧪 Tests

```bash
# Run tests
mvn test

# Run with coverage
mvn clean verify

# View coverage report
open target/site/jacoco/index.html
```

## 🐳 Docker

### Build Image

```bash
docker build -t hospital-backend .
```

### Run Container

```bash
docker run -p 8080:8080 \
  -e SPRING_DATASOURCE_URL=jdbc:postgresql://host.docker.internal:5432/hospital_db \
  hospital-backend
```

## 📈 Prochaines Étapes

- [ ] Implémenter JWT Authentication
- [ ] Ajouter Dashboard endpoints
- [ ] Créer tests unitaires
- [ ] Ajouter Swagger/OpenAPI documentation
- [ ] Implémenter algorithme de prévisions
- [ ] Ajouter système d'alertes

## 🎯 Statut

✅ **Backend Fonctionnel** - Prêt pour intégration avec Flutter

- Entités JPA : ✅
- Repositories : ✅
- Services : ✅
- Controllers REST : ✅
- Configuration : ✅
- Docker : ✅
- Données de test : ✅
