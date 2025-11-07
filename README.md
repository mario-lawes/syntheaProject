# Synthea Data Analyis

## Projektziel
Dieses Repository ist ein Übungsprojekt für dbt, Snowflake, SQL und Pandas, basierend auf synthetischen Patientendaten aus Synthea. Ziel ist es, ein typisches Healthcare-Datenmodell aufzubauen, Daten zu transformieren und analytische Marts zu erstellen. Dabei werden verschiedene medizinische Codierungssysteme (ICD11, SNOMED) ineinander überführt.

## Lernziele
- Staging von Rohdaten in dbt
- Kern-Transformationen zur Verknüpfung von Patienten, Encountern, Medikamenten und Prozeduren
- Verwendung und Mapping verschiedener medizinischer Codierungssysteme (ICD11, SNOMED)
- Integration von verschiedenen Datenquellen (Datenbanken, APIs und Web Scraping)
- Erstellung von analytischen Marts und Summary-Tables
- Integration von dbt mit Snowflake
- Analyse und Visualisierung mit Pandas

## dbt-Modellstruktur
- staging – Rohdaten aus Synthea werden hier vorbereitet, bereinigt und vereinheitlicht.
- core – Kern-Transformationen, z. B. Beziehungen zwischen Patienten, Encountern, Medikamenten, Prozeduren etc.
- marts – Aggregierte Übersichten und analytische Tabellen für einfache Auswertungen.
- summary_marts – Zusammenfassende Marts, z. B. für Reports oder KPIs.


---

**Hinweis:** Der folgende Block ist eine Zusammenfassung der Synthea-Projektwebseite, generiert mithilfe eines Large Language Models (LLM) via Snowflake Cortex.

---

Synthea is an open-source, synthetic patient generator that models medical histories of synthetic patients, providing realistic, free data for academic research, Health IT industry, and policy formation. The data is informed by academic publications and real-world statistics, and is exported in various data standards. Synthea empowers Health IT development and research with a virtually limitless supply of synthetic patients, and is driven by a global community of developers and experts. The MITRE Corporation, a not-for-profit company, is involved in its creation and growth.

*Generated with Snowflake Cortex LLM on Synthea website content.*
