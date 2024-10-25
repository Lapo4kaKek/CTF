### Здесь вся идея в том, что генерация рандомного числа вовсе не рандомна. Тут всего лишь операции деления, умножения и получение блока. Такое мы можем проделать заранее и отправить подходящее число. 

```Solidity
function rand(uint256 max) internal view returns (uint256 result) {
        uint256 factor = (FACTOR * 100) / max;
        uint256 lastBlockNumber = block.number - 1;
        uint256 hashVal = uint256(blockhash(lastBlockNumber));

        return uint256((uint256(hashVal) / factor)) % max;
    }
```