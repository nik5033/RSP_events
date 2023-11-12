В данной лабораторной был создан смарт-контракт, реализующий игру камень-ножницы-бумага(из предыдущей ЛР), но также в него было добавлено EventEndGame вызывающееся при окончании игры(выплате вознаграждения).

1. Вызывается функция totalSupply для контракта с адресом 0xE3B85E459ed896A123b7733C786Fb44B431Bfac1
2. Получение события EventEndGame
   ```bash
   first player: 0x033bBbE82731cadb5ac26fF31a81624d718D4f3f
   second player: 0x033bBbE82731cadb5ac26fF31a81624d718D4f3f
3. Подписка на событие EventEndGame реализуется при помощи цикла и фильтра на последний блок.
4. При работе скрипат была сыграна игра, и был получен только что случившийся event:
   ```bash
   {"args": {"first_player": "0x033bBbE82731cadb5ac26fF31a81624d718D4f3f", "second_player": "0x033bBbE82731cadb5ac26fF31a81624d718D4f3f"}, "event": "EventEndGame", "logIndex": 7, "transactionIndex": 14, "transactionHash": "0x1591e6a1dc9049644dcc2e0593a8ac4e98625d5cea76f7e0fac56df826ade7ad", "address": "0xE3B85E459ed896A123b7733C786Fb44B431Bfac1", "blockHash": "0x438d2b7210decc90b9cde7e904be07a8370b59c264310e06888ffa5c7eef3bdb", "blockNumber": 4680359}
