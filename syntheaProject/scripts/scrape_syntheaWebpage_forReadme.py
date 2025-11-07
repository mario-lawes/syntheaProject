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

{textsummary}

*Generated with Snowflake Cortex LLM on Synthea website content.*
"""

with open("../README.md", "w", encoding="utf-8") as f:
    f.write(readme_content)