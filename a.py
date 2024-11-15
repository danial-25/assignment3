import requests

# Define the URL to send the POST request to
url = 'https://countriesnow.space/api/v0.1/countries/population'

# Define the data to send in the POST request (as a dictionary)
data = {
	"country": "denmark"
}

# Send the POST request
response = requests.post(url, data=data)

# Check if the request was successful
if response.status_code == 200:
    response_data = response.json()
    column_value = response_data.get('data')['populationCounts'][-1]['value']
    print(column_value)
else:
    print('Request failed with status code:', response.status_code)
