import requests
from bs4 import BeautifulSoup
import time

def fetchamazonprice(url):
    try:
        headers = {
            'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.3'
        }
        response = requests.get(url, headers=headers)
        response.raise_for_status()
        soup = BeautifulSoup(response.content, 'html.parser')

        priceWhole = soup.find('span', class_='a-price-whole')
        priceFraction = soup.find('span', class_='a-price-fraction')

        if priceWhole and priceFraction:
            return float(f"{priceWhole.text}{priceFraction.text}".replace(',', '.'))
        elif priceWhole:
            return float(priceWhole.text.replace(',', '.'))
        else:
            return None
    except requests.exceptions.RequestException as e:
        print(f"Error during request: {e}")
        return None
    except Exception as e:
        print(f"An error occurred while reading the price: {e}")
        return None

if __name__ == "__main__":
    producturl = input("Enter the Amazon product page URL to monitor: ")
    intervalseconds = int(input("Enter the price check interval in seconds (e.g., 3600 for 1 hour): "))
    previousprice = fetchamazonprice(producturl)

    if previousprice is None:
        print("Unable to read initial price. The program will terminate.")
    else:
        print(f"Monitoring started. Initial price: {previousprice:.2f}")

        while True:
            time.sleep(intervalseconds)
            currentprice = fetchamazonprice(producturl)

            if currentprice is not None:
                if currentprice != previousprice:
                    print(f"ATTENTION! Price changed from {previousprice:.2f} to {currentprice:.2f}")
                    previousprice = currentprice
                else:
                    print(f"The price remained unchanged at {currentprice:.2f}")
            else:
                print("Unable to read current price.")
