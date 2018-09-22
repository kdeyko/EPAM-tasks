import requests
import json
from bs4 import BeautifulSoup

url = 'https://imdb.com/chart/top'
page = requests.get(url).text
bs = BeautifulSoup(page, features="html.parser")

result = []

full_list = bs.tbody.find_all('tr')

for movie in full_list:
    mv = movie.contents[3]
    res = {}

    name = mv.a.contents[0]
    res['name'] = name

    pos = int(mv.contents[0].strip().replace('.', ''))
    res['pos'] = pos

    rating = float(movie.contents[5].strong.contents[0])
    res['rating'] = rating

    staff = []
    for chel in mv.a['title'].split(','):
        staff.append(chel.strip())

    director = staff[0].replace(' (dir.)', '')
    res['director'] = director

    actors = staff[1:]
    res['actors'] = actors

    result.append(res)

with open('top250.json', 'w') as file:
    json.dump(result, file, ensure_ascii=False, indent=2)
