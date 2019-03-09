import requests

class ReadXML():

    def transformData(self):
        headers = {
            'Content-Type': 'application/json',
        }

        query = {'q':'%7B%22query%22%20%3A%20%7B%22match_all%22%3A%20%7B%7D%7D%7D'}

        response = requests.get('http://elasticsearch:9200/frenchnews/_search', headers=headers, params=query)
        result = response.json()
        print("result")
        print(result)
        return result

