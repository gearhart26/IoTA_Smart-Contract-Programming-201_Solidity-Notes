// topic = Security Considerations --> video = RE-ENTRENCY //

// Checks --> Effects (changing state) --> Interatctions
    //this pattern always needs to be followed to prevent re-entrency attacks 
    
//.call used in test_3 contract is currently the best way to send ETH but it has to be used in conjunction with the checks, effects, iinteractions security pattern

pragma solidity 0.8.0;
