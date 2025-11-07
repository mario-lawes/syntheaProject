{{ config(materialized = 'view')}}

SELECT 
c.COND_START,
c.COND_STOP,
c.COND_DESCRIPTION,
c.CODE,
mapping.ICD10_CODE,
e.PATIENT_ID,
e.ENCOUNTER_ID,
e.START_DATE,
e.STOP_DATE,
e.ENCOUNTER_CLASS,
e.ENC_DESCRIPTION,
e.ENC_BASE_COST,
e.ENC_TOTAL_CLAIM_CAST,
e.ENC_PAYER_COVERAGE,
p.PRO_DATE,
p.PRO_DESCRIPTION,
p.PRO_COST,
p.PRO_REASON
FROM {{ ref('stg_conditions') }} c
LEFT JOIN {{ ref('snomed_to_icd11')}} mapping ON mapping.SNOMED_CODE = c.CODE
LEFT JOIN {{ ref('stg_encounters') }} e ON e.ENCOUNTER_ID = c.ENCOUNTER_ID
LEFT JOIN {{ ref('stg_procedures') }} p ON p.PATIENT_ID = e.PATIENT_ID AND p.ENCOUNTER_ID = e.ENCOUNTER_ID