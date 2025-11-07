{{ config(materialized = 'table') }}

WITH org_enc AS (
    SELECT
        ORG_NAME,
        ORG_REVENUE,
        PATIENT_ID,
        ENCOUNTER_ID,
        ENC_PRO_COST,
        EXTRACT('year', START_DATE) AS YEAR
    FROM {{ ref('mart_organizations_overview') }}
)

SELECT 
    ORG_NAME,
    ORG_REVENUE,
    YEAR,
    COUNT(DISTINCT PATIENT_ID) AS NUM_PAT,
    COUNT(DISTINCT ENCOUNTER_ID) AS NUM_ENC,
    SUM(ENC_PRO_COST) AS TOTAL_COSTS
FROM org_enc
GROUP BY ORG_NAME, ORG_REVENUE, YEAR
