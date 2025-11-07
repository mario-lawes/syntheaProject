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
e.ENCOUNTER_ID,
e.ENC_DESCRIPTION,
e.ENC_BASE_COST,
e.ENC_TOTAL_CLAIM_CAST,
e.ENC_PAYER_COVERAGE,
e.ENC_REASON,
pro.PRO_DATE,
pro.PRO_DESCRIPTION,
pro.PRO_COST,
pro.PRO_REASON,
o.ORG_NAME,
o.ORG_STATE,
o.ORG_REVENUE
FROM {{ ref('stg_encounters') }} e
LEFT JOIN {{ ref('stg_patients') }} p ON p.PATIENT_ID = e.PATIENT_ID
LEFT JOIN {{ ref('stg_procedures') }} pro ON pro.PATIENT_ID = e.PATIENT_ID AND pro.ENCOUNTER_ID = e.ENCOUNTER_ID
LEFT JOIN {{ ref('stg_organizations') }} o ON e.ORG_ID = o.ORG_ID
WHERE pro.PRO_DATE IS NOT NULL