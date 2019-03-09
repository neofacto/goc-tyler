import requests
import json

class ReadXML():

    def transformData(self):
        headers = {
            'Content-Type': 'application/json',
        }

        query = {'q':'%7B%22_source%22%3A%20%22content%22%2C%22query%22%20%3A%20%7B%22term%22%3A%20%7B%22content%22%3A%20%22a%22%7D%7D%7D'}

        response = requests.get('http://elasticsearch:9200/frenchnews/_search', headers=headers, params=query)
        j = json.loads(response.text)
        for key in j['hits']['hits']:
            return key

