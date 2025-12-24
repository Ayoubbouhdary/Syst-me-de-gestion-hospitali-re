# PLAN D'ASSURANCE QUALITÉ (PAQ)

## Système de Gestion Hospitalière

---

| **Information** | **Détail** |
|-----------------|------------|
| **Projet** | Système de Gestion Hospitalière |
| **Version du document** | 1.0 |
| **Date de création** | 14 Décembre 2025 |
| **Auteur** | Équipe de développement (BOUHDARY Ayoub, GUEDAD Hassane, GUEDAD Mouhssine) |
| **Statut** | En vigueur |

---

## TABLE DES MATIÈRES

1. [Introduction](#1-introduction)
2. [Objectifs du PAQ](#2-objectifs-du-paq)
3. [Périmètre du projet](#3-périmètre-du-projet)
4. [Organisation et responsabilités](#4-organisation-et-responsabilités)
5. [Gestion de la documentation](#5-gestion-de-la-documentation)
6. [Gestion de configuration](#6-gestion-de-configuration)
7. [Processus de développement](#7-processus-de-développement)
8. [Assurance qualité du code](#8-assurance-qualité-du-code)
9. [Stratégie de tests](#9-stratégie-de-tests)
10. [Gestion des anomalies](#10-gestion-des-anomalies)
11. [Sécurité](#11-sécurité)
12. [Revue et audit](#12-revue-et-audit)
13. [Indicateurs qualité](#13-indicateurs-qualité)
14. [Annexes](#14-annexes)

---

## 1. INTRODUCTION

### 1.1 Objet du document

Le présent Plan d'Assurance Qualité (PAQ) définit l'ensemble des dispositions prises pour garantir la qualité du **Système de Gestion Hospitalière**. Il décrit les processus, les normes, les outils et les responsabilités mis en œuvre tout au long du cycle de vie du projet.

### 1.2 Documents de référence

| Référence | Document |
|-----------|----------|
| REF-001 | Cahier des charges fonctionnel |
| REF-002 | Spécifications techniques |
| REF-003 | ARCHITECTURE.md |
| REF-004 | ARCHITECTURE_FINANCIERE.md |
| REF-005 | Guide d'implémentation |

### 1.3 Terminologie

| Terme | Définition |
|-------|------------|
| **PAQ** | Plan d'Assurance Qualité |
| **MOA** | Maîtrise d'Ouvrage |
| **MOE** | Maîtrise d'Œuvre |
| **QA** | Quality Assurance (Assurance Qualité) |
| **CI/CD** | Continuous Integration / Continuous Deployment |
| **PR** | Pull Request |
| **UT** | Tests Unitaires |
| **IT** | Tests d'Intégration |

---

## 2. OBJECTIFS DU PAQ

### 2.1 Objectifs principaux

1. **Garantir la conformité** aux exigences fonctionnelles et techniques
2. **Assurer la traçabilité** des exigences jusqu'à leur implémentation
3. **Maintenir un niveau de qualité** constant du code source
4. **Prévenir les défauts** par des processus de revue et de test
5. **Faciliter la maintenance** et l'évolutivité du système

### 2.2 Critères de qualité

| Critère | Description | Objectif |
|---------|-------------|----------|
| **Fiabilité** | Stabilité du système | 99.9% de disponibilité |
| **Performance** | Temps de réponse | < 2 secondes |
| **Sécurité** | Protection des données | Conformité RGPD |
| **Maintenabilité** | Facilité de modification | Couverture de tests > 80% |
| **Utilisabilité** | Ergonomie | Score SUS > 70 |
| **Portabilité** | Multi-plateforme | Web, Android, iOS, Windows |

---

## 3. PÉRIMÈTRE DU PROJET

### 3.1 Description fonctionnelle

Le Système de Gestion Hospitalière couvre les modules suivants :

| Module | Fonctionnalités |
|--------|-----------------|
| **Authentification** | Connexion sécurisée, JWT, gestion des sessions |
| **Dashboard** | Tableau de bord, statistiques, indicateurs clés |
| **Patients** | CRUD patients, historique médical, dossiers |
| **Services** | Gestion des départements, budgets par service |
| **Soins** | Enregistrement des soins, coûts, types de soins |
| **Rendez-vous** | Planification, calendrier, statuts |
| **Finances** | Revenus, dépenses, exports (PDF, Excel, CSV) |
| **Rapports** | Génération de rapports, graphiques |
| **Notifications** | Alertes, rappels, fil d'activité |
| **Paramètres** | Configuration, langue, thème, sécurité |

### 3.2 Architecture technique

```
┌─────────────────────────────────────────────────────────────┐
│                    FRONTEND (Flutter)                        │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────────────┐  │
│  │   Web App   │  │ Mobile App  │  │   Desktop App       │  │
│  │  (Port 3000)│  │ (Android/iOS│  │   (Windows)         │  │
│  └─────────────┘  └─────────────┘  └─────────────────────┘  │
└─────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────┐
│                 BACKEND (Spring Boot)                        │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────────────┐  │
│  │ REST API    │  │ Auth/JWT    │  │   Business Logic    │  │
│  │ (Port 8080) │  │ + BCrypt    │  │                     │  │
│  └─────────────┘  └─────────────┘  └─────────────────────┘  │
└─────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────┐
│                   BASE DE DONNÉES                            │
│  ┌─────────────────────────────────────────────────────────┐│
│  │              PostgreSQL (Port 5432)                     ││
│  └─────────────────────────────────────────────────────────┘│
└─────────────────────────────────────────────────────────────┘
```

### 3.3 Technologies utilisées

| Composant | Technologie | Version |
|-----------|-------------|---------|
| Frontend | Flutter/Dart | 3.x |
| State Management | Riverpod | 2.x |
| Routing | GoRouter | 14.x |
| Backend | Spring Boot | 3.2.0 |
| Sécurité | Spring Security + JWT | 6.x |
| Base de données | PostgreSQL | 15.x |
| Conteneurisation | Docker | 24.x |
| CI/CD | GitHub Actions | - |

---

## 4. ORGANISATION ET RESPONSABILITÉS

### 4.1 Organigramme du projet

```
                    ┌────────────────────────────────┐
                    │      ÉQUIPE PROJET (3 pers.)   │
                    └────────────────┬───────────────┘
                                     │
         ┌───────────────────────────┼───────────────────────────┐
         │                           │                           │
         ▼                           ▼                           ▼
┌─────────────────────┐  ┌─────────────────────┐  ┌─────────────────────┐
│   GUEDAD Hassan     │  │  GUEDAD Mouhssine   │  │   BOUHDARY Ayoub    │
│                     │  │                     │  │                     │
│  🎨 FRONTEND        │  │  ⚙️ BACKEND         │  │  🔧 QA & DEVOPS     │
│  • Flutter/Dart     │  │  • Spring Boot      │  │  • Tests            │
│  • UI/UX            │  │  • API REST         │  │  • CI/CD            │
│  • Widgets          │  │  • Sécurité JWT     │  │  • Docker           │
│  • State Management │  │  • Business Logic   │  │  • Base de données  │
└─────────────────────┘  └─────────────────────┘  └─────────────────────┘
```

### 4.2 Répartition des rôles

| Membre | Rôle Principal | Responsabilités |
|--------|----------------|-----------------|
| **GUEDAD Hassan** | Développeur Frontend | Flutter, Dart, UI/UX, Widgets, Riverpod, GoRouter |
| **GUEDAD Mouhssine** | Développeur Backend | Spring Boot, API REST, JWT, Spring Security, JPA |
| **BOUHDARY Ayoub** | QA & DevOps | Tests, CI/CD, Docker, PostgreSQL, SonarQube, JMeter |

### 4.3 Matrice des responsabilités (RACI)

| Activité | GUEDAD H. (Frontend) | GUEDAD M. (Backend) | BOUHDARY A. (QA/DevOps) |
|----------|:--------------------:|:-------------------:|:-----------------------:|
| Architecture Frontend | R | C | I |
| Architecture Backend | C | R | I |
| Développement UI Flutter | R | I | I |
| Développement API REST | I | R | I |
| Base de données PostgreSQL | I | C | R |
| Tests unitaires Frontend | R | I | A |
| Tests unitaires Backend | I | R | A |
| Tests fonctionnels (Selenium) | C | C | R |
| Tests performance (JMeter) | I | C | R |
| Configuration CI/CD | I | I | R |
| Configuration Docker | C | C | R |
| Analyse SonarQube | C | C | R |
| Documentation technique | R | R | R |
| Revue de code | R | R | R |

**Légende :** R = Responsable, A = Approbateur, C = Consulté, I = Informé

### 4.4 Responsabilités détaillées

#### GUEDAD Hassan - Frontend
- Développe l'interface utilisateur avec Flutter/Dart
- Implémente le state management avec Riverpod
- Crée les widgets réutilisables et le design system
- Assure la navigation avec GoRouter
- Gère le support multilingue (FR, EN, AR)
- Rédige les tests widgets Flutter

#### GUEDAD Mouhssine - Backend
- Développe l'API REST avec Spring Boot
- Implémente l'authentification JWT et Spring Security
- Crée les entités JPA et les repositories
- Gère la logique métier (services, contrôleurs)
- Configure les endpoints et la sécurité CORS
- Rédige les tests unitaires JUnit

#### BOUHDARY Ayoub - QA & DevOps
- Configure et maintient PostgreSQL
- Met en place Docker et Docker Compose
- Configure le pipeline CI/CD (GitHub Actions)
- Exécute les analyses SonarQube
- Développe les tests fonctionnels (Selenium)
- Réalise les tests de performance (JMeter)
- Surveille la qualité et les métriques

---

## 5. GESTION DE LA DOCUMENTATION

### 5.1 Liste des livrables documentaires

| Document | Responsable | Format | Fréquence MAJ |
|----------|-------------|--------|---------------|
| PAQ | Chef de Projet | Markdown | Trimestrielle |
| Spécifications fonctionnelles | MOA | PDF | Par version |
| Spécifications techniques | Développeur | Markdown | Continue |
| Documentation API | Développeur | Swagger | Continue |
| Manuel utilisateur | Testeur QA | PDF | Par version |
| Rapport de tests | Testeur QA | PDF | Par sprint |
| Release notes | Chef de Projet | Markdown | Par version |

### 5.2 Conventions de nommage

```
[TYPE]_[NOM]_v[VERSION].[EXTENSION]

Exemples :
- SPEC_ModulePatients_v1.0.pdf
- TEST_RapportSprint5_v1.2.pdf
- DOC_ManuelUtilisateur_v2.0.pdf
```

### 5.3 Gestion des versions documentaires

| Version | Description |
|---------|-------------|
| 0.x | Brouillon, en cours de rédaction |
| 1.0 | Version initiale validée |
| x.y | Mise à jour mineure (y incrémenté) |
| x+1.0 | Mise à jour majeure |

---

## 6. GESTION DE CONFIGURATION

### 6.1 Outil de gestion de versions

- **Outil** : Git
- **Plateforme** : GitHub
- **Repository** : `flutter_project_Syst-me-de-Gestion-Hospitali-re`

### 6.2 Stratégie de branches

```
main (production)
  │
  ├── develop (intégration)
  │     │
  │     ├── hassan-frontend (développement UI Flutter)
  │     │
  │     ├── mouhssine-backend (développement API Spring Boot)
  │     │
  │     └── ayoub-devops (configuration Docker, CI/CD, Tests)
  │
  └── release/[version]
```

| Branche | Responsable | Usage | Protection |
|---------|-------------|-------|------------|
| `main` | Équipe | Code en production | PR obligatoire, 2 approbations |
| `develop` | Équipe | Intégration des features | PR obligatoire, 1 approbation |
| `hassan-frontend` | GUEDAD Hassan | Développement UI Flutter | Libre |
| `mouhssine-backend` | GUEDAD Mouhssine | Développement API REST | Libre |
| `ayoub-devops` | BOUHDARY Ayoub | DevOps, Tests, CI/CD | Libre |
| `ayoub-test` | BOUHDARY Ayoub | Tests QA | Libre |
| `hotfix/*` | Équipe | Corrections urgentes | PR vers main |
| `release/*` | Équipe | Préparation de version | PR vers main et develop |

### 6.3 Convention de commits

Format : `[type]([scope]): [description]`

| Type | Description |
|------|-------------|
| `feat` | Nouvelle fonctionnalité |
| `fix` | Correction de bug |
| `docs` | Documentation |
| `style` | Formatage, pas de changement de code |
| `refactor` | Refactorisation |
| `test` | Ajout/modification de tests |
| `chore` | Maintenance, dépendances |
| `security` | Correction de sécurité |
| `devops` | Configuration CI/CD, Docker |

**Exemples de commits réalisés par l'équipe :**
```
feat(auth): ajouter authentification JWT - par Mouhssine
feat(ui): créer écran de gestion des patients - par Hassan
feat(docker): configurer docker-compose avec PostgreSQL - par Ayoub
fix(patients): corriger la validation du formulaire - par Hassan
fix(api): résoudre erreur CORS sur les endpoints - par Mouhssine
docs(readme): mettre à jour les instructions d'installation - par Ayoub
test(unit): ajouter tests unitaires login controller - par Ayoub
security(auth): implémenter BCrypt pour les mots de passe - par Mouhssine
devops(ci): configurer pipeline GitHub Actions - par Ayoub
feat(services): créer module de gestion des services hospitaliers - par Hassan
feat(backend): implémenter API REST pour les soins - par Mouhssine
chore(deps): mettre à jour dépendances Flutter - par Hassan
```

### 6.4 Processus de Pull Request

```
┌─────────────┐    ┌─────────────┐    ┌─────────────┐    ┌─────────────┐
│   Créer     │───▶│   Review    │───▶│   Tests     │───▶│   Merge     │
│   PR        │    │   Code      │    │   CI/CD     │    │             │
└─────────────┘    └─────────────┘    └─────────────┘    └─────────────┘
```

**Checklist PR :**
- [ ] Le code respecte les normes de codage
- [ ] Les tests unitaires passent
- [ ] La couverture de tests est maintenue
- [ ] La documentation est mise à jour
- [ ] Pas de warnings ou erreurs lint
- [ ] Au moins 1 approbation (2 pour main)

---

## 7. PROCESSUS DE DÉVELOPPEMENT

### 7.1 Méthodologie

Le projet suit une méthodologie **Agile Scrum** :

| Élément | Durée/Fréquence |
|---------|-----------------|
| Sprint | 2 semaines |
| Daily Standup | Quotidien, 15 min |
| Sprint Planning | Début de sprint, 2h |
| Sprint Review | Fin de sprint, 1h |
| Rétrospective | Fin de sprint, 1h |

### 7.2 Cycle de vie d'une User Story

```
┌──────────┐   ┌──────────┐   ┌──────────┐   ┌──────────┐   ┌──────────┐
│  Backlog │──▶│  To Do   │──▶│   In     │──▶│  Review  │──▶│   Done   │
│          │   │          │   │ Progress │   │          │   │          │
└──────────┘   └──────────┘   └──────────┘   └──────────┘   └──────────┘
```

### 7.3 Definition of Done (DoD)

Une User Story est considérée comme **terminée** si :

- [ ] Le code est développé et fonctionnel
- [ ] Les tests unitaires sont écrits (couverture ≥ 80%)
- [ ] Les tests d'intégration passent
- [ ] La revue de code est effectuée et approuvée
- [ ] La documentation est mise à jour
- [ ] Les critères d'acceptation sont validés
- [ ] Le code est mergé dans `develop`
- [ ] Aucune régression détectée

### 7.4 Environnements

| Environnement | Usage | URL | Déploiement |
|---------------|-------|-----|-------------|
| **Local** | Développement | localhost | Manuel |
| **Dev** | Tests internes | dev.hospital.local | Automatique (push develop) |
| **Staging** | Pré-production | staging.hospital.local | Manuel (release) |
| **Production** | Utilisateurs finaux | hospital.com | Manuel (approbation) |

---

## 8. ASSURANCE QUALITÉ DU CODE

### 8.1 Normes de codage

#### Flutter/Dart
- Respect des [Effective Dart Guidelines](https://dart.dev/guides/language/effective-dart)
- Utilisation de `flutter_lints` avec règles strictes
- Formatage automatique avec `dart format`

#### Java/Spring Boot
- Respect des conventions Java standard
- Utilisation de Lombok pour réduire le boilerplate
- Documentation Javadoc obligatoire

### 8.2 Règles de codage spécifiques

```yaml
# analysis_options.yaml
linter:
  rules:
    - always_declare_return_types
    - always_require_non_null_named_parameters
    - annotate_overrides
    - avoid_empty_else
    - avoid_print
    - avoid_relative_lib_imports
    - avoid_returning_null_for_future
    - avoid_slow_async_io
    - avoid_types_as_parameter_names
    - avoid_unused_constructor_parameters
    - await_only_futures
    - camel_case_extensions
    - camel_case_types
    - cancel_subscriptions
    - close_sinks
    - constant_identifier_names
    - prefer_const_constructors
    - prefer_final_fields
    - prefer_final_locals
    - require_trailing_commas
```

### 8.3 Revue de code

#### Objectifs
- Détecter les défauts le plus tôt possible
- Partager les connaissances au sein de l'équipe
- Garantir la cohérence du code

#### Checklist de revue

| Catégorie | Points à vérifier |
|-----------|-------------------|
| **Fonctionnel** | Le code répond-il aux exigences ? |
| **Lisibilité** | Le code est-il clair et compréhensible ? |
| **Performance** | Y a-t-il des optimisations possibles ? |
| **Sécurité** | Y a-t-il des vulnérabilités ? |
| **Tests** | Les tests sont-ils suffisants ? |
| **Documentation** | Le code est-il documenté ? |

### 8.4 Analyse statique

| Outil | Usage | Seuil |
|-------|-------|-------|
| `flutter analyze` | Analyse Dart | 0 erreur, 0 warning |
| SonarQube | Qualité globale | Grade A |
| Dependency Check | Vulnérabilités | 0 critique |

---

## 9. STRATÉGIE DE TESTS

### 9.1 Pyramide des tests

```
                    ┌───────────────┐
                   /│   Tests E2E   │\
                  / │   (5-10%)     │ \
                 /  └───────────────┘  \
                /   ┌───────────────┐   \
               /    │    Tests      │    \
              /     │ d'intégration │     \
             /      │   (20-30%)    │      \
            /       └───────────────┘       \
           /        ┌───────────────┐        \
          /         │    Tests      │         \
         /          │   unitaires   │          \
        /           │   (60-70%)    │           \
       /            └───────────────┘            \
      └──────────────────────────────────────────┘
```

### 9.2 Types de tests

| Type | Description | Outils | Couverture cible |
|------|-------------|--------|------------------|
| **Unitaires** | Test d'une unité isolée | flutter_test, JUnit | ≥ 80% |
| **Widget** | Test des composants UI | flutter_test | ≥ 70% |
| **Intégration** | Test des interactions | integration_test | ≥ 60% |
| **E2E** | Scénarios utilisateur | Selenium, Appium | Critiques |
| **Performance** | Temps de réponse, charge | JMeter | Selon SLA |
| **Sécurité** | Vulnérabilités | OWASP ZAP | 0 critique |

### 9.3 Plan de tests unitaires

#### Frontend (Flutter)

```dart
// Exemple de test unitaire
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('LoginController', () {
    test('should return error when credentials are invalid', () async {
      // Arrange
      final controller = LoginController(mockRepository);
      
      // Act
      await controller.login('wrong@email.com', 'wrongpassword');
      
      // Assert
      expect(controller.state, isA<AsyncError>());
    });
    
    test('should navigate to dashboard on successful login', () async {
      // Arrange
      final controller = LoginController(mockRepository);
      
      // Act
      await controller.login('admin@hospital.com', 'admin123');
      
      // Assert
      expect(controller.state, isA<AsyncData>());
    });
  });
}
```

#### Backend (Spring Boot)

```java
// Exemple de test unitaire
@ExtendWith(MockitoExtension.class)
class AuthServiceTest {
    
    @Mock
    private UtilisateurRepository utilisateurRepository;
    
    @Mock
    private PasswordEncoder passwordEncoder;
    
    @InjectMocks
    private AuthService authService;
    
    @Test
    void login_WithValidCredentials_ShouldReturnToken() {
        // Arrange
        when(utilisateurRepository.findByEmail(anyString()))
            .thenReturn(Optional.of(testUser));
        when(passwordEncoder.matches(anyString(), anyString()))
            .thenReturn(true);
        
        // Act
        LoginResponse response = authService.login(loginRequest);
        
        // Assert
        assertNotNull(response.getToken());
        assertEquals("admin@hospital.com", response.getEmail());
    }
    
    @Test
    void login_WithInvalidPassword_ShouldThrowException() {
        // Arrange
        when(utilisateurRepository.findByEmail(anyString()))
            .thenReturn(Optional.of(testUser));
        when(passwordEncoder.matches(anyString(), anyString()))
            .thenReturn(false);
        
        // Act & Assert
        assertThrows(AuthenticationException.class, 
            () -> authService.login(loginRequest));
    }
}
```

### 9.4 Campagnes de tests

| Phase | Tests exécutés | Critères de sortie |
|-------|----------------|-------------------|
| **Développement** | UT, Widget | 100% passent |
| **Intégration** | IT, API | 100% passent |
| **Pré-release** | E2E, Perf, Sécu | 100% critiques passent |
| **Production** | Smoke tests | 100% passent |

### 9.5 Critères d'acceptation des tests

| Métrique | Seuil minimum | Objectif |
|----------|---------------|----------|
| Couverture globale | 70% | 85% |
| Couverture branches | 60% | 75% |
| Tests passants | 100% | 100% |
| Temps d'exécution UT | < 5 min | < 2 min |
| Temps d'exécution IT | < 15 min | < 10 min |

---

## 10. GESTION DES ANOMALIES

### 10.1 Cycle de vie d'une anomalie

```
┌──────────┐   ┌──────────┐   ┌──────────┐   ┌──────────┐   ┌──────────┐
│ Nouvelle │──▶│ Affectée │──▶│   En     │──▶│ Résolue  │──▶│  Fermée  │
│          │   │          │   │  cours   │   │          │   │          │
└──────────┘   └──────────┘   └──────────┘   └──────────┘   └──────────┘
                                  │                │
                                  │                ▼
                                  │         ┌──────────┐
                                  └────────▶│ Rejetée  │
                                            └──────────┘
```

### 10.2 Classification des anomalies

| Sévérité | Description | Délai de résolution |
|----------|-------------|---------------------|
| **Bloquante** | Système inutilisable | 4 heures |
| **Critique** | Fonctionnalité majeure KO | 24 heures |
| **Majeure** | Fonctionnalité dégradée | 1 semaine |
| **Mineure** | Inconfort utilisateur | 1 sprint |
| **Cosmétique** | Amélioration visuelle | Backlog |

### 10.3 Template de rapport d'anomalie

```markdown
## Titre de l'anomalie

**Sévérité:** [Bloquante/Critique/Majeure/Mineure/Cosmétique]
**Module:** [Auth/Patients/Services/Soins/Finance/...]
**Version:** [x.y.z]
**Environnement:** [Dev/Staging/Production]

### Description
[Description détaillée du problème]

### Étapes de reproduction
1. Étape 1
2. Étape 2
3. ...

### Résultat attendu
[Ce qui devrait se passer]

### Résultat obtenu
[Ce qui se passe réellement]

### Captures d'écran
[Si applicable]

### Logs
[Extraits de logs pertinents]
```

### 10.4 Indicateurs de suivi

| Indicateur | Calcul | Objectif |
|------------|--------|----------|
| Taux de détection | Bugs trouvés en test / Total bugs | > 90% |
| MTTR (Mean Time To Repair) | Temps moyen de résolution | < 48h |
| Taux de réouverture | Bugs réouverts / Bugs fermés | < 5% |
| Densité de défauts | Bugs / KLOC | < 1 |

---

## 11. SÉCURITÉ

### 11.1 Exigences de sécurité

| Domaine | Exigence | Implémentation |
|---------|----------|----------------|
| **Authentification** | Mots de passe sécurisés | BCrypt (coût 10+) |
| **Autorisation** | Contrôle d'accès | JWT + Rôles |
| **Confidentialité** | Chiffrement des données | HTTPS, AES-256 |
| **Intégrité** | Protection contre les modifications | Signatures JWT |
| **Traçabilité** | Journalisation des actions | Logs d'audit |

### 11.2 Mesures de sécurité implémentées

#### Authentification
```
✅ Mots de passe hachés avec BCrypt
✅ Tokens JWT avec expiration (24h)
✅ Invalidation des tokens après changement de mot de passe
✅ Protection contre les attaques par force brute
✅ Validation des entrées utilisateur
```

#### Sécurité API
```
✅ CORS configuré (origines autorisées)
✅ Headers de sécurité (X-Content-Type-Options, etc.)
✅ Rate limiting
✅ Validation des données entrantes
✅ Protection CSRF désactivée (API stateless)
```

#### Sécurité des données
```
✅ Connexion HTTPS obligatoire (production)
✅ Chiffrement des données sensibles
✅ Pas de stockage de mots de passe en clair
✅ Logs sans données sensibles
```

### 11.3 Tests de sécurité

| Test | Outil | Fréquence |
|------|-------|-----------|
| Analyse de vulnérabilités | OWASP ZAP | Hebdomadaire |
| Audit de dépendances | Dependabot | Continue |
| Test d'intrusion | Manuel | Trimestriel |
| Revue de code sécurité | SonarQube | À chaque PR |

### 11.4 Conformité RGPD

| Exigence RGPD | Mesure |
|---------------|--------|
| Consentement | Formulaire de consentement explicite |
| Droit d'accès | Export des données personnelles |
| Droit à l'oubli | Procédure de suppression |
| Portabilité | Export au format standard |
| Minimisation | Collecte limitée aux données nécessaires |

---

## 12. REVUE ET AUDIT

### 12.1 Types de revues

| Type | Fréquence | Participants | Objectif |
|------|-----------|--------------|----------|
| Revue de code | À chaque PR | Développeurs | Qualité du code |
| Revue de sprint | Bi-hebdomadaire | Équipe | Démonstration |
| Revue qualité | Mensuelle | Chef de projet, QA | Métriques |
| Audit interne | Trimestriel | Équipe complète | Conformité PAQ |
| Audit externe | Annuel | Auditeur externe | Certification |

### 12.2 Checklist d'audit qualité

#### Processus
- [ ] Les processus du PAQ sont-ils respectés ?
- [ ] Les revues de code sont-elles systématiques ?
- [ ] Les tests sont-ils exécutés avant chaque merge ?

#### Documentation
- [ ] La documentation est-elle à jour ?
- [ ] Les changements sont-ils tracés ?
- [ ] Les décisions sont-elles documentées ?

#### Code
- [ ] La couverture de tests est-elle suffisante ?
- [ ] Les normes de codage sont-elles respectées ?
- [ ] Les vulnérabilités sont-elles corrigées ?

#### Livrables
- [ ] Les versions sont-elles correctement taguées ?
- [ ] Les release notes sont-elles complètes ?
- [ ] Les environnements sont-ils synchronisés ?

### 12.3 Actions correctives

```
┌─────────────┐   ┌─────────────┐   ┌─────────────┐   ┌─────────────┐
│   Écart     │──▶│  Analyse    │──▶│   Plan      │──▶│   Suivi     │
│  détecté    │   │  des causes │   │  d'action   │   │             │
└─────────────┘   └─────────────┘   └─────────────┘   └─────────────┘
```

---

## 13. INDICATEURS QUALITÉ

### 13.1 Tableau de bord qualité

| Indicateur | Formule | Objectif | Fréquence |
|------------|---------|----------|-----------|
| Couverture de tests | Lignes couvertes / Total lignes | ≥ 80% | Continue |
| Taux de bugs critiques | Bugs critiques / Total bugs | ≤ 5% | Hebdo |
| Vélocité | Story points livrés / Sprint | Stable | Sprint |
| Taux de satisfaction | Notes positives / Total notes | ≥ 4/5 | Mensuel |
| Disponibilité | Uptime / Temps total | ≥ 99.9% | Continue |
| Performance | Requêtes < 2s / Total requêtes | ≥ 95% | Continue |

### 13.2 Seuils d'alerte

| Indicateur | Vert | Orange | Rouge |
|------------|------|--------|-------|
| Couverture tests | ≥ 80% | 70-80% | < 70% |
| Bugs critiques ouverts | 0 | 1-2 | > 2 |
| Dette technique | < 5 jours | 5-10 jours | > 10 jours |
| Temps de build | < 10 min | 10-15 min | > 15 min |

### 13.3 Reporting

| Rapport | Destinataires | Fréquence |
|---------|---------------|-----------|
| Dashboard CI/CD | Équipe | Temps réel |
| Rapport de sprint | Équipe, MOA | Bi-hebdo |
| Rapport qualité mensuel | Direction | Mensuel |
| Bilan qualité projet | Tous | Trimestriel |

---

## 14. ANNEXES

### Annexe A : Glossaire complet

| Terme | Définition |
|-------|------------|
| API | Application Programming Interface |
| BCrypt | Algorithme de hachage de mots de passe |
| CI/CD | Intégration et Déploiement Continus |
| CORS | Cross-Origin Resource Sharing |
| CRUD | Create, Read, Update, Delete |
| DoD | Definition of Done |
| JWT | JSON Web Token |
| KLOC | Kilo Lines of Code (milliers de lignes) |
| MTTR | Mean Time To Repair |
| PR | Pull Request |
| RACI | Responsible, Accountable, Consulted, Informed |
| RGPD | Règlement Général sur la Protection des Données |
| RTL | Right-to-Left (support des langues arabes) |
| SLA | Service Level Agreement |
| SUS | System Usability Scale |
| UT | Unit Test |

### Annexe B : Contacts de l'équipe

| Rôle | Nom | Responsabilités |
|------|-----|-----------------|
| Développeur Frontend | GUEDAD Hassan | Flutter, UI/UX, Widgets, State Management |
| Développeur Backend | GUEDAD Mouhssine | Spring Boot, API REST, JWT, JPA |
| QA & DevOps | BOUHDARY Ayoub | Tests, CI/CD, Docker, PostgreSQL, SonarQube |

### Annexe C : Historique des modifications

| Version | Date | Auteur | Modifications |
|---------|------|--------|---------------|
| 1.0 | 14/12/2025 | BOUHDARY A., GUEDAD H., GUEDAD M. | Création initiale |

### Annexe D : Historique des branches et contributions

| Branche | Créée par | Date création | Description |
|---------|-----------|---------------|-------------|
| `main` | Équipe | 01/10/2024 | Branche principale de production |
| `develop` | Équipe | 01/10/2024 | Branche d'intégration |
| `hassan-frontend` | GUEDAD Hassan | 05/10/2024 | Développement interface Flutter |
| `mouhssine-backend` | GUEDAD Mouhssine | 05/10/2024 | Développement API Spring Boot |
| `ayoub-devops` | BOUHDARY Ayoub | 10/10/2024 | Configuration DevOps et CI/CD |
| `ayoub-test` | BOUHDARY Ayoub | 14/12/2024 | Tests et QA |

### Annexe E : Résumé des contributions par membre

#### GUEDAD Hassan - Frontend (Flutter/Dart)
| Date | Commit | Description |
|------|--------|-------------|
| 05/10/2024 | `feat(ui): initialisation projet Flutter` | Setup initial du projet |
| 15/10/2024 | `feat(auth): créer écran de connexion` | UI de login avec validation |
| 25/10/2024 | `feat(patients): module gestion patients` | Liste, détail, formulaire patients |
| 05/11/2024 | `feat(services): module gestion services` | CRUD services hospitaliers |
| 15/11/2024 | `feat(soins): module gestion soins` | Interface de gestion des soins |
| 01/12/2024 | `feat(i18n): support multilingue FR/EN/AR` | Internationalisation |
| 10/12/2024 | `feat(theme): mode sombre/clair` | Thèmes personnalisables |

#### GUEDAD Mouhssine - Backend (Spring Boot)
| Date | Commit | Description |
|------|--------|-------------|
| 05/10/2024 | `feat(api): initialisation Spring Boot` | Setup backend avec JPA |
| 15/10/2024 | `feat(auth): implémentation JWT` | Authentification sécurisée |
| 20/10/2024 | `feat(security): configuration Spring Security` | Sécurité des endpoints |
| 01/11/2024 | `feat(patients): API REST patients` | CRUD complet patients |
| 10/11/2024 | `feat(services): API REST services` | Endpoints services |
| 20/11/2024 | `feat(soins): API REST soins` | Gestion des soins médicaux |
| 05/12/2024 | `fix(cors): résolution problèmes CORS` | Configuration CORS |
| 12/12/2024 | `security(auth): amélioration sécurité BCrypt` | Renforcement auth |

#### BOUHDARY Ayoub - QA & DevOps
| Date | Commit | Description |
|------|--------|-------------|
| 10/10/2024 | `devops(docker): configuration Docker` | Dockerfile et docker-compose |
| 15/10/2024 | `devops(db): setup PostgreSQL` | Configuration base de données |
| 01/11/2024 | `devops(ci): pipeline GitHub Actions` | CI/CD automatisé |
| 15/11/2024 | `test(unit): tests unitaires Flutter` | Tests login controller |
| 25/11/2024 | `test(widget): tests widgets Flutter` | Tests écran de connexion |
| 05/12/2024 | `devops(sonar): configuration SonarQube` | Analyse qualité code |
| 14/12/2024 | `docs(paq): rédaction Plan Assurance Qualité` | Documentation QA |

---

## APPROBATIONS

| Rôle | Nom | Signature | Date |
|------|-----|-----------|------|
| Développeur Frontend | GUEDAD Hassan | | |
| Développeur Backend | GUEDAD Mouhssine | | |
| QA & DevOps | BOUHDARY Ayoub | | |

---

*Document rédigé par l'équipe de développement du projet Système de Gestion Hospitalière*  
*BOUHDARY Ayoub, GUEDAD Hassan, GUEDAD Mouhssine*  
*EMSI Marrakech - Année universitaire 2024-2025*  
*Dernière mise à jour : 14 Décembre 2025*
