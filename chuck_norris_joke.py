import requests

def get_joke():
    response = requests.get('https://api.chucknorris.io/jokes/random')
    if response.status_code == 200:
        joke = response.json()['value']
        print(joke)
    else:
        print('Could not retrieve a joke.')

if __name__ == '__main__':
    get_joke()
