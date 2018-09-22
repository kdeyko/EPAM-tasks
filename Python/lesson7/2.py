import requests
from bs4 import BeautifulSoup

'''
Создать парсер для станиц википедии используя requests и beautifullsoup. Парсер должен:
•	Возвращать список доступных языков и ссылки на страницы на этих языках
•	Должен уметь считать количество таблиц на странице
•	Получать данные из таблиц
'''

url = 'https://ru.wikipedia.org/wiki/Чили'
page = requests.get(url).text
bs = BeautifulSoup(page, features="html.parser")

langs = bs.find(id="p-lang")

for lang in langs.ul:
    if str(type(lang)) != '<class \'bs4.element.NavigableString\'>':
        print(lang.a.contents[0], ' : ', lang.a['href'])

