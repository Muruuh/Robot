from cryptography.fernet import Fernet

def decrypt(encrypted_data, key):
    fernet = Fernet(key)
    decrypted = fernet.decrypt(encrypted_data.encode()).decode()
    return decrypted

key = "hXrbBZUY0ryENzTC8PIgoZOQDYGHcG8MfT5Ih6B63mA="
encrypted_username = "gAAAAABnqbOx7kDPJhR8BEMAN5tGsYiOhLYROLzy-ctR9vv-qmPMyIwTCdMAm1wP0DyQHFl5xYudDLMi4WuQpjORpE5ergFA3w=="
encrypted_password = "gAAAAABnqbOxGNutydEs9V7Hlc6F-i-WF8DBKt3S4uoUWAnHUe7WCYWYLecA6Q99s6Ltx3g54olHj1u_HHWqr61rMXoYnvynlA=="

username = decrypt(encrypted_username, key)
password = decrypt(encrypted_password, key)

print(f"Decrypted Username: {username}")
print(f"Decrypted Password: {password}")
