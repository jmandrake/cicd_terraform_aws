# https://www.alphavantage.co/documentation/

import requests

apiKey = "2SIIGZ3UROSSW5JY"

api_urls = {}
api_urls["url_retail"] = f'https://www.alphavantage.co/query?function=RETAIL_SALES&apikey={apiKey}'
api_urls["url_unemployment"] = f'https://www.alphavantage.co/query?function=UNEMPLOYMENT&apikey={apiKey}'
api_urls["url_gdp"] = f'https://www.alphavantage.co/query?function=REAL_GDP&apikey={apiKey}'
api_urls["url_inflation"] = f'https://www.alphavantage.co/query?function=INFLATION&apikey={apiKey}'
api_urls["url_cpi"] = f'https://www.alphavantage.co/query?function=CPI&apikey={apiKey}'

url = api_urls["url_retail"]

r = requests.get(url)
data = r.json()

print(data)

print("done")