//  topic = STORAGE DESIGN PATTERNS  -->  video = SIMPLE ARRAY MAPING  //

pragma solidity 0.8.0;

    // A simple mapping to ilistrate the differences between mapping and array storage structures
    // main difference is that you can iterate through an array and run analytics on it like how many entities there are or what their values are in an array but it is very expensive in terms of gas and slow to iterate/loop through
    // mappings however have no way of iterating through or looking up information saved there without the key it is attached to like an address or uint tied to balances but the look ups are fast and cheap in gas

contract mappingWithStruct {

    // Struct to hold some entity, with uint and boolian variable for each entity. 
    // Boolian is to help us idenntify which structs are not empty since all mappings technicaly hold data its just all zeros until told otherwise. So without the boolian it would look like all addresses had structs with values.
  struct EntityStruct {
    uint entityData;
    bool isEntity;
  }

    // Mapping an address to each entity struct 
  mapping (address => EntityStruct) public entityStructs;

    // Set mapping from entity address to struct that holds the entity data and isEntity bool. 
    // Unlike array, this does not hold address in struct, instead the address is set as a pointer that tells us where to get the struct.
  function newEntity(address entityAddress, uint entityData) public returns(bool success) {
    if(isEntity(entityAddress)) revert(); 
    entityStructs[entityAddress].entityData = entityData;
    entityStructs[entityAddress].isEntity = true;
    return true;
  }
  
    // Checks if a mapping holds an actual value or if it was just set to 0 upon creation of the mapping. 
  function isEntity(address entityAddress) public view returns(bool isIndeed) {
    return entityStructs[entityAddress].isEntity;
  }

    // This deletes entities by changing our boolian to false which tells us there are no usable values in that mapping anymore
  function deleteEntity(address entityAddress) public returns(bool success) {
    if(!isEntity(entityAddress)) revert();
    entityStructs[entityAddress].isEntity = false;
        //This would also work by setting the values in the mapping back to their original state of entityData = 0 and isEntity = false
    //delete entityStructs[entityAddress];
    return true;
    
  }

    // Allows us to change data stored in the struct attached to the entity through mapping
  function updateEntity(address entityAddress, uint entityData) public returns(bool success) {
    if(!isEntity(entityAddress)) revert();
    entityStructs[entityAddress].entityData = entityData;
    return true;
  }

}

// Mapping Drawbacks: dont know how many entities are in mapping, cannot easily run analitics on stored data, cannot loop through, no .length command, values are not inumerated, all mappings have a value even if you did not set it so must be careful not to mistake empty mappings for ones that hold real values

// Mapping Benifits: fast, cheap, scales very well, does not take duplicate data; just overwrites previous values, 
