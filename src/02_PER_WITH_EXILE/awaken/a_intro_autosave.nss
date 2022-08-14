// Kotor2 NCS script

void main();

void _start() {
	main();
	return;
}

void main() {

  object nextItem = GetFirstItemInInventory(GetFirstPC());
  object invisibileStorage = GetObjectByTag("MedCom");
  while( nextItem != OBJECT_INVALID ){
    GiveItem(nextItem, invisibileStorage);
    nextItem = GetFirstItemInInventory(GetFirstPC());
  }

}
