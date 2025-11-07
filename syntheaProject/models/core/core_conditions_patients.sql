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
c.COND_START,
c.COND_STOP,
c.COND_DESCRIPTION,
c.CODE,
mapping.ICD10_CODE
FROM {{ ref('stg_conditions') }} c
LEFT JOIN {{ ref('stg_patients') }} p ON p.PATIENT_ID = c.PATIENT_ID
LEFT JOIN {{ ref('snomed_to_icd11')}} mapping ON mapping.SNOMED_CODE = c.CODE
