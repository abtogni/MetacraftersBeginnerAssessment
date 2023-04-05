pragma solidity ^0.8.0;

contract GateEntryPass {
    address public owner;
    mapping (address => bool) public authorized;
    
    event Authorized(address account);
    event Revoked(address account);
    
    constructor() {
        owner = msg.sender;
    }
    
    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can perform this action");
        _;
    }
    
    function authorize(address account) public onlyOwner {
        require(!authorized[account], "Account is already authorized");
        authorized[account] = true;
        emit Authorized(account);
    }
    
    function revoke(address account) public onlyOwner {
        require(authorized[account], "Account is not authorized");
        authorized[account] = false;
        emit Revoked(account);
    }
    
    function enter() public {
        bool hasPass = authorized[msg.sender];
        assert(hasPass == true);
        require(hasPass, "You need an authorized pass to enter");
    }
    
}
