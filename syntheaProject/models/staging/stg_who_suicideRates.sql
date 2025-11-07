{{ config(materialized='view') }}

SELECT
    Country,
    ParentLocation AS Continent,
    TimeDim AS Year,
    CASE 
        WHEN Dim1 = 'SEX_MLE' THEN 'M'
        WHEN Dim1 = 'SEX_FMLE' THEN 'F'
        ELSE 'Unknown'
    END AS GENDER,
    NumericValue AS SuicideRate,
    Date AS LastUpdate
FROM {{ ref('who_suicideRates') }}
WHERE Country <> 'not found'