import requests
import sys


def test_gtg(address: str):
    result = requests.get(
        f'{address}/gtg'
    )
    if result.status_code == 200:
        print(u'\033[90m\N{check mark}\033[0m good to go passed')
    else:
        print(u'\033[91m\N{ballot x}\033[0m good to go failed')

def test_add_candidate(address: str):
    result = requests.post(
        f'{address}/candidate/John Smith',
        data=b'test'
    )
    if result.status_code == 200:
        print(u'\033[90m\N{check mark}\033[0m insert passed')
    else:
        print(u'\033[91m\N{ballot x}\033[0m insert failed:', result.json()['error'])

def test_verify_candidate(address: str):
    result = requests.get(
        f'{address}/candidate/John Smith'
    )
    if result.status_code == 200:
        print(u'\033[90m\N{check mark}\033[0m verification passed')
    else:
        print(u'\033[91m\N{ballot x}\033[0m verification failed:', result.json()['error'])

def test_get_candidates(address: str):
    result = requests.get(
        f'{address}/candidates'
    )

    if result.status_code == 200:
        print(u'\033[90m\N{check mark}\033[0m candidate list passed')
    else:
        print(u'\033[91m\N{ballot x}\033[0m candidate list failed:', result.json()['error'])


if len(sys.argv) != 2:
    print("python test_candidates.py http://localhost:8000")
    exit(-1)

app_address = sys.argv[1]
test_gtg(app_address)
test_add_candidate(app_address)
test_verify_candidate(app_address)
test_get_candidates(app_address)