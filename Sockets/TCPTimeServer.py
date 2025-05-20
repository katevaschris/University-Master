import socket
import threading
from datetime import datetime

def handle_client(connection, address):
    print(f"[+] Σύνδεση από {address}")
    try:
        request = connection.recv(1024).decode().strip().lower()
        now = datetime.now()

        response_map = {
            "date": now.strftime("%Y-%m-%d"),
            "day": now.strftime("%A"),
            "month": now.strftime("%B"),
            "year": str(now.year),
            "hour": now.strftime("%H:%M:%S"),
        }

        response = response_map.get(request, "Μη έγκυρη παράμετρος")
        connection.sendall(response.encode())
    except Exception as e:
        print(f"[!] Σφάλμα με {address}: {e}")
    finally:
        connection.close()
        print(f"[-] Αποσύνδεση από {address}")

# Ο server ακούει σε όλες τις διευθύνσεις
def start_server(host='0.0.0.0', port=5000):
    server = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    server.bind((host, port))
    server.listen()
    print(f"Server ακούει στη θύρα {port}...")

    while True:
        conn, addr = server.accept()
        thread = threading.Thread(target=handle_client, args=(conn, addr))
        thread.start()

if __name__ == "__main__":
    start_server()

