// Kotor2 NCS script

// This script while the wake up animation is playing
// Here we want to put all our inventory item into an invisible placeholder

void main();

void _start() {
  main();
  return;
}

void main() {

  // using the Medical Computer inventory as a temporary storage for the prologue inventory:
  object invisibileStorage = GetObjectByTag( "MedCom" );

  // loop over all the player inventory items and place them in the MedCom inventory
  object nextItem = GetFirstItemInInventory( GetFirstPC() );
  while( nextItem != OBJECT_INVALID ){
    GiveItem( nextItem, invisibileStorage );
    nextItem = GetFirstItemInInventory( GetFirstPC() );
  }

}
