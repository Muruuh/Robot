import json
from cryptography.fernet import Fernet

key = Fernet.generate_key()
cipher_suite = Fernet(key)

username = "MUNKHMURUN"
password = "Muruu0729!"

encrypted_username = cipher_suite.encrypt(username.encode()).decode()
encrypted_password = cipher_suite.encrypt(password.encode()).decode()

data = {
    "encrypted_username": encrypted_username,
    "encrypted_password": encrypted_password,
    "key": key.decode()  
}

with open('encrypted_credentials.json', 'w') as f:
    json.dump(data, f)

print("Successs xoxo")
