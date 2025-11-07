{{ config(materialized = 'view') }}

SELECT 
    p.PATIENT_ID,
    p.FIRST_NAME,
    p.LAST_NAME,
    p.BIRTHDATE,
    p.DEATHDATE,
    p.GENDER,
    p.RACE,
    p.ETHNICITY,
    e.ENCOUNTER_ID,
    e.START_DATE,
    e.STOP_DATE,
    e.ENCOUNTER_CLASS,
    e.ENC_DESCRIPTION,
    e.ENC_BASE_COST,
    e.ENC_TOTAL_CLAIM_CAST,
    e.ENC_PAYER_COVERAGE,
    e.ENC_REASON
FROM {{ ref('stg_encounters') }} e
LEFT JOIN {{ ref('stg_patients') }} p ON p.PATIENT_ID = e.PATIENT_ID
