{{ config(materialized = 'view')}}

SELECT 
p.PATIENT_ID,
p.BIRTHDATE,
p.GENDER,
p.RACE,
p.ETHNICITY,
p.STATE,
p.COUNTY,
m.START_DATE,
m.STOP_DATE,
m.MED_DESCRIPTION,
m.DISPENSES,
m.MED_TOTAL_COST,
m.MED_REASON
FROM {{ ref('stg_medications') }} m
LEFT JOIN {{ ref('stg_patients') }} p ON p.PATIENT_ID = m.PATIENT_ID