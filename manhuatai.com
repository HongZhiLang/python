import requests
from bs4 import BeautifulSoup
from lxml import etree
for i in range(1,6):
    r = requests.get("http://www.manhuatai.com/all_p"+ str(i)+".html")
    soup = BeautifulSoup(r.text, "html.parser")
    de = etree.htmlfile(r)
    div_list = soup.find_all('div', class_='wrapright')
    for list in div_list:
        title = list.find('li', class_="title").text.strip()
        type = list.find('li', class_="type").text.strip()
        print(" ")
        status = list.find('li', class_="status").text.strip()
        detail = de.xpath()
        print("标题:"+title+"  "+type+"  "+status+"  "+detail)
        '''with open('1.txt', 'a+') as txt:
            txt.write((title)+"\r\n")
            txt.write((type) + "\r\n")
            txt.write((status) + "\r\n")
            txt.write((detail) + "\r\n")
        '''

    
