 //SPDX-License-Identifier: GPL-3.0
 
pragma solidity >=0.5.0 <0.9.0;

contract Lottery{
    address immutable public owner;
    uint immutable private ONE_ETH = 1000000000000000000;
    mapping(address => uint) private bids;
    address payable[] public playersPool;
    uint private differentPlayersCount;

  
    constructor(){
        owner = msg.sender;
    }
    
    receive() external payable{
        require(msg.value == ONE_ETH/10);

        if(bids[msg.sender] == 0){
            bids[msg.sender]++;
            differentPlayersCount++;
        }

        playersPool.push(payable(msg.sender));
    }
    
    function getBalance() public view returns(uint){
        require(msg.sender == owner);
        return address(this).balance;
    }

    function random() internal view returns(uint){
        return uint(keccak256(abi.encodePacked(block.difficulty, block.timestamp, playersPool.length)));
    }
    
    function pickWinner() external payable {

        require(msg.sender == owner);
        require(differentPlayersCount >= 3, "There are not enough players");

        uint r = random();
        uint winnerIndex = r % playersPool.length;

        address payable winner = playersPool[winnerIndex];
        winner.transfer(getBalance());

        playersPool = new address payable[](0);

    }
}