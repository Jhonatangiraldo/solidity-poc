import "./zombiefactory.sol";

// inheritance
contract ZombieFeeding is ZombieFactory {
    function feedAndMultiply(uint256 _zombieId, uint256 _targetDna) public {
        // checking zombie  is owned by the sender
        require(msg.sender == zombieToOwner[_zombieId]);
        Zombie storage myZombie = zombies[_zombieId];
        // making it to 16 digits(not sure here yet how)
        _targetDna = _targetDna % dnaModulus;
        // average between these two
        uint256 newDna = (myZombie.dna + _targetDna) / 2;
        _createZombie("NoName", newDna);
    }
}

/**
    Storage refers to variables stored permanently on the blockchain.
    Memory variables are temporary, and are erased between
    external function calls to your contract. 
    Think of it like your computer's hard disk vs RAM.
 */

/**
    Most of the time you don't need to use these keywords
    because Solidity handles them by default.
    State variables (variables declared outside of functions) are
    by default storage and written permanently to the blockchain,
    while variables declared inside functions are memory
    and will disappear when the function call ends.
 */
