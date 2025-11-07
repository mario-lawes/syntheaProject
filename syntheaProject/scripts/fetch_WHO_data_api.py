import requests
import pandas as pd
import country_converter as coco


# API Request
url = "https://ghoapi.azureedge.net/api/MH_12"
response = requests.get(url)
data = response.json()['value']

# In DataFrame umwandeln
df = pd.json_normalize(data)
df = df[['SpatialDim','ParentLocation', 'TimeDim', 'Dim1', 'NumericValue', 'Date']]
df['Country'] = coco.convert(names = df['SpatialDim'], to = 'name_short')

# Als CSV speichern 
df.to_csv("seeds/who_suicideRates.csv", index=False)

