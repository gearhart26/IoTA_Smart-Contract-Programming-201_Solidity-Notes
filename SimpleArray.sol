//  topic = STORAGE DESIGN PATTERNS  -->  video = SIMPLE ARRAY MAPING  //

pragma solidity 0.8.0;

    // A simple array to ilistrate the differences between mapping and array storage structures
    // main difference is that you can iterate through an array and run analytics on it like how many entities there are or what their values are in an array but it is very expensive in terms of gas and slow to iterate/loop through
    // mappings however have no way of iterating through or looking up information saved there without the key it is attached to like an address or uint tied to balances but the look ups are fast and cheap in gas
contract simpleList {

    // Struct to hold some entity, with an address and uint variable for each entity
  struct EntityStruct {
    address entityAddress;
    uint entityData;
  }

    // array to hold structs
  EntityStruct[] public entityStructs;

    // Creates a new entity, saves the address, and sets the data. Then push into array and return ID.
  function newEntity(address entityAddress, uint entityData) public returns(EntityStruct memory) {
    EntityStruct memory newEntity;
    newEntity.entityAddress = entityAddress;
    newEntity.entityData    = entityData;
    entityStructs.push(newEntity);
    return entityStructs[entityStructs.length - 1];
        // another way of doing the same thing
    //return entityStructs.push(newEntity)-1;
  }

    // function to return how many entities are in our array 
  function getEntityCount() public view returns(uint entityCount) {
    return entityStructs.length;
  }
}

// Array Drawbacks: slow, expensive, very complicated to delete values, takes duplicate data, does not scale well, slows down more and more as entities are added, increased function complexity

// Array Benifits: can iterate through, can look up number of entries, simple, everything saved in cronological order, can access entities by ID, can run analitics on all entities saved in array


// Extra Note: 
// Arrays do not have an initial state like mappings do. This makes deleting or removing data very complicated because you cannot delete a value in the middle of an array without replacing it. 
// You can only delete the first or last values in an array and there is no intial state to revert it to so you can only really add a isDeleted boolian value for the struct like we use the isEntity boolian in simple mapping.
// However, this does not work as well with arrays since arrays slow down with each new value saved. This means you do not want to have anything saved there that is not absolutly necessary
