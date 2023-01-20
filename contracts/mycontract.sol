// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.17;

struct Instructor{
    uint age;
    string name;
    address addr;
}

contract School{
    Instructor public schoolInstructor;
    State public schoolState = State.Open;

    mapping(address => uint) public bids;

    enum State {Open, Closed, Unknown}

    constructor(uint _age, string memory _name){
        schoolInstructor.age = _age;
        schoolInstructor.name = _name;
        schoolInstructor.addr = msg.sender;
    }

    function bid() payable public{
        bids[msg.sender] = msg.value;
    }

    function changeInstructor(uint _age, string memory _name, address _addr) public {

        if(schoolState == State.Open){
            Instructor memory myInstructor = Instructor({
                age: _age,
                name: _name,
                addr: _addr
            });

            schoolInstructor = myInstructor;
        }

    }
}

contract Property{
    int public value;
    string public location = "London";
    address immutable public owner; 

    uint[] public numbers = [2, 3, 4];

    constructor(int _value, string memory _location){
        value = _value;
        location = _location;
        owner = msg.sender;
    }

    function setElement(uint index, uint _value) public{
        numbers[index] = _value;
        numbers.push(index * _value);
    }

    function getElement(uint index) public view returns(uint) {
        if(index < numbers.length){
            return numbers[index];
        }

        return 0;
    }

    function setValue(int _value) public{
        value = _value;
    }

    function getValue() public view returns(int){
        return value;
    }

    function setLocation(string memory _location) public{
        location = _location;
    }
}