### Здесь ситуация похожа на азино777, но добавляется еще seed, который тоже не рандомный и заранее можно узнать.
```
function spin(uint256 bet) public payable {
        require(msg.value >= 0.01 ether);
        uint256 num = rand(100);
        seed = rand(256);
        if (num == bet) {
            payable(msg.sender).transfer(address(this).balance);
        }
    }

    function rand(uint256 max) internal view returns (uint256 result) {
        uint256 factor = (FACTOR * 100) / max;
        uint256 blockNumber = block.number - seed;
        uint256 hashVal = uint256(blockhash(blockNumber));

        return uint256((uint256(hashVal) / factor)) % max;
    }
```

### rand(uint256) считает также, нам нужно лишь прочитать заранее из ячейки seed, например так
```
uint256 seed = uint256(vm.load(address(instance), 0));

```