{{ config(materialized = 'table')}}

SELECT
e.PATIENT_ID,
e.GENDER,
e.ENCOUNTER_ID,
e.START_DATE,
e.STOP_DATE,
e.ENCOUNTER_CLASS,
e.ENC_DESCRIPTION,
e.ENC_BASE_COST,
e.ENC_TOTAL_CLAIM_CAST,
e.ENC_PAYER_COVERAGE,
s.SuicideRate
FROM {{ ref('core_encounters_patients') }} e
LEFT JOIN {{ ref('stg_who_suicideRates') }} s ON YEAR(e.START_DATE) = s.Year AND e.GENDER = s.GENDER AND s.COUNTRY = 'United States'
