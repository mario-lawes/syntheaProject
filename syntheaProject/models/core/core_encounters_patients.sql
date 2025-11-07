{{ config(materialized = 'view')}}

SELECT 
p.PATIENT_ID,
p.BIRTHDATE,
p.DEATHDATE,
p.GENDER,
p.RACE,
p.ETHNICITY,
p.STATE,
p.COUNTY,
e.ORG_ID,
e.ENCOUNTER_ID,
e.START_DATE,
e.STOP_DATE,
e.ENCOUNTER_CLASS,
e.ENC_DESCRIPTION,
e.ENC_BASE_COST,
e.ENC_TOTAL_CLAIM_CAST,
e.ENC_PAYER_COVERAGE,
e.ENC_REASON,
o.ORG_NAME,
o.ORG_STATE,
o.ORG_REVENUE
FROM {{ ref('stg_encounters') }} e
LEFT JOIN {{ ref('stg_patients') }} p ON p.PATIENT_ID = e.PATIENT_ID
LEFT JOIN {{ ref('stg_organizations') }} o ON e.ORG_ID = o.ORG_ID
