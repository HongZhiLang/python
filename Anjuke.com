import requests
from bs4 import BeautifulSoup
import time
headers={'User-Agent':'Mozilla/5.0'}
for i in range(1,10):
    url='https://tianjin.anjuke.com/sale/p1/#filtersort'
    r=requests.get(url,headers=headers)
    print('现在爬取到第',i,'页')
    soup=BeautifulSoup(r.text,"lxml")
    house_list=soup.find_all('li',class_="list-item")
    for house in house_list:
            name=house.find('div',class_='house-title').a.text.strip()
            price=house.find('span',class_='price-det').text.strip()
            price_area=house.find('span',class_='unit-price').text.strip()
            no_room=house.find('div',class_='details-item').span.text
            area=house.find('div',class_='details-item').contents[3].text
            floor=house.find('div',class_='details-item').contents[5].text
            year=house.find('div',class_='details-item').contents[7].text
            broker=house.find('span',class_='brokername').text
            broker=broker[1:]
            address=house.find('span',class_='comm-address').text.strip()
            address=address.replace('\xa0\xa0\n      ','')
            print("名字是",name)
            print("价格是",price)
            print("价格区间是",price_area)
            print("联系人是",broker)
            time.sleep(5)
        
    
