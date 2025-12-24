# Guide de Présentation — SonarQube (Hospital Backend)

Ce guide vous fournit un plan prêt-à-présenter, des notes de discours, les captures à montrer, et les commandes pour reproduire. Il s’appuie sur le projet Hospital Financial Dashboard API.

---

## 1) Objectifs & Contexte
- **But**: Assurer la qualité, la sécurité et la maintenabilité du backend via SonarQube.
- **Stack**: Java 17, Spring Boot 3.2.0, Maven.
- **Projet analysé**: `Hospital-Backend` sur SonarQube local.
- **Résultat actuel**: Quality Gate **PASSED**.

---

## 2) Qu’est-ce que SonarQube ?
- **Quality Profile**: Définit **quelles règles** sont appliquées.
- **Quality Gate**: Définit **quand** l’analyse est considérée **réussie** ou **échouée**.
- **Métriques clés**: Bugs, Vulnerabilities, Code Smells, Coverage, Duplications, Security Hotspots, Ratings (A–E).

---

## 3) Architecture & Setup
- **Serveur**: SonarQube Community v9.9.8 sur `http://localhost:9000`.
- **Project Key**: `Hospital-Backend`.
- **Intégration Maven**: plugin `sonar-maven-plugin` + token utilisateur.
- **Coverage**: JaCoCo (rapport XML).

### Fichier projet
- Voir [backend/pom.xml](backend/pom.xml)

### Commandes d’analyse
```bash
cd backend
mvn clean verify sonar:sonar
# ou en précisant le token
mvn sonar:sonar -Dsonar.login=<TOKEN>
```

---

## 4) Quality Profile (Règles)
- **Profil appliqué**: "Hospital Java Profile" (extension de Sonar way).
- **Pourquoi**: Hériter des bonnes pratiques, permettre des ajouts spécifiques.
- **Où le montrer**: Project Settings → Quality Profiles (Java).

### À dire
- Le profil personnalisé garde l’essentiel de Sonar way tout en offrant de la flexibilité.

---

## 5) Quality Gate (Seuils)
- **Gate**: "Hospital Backend Quality Gate".
- **Conditions** (New Code): Coverage, Duplications, Ratings (A), Security Hotspots Reviewed (assoupli), etc.
- **Où le montrer**: Project Settings → Quality Gate.

### À dire
- Le gate est adapté au contexte actuel, avec un plan pour **resserrer** les seuils (Hotspots reviewed → 100%).

---

## 6) Résultats d’Analyse (Dashboard)
- **Global**: 7 bugs, 0 vulnérabilités, 34 smells, 8 hotspots, coverage 0%, duplications 0.0%.
- **New Code**: 0 bugs, 0 vulnérabilités, 0 smells, 1 hotspot.
- **Ratings**: A (Reliability/Security/Maintainability), E (Security Review) — à améliorer via reviews.

### Où le montrer
- Dashboard: [http://localhost:9000/dashboard?id=Hospital-Backend](http://localhost:9000/dashboard?id=Hospital-Backend)

### À dire
- Le **Quality Gate** est **PASSED**; un plan d’amélioration est défini pour coverage & sécurité.

---

## 7) Security Hotspots (Exemples)
- **Cas**: Hard-coded credential dans [backend/pom.xml](backend/pom.xml) (token).
- **Action**: Utiliser des **variables d’environnement**/CI secrets.
- **Où le montrer**: Security Hotspots.

### À dire
- Processus de **review**: prioriser HIGH, comment, attacher un plan de correction.

---

## 8) Issues Prioritaires
- **Constantes dupliquées** (12 occurrences), **wildcards** génériques, optimisation `Stream.collect()`.
- **Dette technique**: ~5h 20min.
- **Où le montrer**: Issues avec filtres (Bugs, Smells, Severity).

### À dire
- Stratégie: corriger d’abord ce qui **réduit la dette** et **améliore la lisibilité**.

---

## 9) Plan d’Action
- **Court terme (1–2 sem.)**: tests unitaires & intégration (objectif 50%), review des hotspots HIGH.
- **Moyen terme (3–4 sem.)**: coverage → 80%, supprimer constantes dupliquées, 100% hotspots reviewés.
- **Long terme**: maintenir gate PASSED, intégrer en CI/CD, revue trimestrielle du Quality Profile.

---

## 10) Intégration CI/CD
- **Étapes**:
  - Exécuter l’analyse dans pipeline: `mvn clean verify sonar:sonar`.
  - **Fail the build** si Quality Gate = FAILED.
  - Stocker token dans le système de **secrets**.
- **Bénéfice**: Empêche la régression qualité en production.

---

## 11) Démo — Script rapide (5–7 minutes)
- Slide 1–2: Contexte & SonarQube (1 min).
- Slide 3: `pom.xml`, plugin & token (1 min).
- Slide 4: Quality Profile (30 s).
- Slide 5: Quality Gate (30 s).
- Slide 6: Dashboard — métriques clés (1 min).
- Slide 7–8: Hotspots & Issues — un exemple concret (1–2 min).
- Slide 9–10: Plan & CI/CD (1–2 min).
- Slide 11: Conclusion & Q/R.

---

## 12) Captures à Préparer
1. **Dashboard global** (Quality Gate PASSED, métriques).
2. **Quality Gate** (sélection "Hospital Backend Quality Gate").
3. **Quality Profile** ("Hospital Java Profile" appliqué).
4. **Issues** (liste + filtres).
5. **Security Hotspots** (hard-coded credential).

---

## 13) Commandes & Reproduction
```bash
# Lancer l’analyse locale
cd backend
mvn clean verify sonar:sonar

# Si token nécessaire
mvn sonar:sonar -Dsonar.login=<NOUVEAU_TOKEN>
```

---

## 14) Pièges & Dépannage
- **Token invalide**: régénérer via Account → Security, remplacer dans `pom.xml` ou passer en `-Dsonar.login`.
- **SonarCloud vs local**: vérifier `sonar.host.url` = `http://localhost:9000`.
- **Coverage à 0%**: vérifier JaCoCo XML dans [backend/pom.xml](backend/pom.xml) et l’existence de `target/site/jacoco/jacoco.xml`.
- **Pas de Dart/Flutter**: SonarQube 9.9 n’a pas de plugin officiel — analyser le backend uniquement.

---

## 15) Conclusion
- SonarQube apporte **visibilité** et **discipline**.
- Le projet est **PASSED** mais doit améliorer **coverage** et **security reviews**.
- Feuille de route claire: tests, revue hotspots, CI/CD robuste.
