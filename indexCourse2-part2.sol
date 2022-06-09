import "./zombiefactory.sol";

/**
    defining an interface is like definine a contract, but:
    1. we're only declaring the functions we want to interact with
    2. we're not defining the function bodies.
        Instead of curly braces ({ and }), we're simply ending the function
        declaration with a semi-colon (;).
 */
contract KittyInterface {
    function getKitty(uint256 _id)
        external
        view
        returns (
            bool isGestating,
            bool isReady,
            uint256 cooldownIndex,
            uint256 nextActionAt,
            uint256 siringWithId,
            uint256 birthTime,
            uint256 matronId,
            uint256 sireId,
            uint256 generation,
            uint256 genes
        );
}

/**
    Types for visibility functions
    public, private, internal and external.
 */

// inheritance
contract ZombieFeeding is ZombieFactory {
    address ckAddress = 0x06012c8cf97BEaD5deAe237070F9587f8E7A266d;
    KittyInterface kittyContract = KittyInterface(ckAddress);

    function feedAndMultiply(
        uint256 _zombieId,
        uint256 _targetDna,
        string memory _species
    ) public {
        require(msg.sender == zombieToOwner[_zombieId]);
        Zombie storage myZombie = zombies[_zombieId];
        _targetDna = _targetDna % dnaModulus;
        uint256 newDna = (myZombie.dna + _targetDna) / 2;
        if (
            keccak256(abi.encodePacked(_species)) ==
            keccak256(abi.encodePacked("kitty"))
        ) {
            newDna = newDna - (newDna % 100) + 99;
        }
        _createZombie("NoName", newDna);
    }

    function feedOnKitty(uint256 _zombieId, uint256 _kittyId) public {
        uint256 kittyDna;
        (, , , , , , , , , kittyDna) = kittyContract.getKitty(_kittyId);
        feedAndMultiply(_zombieId, kittyDna, "kitty");
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

contract MyContract {
    // ^ The address of the FavoriteNumber contract on Ethereum
    address NumberInterfaceAddress = 0xab38;
    // Now `numberContract` is pointing to the other contract
    NumberInterface numberContract = NumberInterface(NumberInterfaceAddress);

    // contract address
    address ckAddress = 0x06012c8cf97BEaD5deAe237070F9587f8E7A266d;
    // create a KittyInterface interface based on the contract with certain address
    // it's initalized with the contract and address
    KittyInterface kittyContract = KittyInterface(ckAddress);
}
