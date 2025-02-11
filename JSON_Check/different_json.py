import json
from deepdiff import DeepDiff

# 1:2 
with open("MY_apnConfiguration.json", "r") as f1, open("Ericsson_apnConfiguration.json", "r") as f2:
    json1 = json.load(f1)
    json2 = json.load(f2)

diff = DeepDiff(json1, json2, ignore_order=True)  
print(diff)