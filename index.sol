pragma solidity >=0.5.0 <0.6.0;

contract ZombieFactory {
    uint256 dnaDigits = 16;
    uint256 dnaModulus = 10**dnaDigits;

    // class is like struct
    struct Zombie {
        // types are before the variable name
        string name;
        uint256 dna;
    }

    // don't need to initialize elements, they seem to be initialized with just the type
    Zombie[] public zombies;

    // memory is a copmile space, it's dynamic and it's cleared once the contract run finishes
    // https://stackoverflow.com/a/33839164/7044942
    function createZombie(string memory _name, uint256 _dna) public {
        /**
          1. to create structs it doesn't need to word new 
          2. structs creation doesn't need the structs definitions to have a constructor, 
              it saves the params in the order they are provided as the properties 
              in the order they are been written      
       */
        zombies.push(Zombie(_name, _dna));
    }

    // underscore(_) go before the name as a convention for private vars/functions and functions paramters
    function _createZombie(string memory _name, uint256 _dna) private {
        zombies.push(Zombie(_name, _dna));
    }
}
