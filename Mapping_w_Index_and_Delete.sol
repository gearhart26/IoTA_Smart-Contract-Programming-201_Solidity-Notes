// topic = STORAGE DESIGN PATTERNS  -->  video = FINAL SOLUTION //

//This is the best solution to the storage structure drawbacks for now. 
//This is the storage structure that is commonly used in current smart contracts.

pragma solidity 0.8.0;

    //This storage structure takes the advantages of both mappings and arrays and uses them in such a way as to diminish the drawbacks of each as much as possible. 
contract mappedWithUnorderedIndexAndDelete {

    //Struct with entity data like before and new variable listPointer
    //listPointer is a uint that points from the struct mapping to that index of that address in the array
    //This better connects the addresses in the array to the variables in the mapping
    //Also allows us to delete and reshuffle objects in the array.
  struct EntityStruct {
    uint entityData;
    //can add in here whatever other data we need.
    uint listPointer;   //for example: the first struct added to the mapping would have a list pointer value of 0 which corresponds to the first position in the entityList array.
  }

    //Same mapping as previous mapping_w_index example.
  mapping(address => EntityStruct) public entityStructs;
    //Array with mapping keys like previous mapping_w_index example. Allows us to iterate through all address and keep track of active addresses
  address[] public entityList;

    //
  function isEntity(address entityAddress) public view returns(bool isIndeed) {
    if(entityList.length == 0) return false;
    return (entityList[entityStructs[entityAddress].listPointer] == entityAddress);
  }

    //check number of entities 
  function getEntityCount() public view returns(uint entityCount) {
    return entityList.length;
  }

    //adding a new entity to our mapping/array 
  function newEntity(address entityAddress, uint entityData) public returns(bool success) {
    if(isEntity(entityAddress)) revert();                               //checks if entity already exists to prevent doublicates and overwriting
    entityStructs[entityAddress].entityData = entityData;               //sets the data in our struct
    entityList.push(entityAddress);                                     //push address into our array entityList
    entityStructs[entityAddress].listPointer = entityList.length - 1;   //setting the pointer in the struct to the index of that same address in our array entityList after its been added
    return true;                                                        //return true to indicate sucessful addition of a new entity
  }

    //Updating entitiy data in our struct
  function updateEntity(address entityAddress, uint entityData) public returns(bool success) {
    if(!isEntity(entityAddress)) revert();                      //make sure entity exists first
    entityStructs[entityAddress].entityData = entityData;       //change entity data in struct
    return true;                                                //true to indicate successful change
  }
  
   
    //New delete function that allwows us  to delete entitys from storage and our array.
    //Normally cannot delete objects that are not at the end or begining of an array but this function switches the places of the selected object and the object at the end of the array
    //This allows the selected object to be easially deleted and the object that was at the end takes the deleted abjects old place in the array
    
    //This totally makes up for the last drawback of our previous mapping_w_index example.
    //By deleting entities no longer in use we can keep the array as small as possible therby speeding up all of our operations that require looping through the array.
    //Adds a bit of complexity but it's worth it for the storage structure benifits
  function deleteEntity(address entityAddress) public returns(bool success) {
    if(!isEntity(entityAddress)) revert();                              //make sure entity exists
    uint rowToDelete = entityStructs[entityAddress].listPointer;        //find the row in the array to delete by looking up address in mapping, get value, use listPointer to find address location in array
    address keyToMove   = entityList[entityList.length-1];              //then save keyToMove which basiclly "cuts" the address at the end of the list 
    entityList[rowToDelete] = keyToMove;                                //then "pastes" the address from the end of the array over the spot of the address we want to delete
    entityStructs[keyToMove].listPointer = rowToDelete;                 //then update the mapping so the struct, for the address that was originally at the end of the array, gets updated with the new listPointer value so it can be found in its new spot
    entityList.pop();                                                   //remove the now duplicate element at the end of the array
    delete entityStructs[entityAddress];                                //delete the mapping which just reverts all the variables in the struct to their initial state of 0
    return true;                                                        //return true for succesful deletion
  }

}
