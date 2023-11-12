import json
from web3 import Web3
import time

#адрес контракта
smart_contract_address = '0xE3B85E459ed896A123b7733C786Fb44B431Bfac1'

abi_data = json.load(open('ABI.json'))
meta_url = 'https://rpc2.sepolia.org'
w3 = Web3(Web3.HTTPProvider(meta_url))

#контракт
contract = w3.eth.contract(address=smart_contract_address, abi=abi_data)
functions = contract.functions

#вызов функции totalSupply
get_supply = functions.totalSupply().call(block_identifier='latest')

#вывод результата функции totalSupply
print(get_supply)

#получение логов по событиям EventEndGame(окончание игры камень-ножницы-бумага)
logs = contract.events.EventEndGame().get_logs(fromBlock=4680114)

#вывод логов
for log in logs:
    print('first player: {0}'.format(log.args.first_player))
    print('second player: {0}'.format(log.args.second_player))

#подписка на событие EventEndGame
def log_loop(event_filter, poll_interval):
    while True:
        for event in event_filter.get_new_entries():
            print(Web3.to_json(event))
        time.sleep(poll_interval)

event_filter = contract.events.EventEndGame().create_filter(fromBlock="latest")
log_loop(event_filter, 2)