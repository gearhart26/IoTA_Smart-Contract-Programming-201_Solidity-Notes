//  topic = STORAGE DESIGN PATTERNS  -->  video = SIMPLE ARRAY MAPING  //

pragma solidity 0.8.0;

    // A simple mapping to ilistrate the differences between mapping and array storage structures
    // main difference is that you can iterate through an array and run analytics on it like how many entities there are or what their values are in an array but it is very expensive in terms of gas and slow to iterate/loop through
    // mappings however have no way of iterating through or looking up information saved there without the key it is attached to like an address or uint tied to balances but the look ups are fast and cheap in gas
