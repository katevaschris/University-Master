import socket
import sys

if len(sys.argv) != 2:
    print("Χρήση: python TCPTimeClient.py <ip_server>")
    sys.exit(1)

server_ip = sys.argv[1]
server_port = 5000

while True:
    try:
        client_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        client_socket.settimeout(5)  # timeout για να μην κολλάει
        client_socket.connect((server_ip, server_port))
    except (ConnectionRefusedError, socket.timeout, OSError):
        print(f"Ο server δεν βρέθηκε στη διεύθυνση {server_ip}.")
        sys.exit(1)

    parameter = input("\nΖήτησε μία από τις παρακάτω τιμές (Date, Day, Month, Year, Hour): ").strip()
    
    if parameter.lower() == "exit":
        print("Έξοδος από τον client.")
        client_socket.close()
        break

    client_socket.send(parameter.encode())
    response = client_socket.recv(1024).decode()
    print(f"Απάντηση από τον server: {response}")
    client_socket.close()

