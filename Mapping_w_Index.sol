// topic = STORAGE DESIGN PATTERNS  -->  video = UPGRADED SOLUTION //

pragma solidity 0.8.0;

    //First attempt at a combination of an array and a mapping to try and have one compensate for the weakneses of the other. 
    //Not the best solution but it gets us close to the functionality that we are looking for.
contract MappedStructsWithIndex {

    //Same struct with isEntity bool to help us identify which mappings are actually in use and not just set to 0 by defalt. 
  struct EntityStruct {
    uint entityData;
    bool isEntity;
  }

    //Adding an address array to save a list of all of the keys in our mapping. This allows us to keep track of users or addresses that have actual data.
    //This also allows us to iterate through the list of adddresses so we can loop through and modify the data. 
    //Which was the largest drawback to the previous simple mapping but through a combination of a mapping and an array we get the benifits of both with fewer drawbacks
  mapping(address => EntityStruct) public entityStructs;
    //However, since this is an array a drawback is that we cannot delete or remove data. We can still set isEntity to false but thats no better than our simple example.
    //This array will also contine to grow indefinatly and slow down linerarly with size.
  address[] public entityList;
  
    //unchanged
  function newEntity(address entityAddress, uint entityData) public returns(uint rowNumber) {
    if(isEntity(entityAddress)) revert();
    entityStructs[entityAddress].entityData = entityData;
    entityStructs[entityAddress].isEntity = true;
    return entityList.push(entityAddress) - 1;
  }

    //unchanged
  function updateEntity(address entityAddress, uint entityData) public returns(bool success) {
    if(!isEntity(entityAddress)) revert();
    entityStructs[entityAddress].entityData = entityData;
    return true;
  }

    //unchanged
  function isEntity(address entityAddress) public view returns(bool isIndeed) {
      return entityStructs[entityAddress].isEntity;
  }

    //unchanged
  function getEntityCount() public view returns(uint entityCount) {
    return entityList.length;
  }

    
}
