{{ config(materialized = 'table')}}

WITH PATIENT_INFO AS (
    SELECT DISTINCT
        PATIENT_ID,
        BIRTHDATE,
        DEATHDATE,
        CASE WHEN DEATHDATE IS NULL THEN DATEDIFF(year, BIRTHDATE, CURRENT_DATE) ELSE NULL END AS AGE,
        GENDER,
        RACE,
        ETHNICITY,
        STATE,
        COUNTY
    FROM {{ ref('core_encounters_patients') }}
),

NUM_ENCOUNTERS AS (
    SELECT 
        PATIENT_ID,
        COUNT(*) AS NUM_ENCOUNTERS
    FROM {{ ref('core_encounters_patients') }}
    GROUP BY PATIENT_ID
)

SELECT
    p.PATIENT_ID,
    p.BIRTHDATE,
    p.DEATHDATE,
    p.AGE,
    p.GENDER,
    p.RACE,
    p.ETHNICITY,
    p.STATE,
    p.COUNTY,
    n.NUM_ENCOUNTERS
FROM PATIENT_INFO p
LEFT JOIN NUM_ENCOUNTERS n ON p.PATIENT_ID = n.PATIENT_ID

