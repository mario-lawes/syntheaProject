{{ config(materialized = 'view')}}

SELECT
    Id AS ORG_ID, 
    NAME AS ORG_NAME,
    STATE AS ORG_STATE,
    LAT AS ORG_LAT,
    LON AS ORG_LON,
    TRY_CAST(NULLIF(REVENUE, '') AS FLOAT) AS ORG_REVENUE,

FROM {{ source('synthea_raw', 'organizations')}} 