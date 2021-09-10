// topic = Security Considerations --> video = RE-ENTRENCY //

// Checks --> Effects (changing state) --> Interactions
    //this pattern always needs to be followed to prevent re-entrency attacks 
    
//.call used in test_3 contract is currently the best way to send ETH but it has to be used in conjunction with the checks, effects, iinteractions security pattern

pragma solidity 0.8.0;


//unsafe vulnerable version
contract test_1 {
    
    mapping(address => uint) balance;
    
        //vulnerable because pattern was not followed
    function withdraw() public {
        require(balance[msg.sender] > 0);       //checks
        msg.sender.send(balance[msg.sender]);   //interactions
        balance[msg.sender] = 0;                //effects
    }
    
}



//next version with improvments but .send and . transfer should not be used anymore because of the gas stipend attached
contract test_2 {
    
    mapping(address => uint) balance;
    
        //better because pattern is being followed
    function withdraw() public {
        require(balance[msg.sender] > 0);       //checks
        balance[msg.sender] = 0;                //effects
        msg.sender.send(balance[msg.sender]);   //interactions
    }
    
}



//next version with further improvments and .call instead of .send since this implimentation of .call is currently the best way to send ETH
contract test_3 {
    
    mapping(address => uint) balance;
    
        //better because pattern is being followed and reverts state if transaction fails
    function withdraw() public {
        require(balance[msg.sender] > 0);       //checks
        uint toTransfer = balance[msg.sender];
        balance[msg.sender] = 0;                //effects
        (bool success,) = msg.sender.call{value: toTransfer}("");   //interactions
            if(!success){
                balance[msg.sender] = toTransfer;
            }
    }
    
}
