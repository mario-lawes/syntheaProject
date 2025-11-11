import requests
from bs4 import BeautifulSoup
import keyring
import snowflake.connector
import pandas as pd

response = requests.get('https://synthetichealth.github.io/synthea/')
soup = BeautifulSoup(response.content, 'html.parser')
text = soup.get_text(separator=" ", strip=True)
text_sql = text.replace("'", "''")

snowflakePW = keyring.get_password("snowflake", "mlawes")
conn = snowflake.connector.connect(
    account = "PCNZXXA-WJB27787",
    user = "mlawes",
    password=snowflakePW,
    warehouse='COMPUTE_WH',
    database='SYNTHEA',
    schema='_ANALYTICS'
)

query = f"""
SELECT SNOWFLAKE.CORTEX.SUMMARIZE('{text_sql}') AS summary
"""

textsummary = pd.read_sql(query, conn)['SUMMARY'][0]


readme_content = f"""

# Synthea Gesundheitsdaten

## Projektbeschreibung

In diesem Übungsprojekt wende ich **dbt** in Verbindung mit **Snowflake** auf synthetische Patient*innendaten von [Synthea](https://synthea.mitre.org) an. Ziel ist es, ein **Datenmodell für prototypische Gesundheitsdaten** zu entwickeln. Dazu werden die Rohdaten mithilfe von **dbt/SQL** transformiert, durch **API-Abfragen** (z. B. Suizidraten der WHO) angereichert und **Mappings zwischen den Codierungssystemen SNOMED und ICD-11** vorgenommen.  

Die final bereinigten und aufbereiteten Daten werden in **Datamarts** abgelegt und anschließend mithilfe von **Jupyter Notebooks**, **Quarto-Reports** und **Preset-Dashboards** hinsichtlich verschiedener inhaltlicher Fragestellungen analysiert und für Anwender*innen aufbereitet.

---

## Lernziele

Dieses Projekt dient als praktische Übung, um zentrale Kompetenzen in **Data Engineering** und **Analytics Engineering** zu entwickeln:

- **Datenintegration:** Einlesen und Vereinheitlichen von Rohdaten aus verschiedenen Quellen (CSV, APIs).
- **Transformation in dbt:** Aufbau modularer, dokumentierter und getesteter Transformationen in **dbt**.
- **Medizinische Codierung:** Umgang mit und Mapping zwischen **ICD-11** und **SNOMED**.
- **Snowflake-Integration:** Nutzung von **Snowflake** als skalierbare Cloud-Datenbank für die dbt-Pipeline.
- **Modellierung:** Entwicklung einer klar strukturierten, mehrschichtigen Datenarchitektur (staging, core, marts).
- **Analyse & Reporting:** Erstellung analytischer Tabellen und Visualisierungen mit **Pandas**, **Quarto** und **Preset**.
- **Best Practices:** Anwendung von Versionierung, Dokumentation und modularer Pipeline-Struktur im dbt-Ökosystem.

---

## dbt-Modellstruktur

Die Projektstruktur folgt dem gängigen **dbt-Standardmodell**, das Daten schrittweise von Rohdaten zu analytischen Marts transformiert:

- **`staging/`** – Vorbereitung und Bereinigung der Rohdaten aus Synthea (z. B. Standardisierung von Datumsformaten, Codes, Schlüsseln).
- **`core/`** – Aufbau der Kernmodelle mit inhaltlichen Beziehungen zwischen Patient*innen, Encountern, Diagnosen, Medikamenten, Prozeduren und Organisationen.
- **`marts/`** – Erstellung von analytischen Tabellen und Datamarts für spezifische Fragestellungen (z. B. Krankheitsverläufe, Medikamentennutzung).
- **`summary_marts/`** – Aggregierte Marts und KPI-Tabellen für Berichte, Dashboards und explorative Analysen.

---

## Datenquellen

- `conditions.csv` – Krankheitsdiagnosen ([Synthea](https://synthea.mitre.org))  
- `encounters.csv` – Arztkontakte und Behandlungsereignisse ([Synthea](https://synthea.mitre.org))  
- `medications.csv` – Verschreibungen und Medikamentendaten ([Synthea](https://synthea.mitre.org))  
- `observations.csv` – Beobachtungen und Messwerte ([Synthea](https://synthea.mitre.org))  
- `organizations.csv` – Einrichtungen des Gesundheitswesens ([Synthea](https://synthea.mitre.org))  
- `patients.csv` – Basisinformationen zu Patient*innen ([Synthea](https://synthea.mitre.org))  
- `procedures.csv` – Behandlungs- und Operationsdaten ([Synthea](https://synthea.mitre.org))  
- **WHO API:** [Suizidraten (MH_12)](https://ghoapi.azureedge.net/api/MH_12)  
- **SNOMED ↔ ICD-11 Mapping:** [snomed.org/maps](https://www.snomed.org/maps)

---

**Hinweis:** Der folgende Block ist eine Zusammenfassung der Synthea-Projektwebseite, generiert mithilfe eines Large Language Models (LLM) via Snowflake Cortex.

---

{textsummary}

*Generated with Snowflake Cortex LLM on Synthea website content.*
"""

with open("../README.md", "w", encoding="utf-8") as f:
    f.write(readme_content)