import requests
from tqdm import tqdm

state_list = ['alabama', 'alaska', 'arizona', 'arkansas', 'california', 'colorado', 'connecticut', 'delaware', 'florida', 'georgia', 'hawaii', 'idaho', 'illinois', 'indiana', 'iowa', 'kansas', 'kentucky', 'louisiana', 'maine', 'maryland', 'massachusetts', 'michigan', 'minnesota', 'mississippi', 'missouri', 'montana', 'nebraska', 'nevada', 'new-hampshire', 'new-jersey', 'new-mexico', 'new-york', 'north-carolina', 'north-dakota', 'ohio', 'oklahoma', 'oregon', 'pennsylvania', 'rhode-island', 'south-carolina', 'south-dakota', 'tennessee', 'texas', 'utah', 'vermont', 'virginia', 'washington', 'west-virginia', 'wisconsin','wyoming']
csv_content="state,timestamp,votes,eevp,trumpd,bidenj\r\n"

for j in tqdm(range(len(state_list))):
    r = requests.get(f'https://static01.nyt.com/elections-assets/2020/data/api/2020-11-03/race-page/{state_list[j]}/president.json')
    results = r.json()
    xts = results['data']['races'][0]['timeseries']
    for i in tqdm(range(len(xts))):
        csv_content=csv_content+f'{state_list[j]},{xts[i]["timestamp"]},{xts[i]["votes"]},{xts[i]["eevp"]},{xts[i]["vote_shares"]["trumpd"]},{xts[i]["vote_shares"]["bidenj"]}\r\n'    

with open('result.csv', 'w', newline='') as f:
    f.write(csv_content)
