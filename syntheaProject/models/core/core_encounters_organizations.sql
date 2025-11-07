{{ config(materialized = 'view')}}

SELECT 
e.PATIENT_ID,
e.ENCOUNTER_ID,
e.START_DATE,
e.STOP_DATE,
e.ENCOUNTER_CLASS,
e.ENC_DESCRIPTION,
e.ENC_REASON,
o.ORG_NAME,
o.ORG_STATE,
o.ORG_REVENUE,
p.PRO_DATE,
p.PRO_DESCRIPTION,
p.PRO_COST,
p.PRO_REASON
FROM {{ ref('stg_encounters') }} e
LEFT JOIN {{ ref('stg_organizations') }} o ON e.ORG_ID = o.ORG_ID
LEFT JOIN {{ ref('stg_procedures') }} p ON p.PATIENT_ID = e.PATIENT_ID AND p.ENCOUNTER_ID = e.ENCOUNTER_ID

