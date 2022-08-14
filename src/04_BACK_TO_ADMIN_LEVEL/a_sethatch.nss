// Decompiled using ncsdecomp
void main();

void _start() {
	main();
	return;
}

void main() {
	SetGlobalNumber("101PER_Open_Hatch", 1);

  // Give back our previous inventory that we stored inside the admin console
  object exileStorage = GetObjectByTag("Adm_Console");
  object player = GetPartyMemberByIndex(0);
  object nextItem = GetFirstItemInInventory(exileStorage);
  while( nextItem != OBJECT_INVALID ){
    GiveItem(nextItem, player);
    nextItem = GetFirstItemInInventory(exileStorage);
  }

  // Get the lost XP of T3:
  int gainedXp = ( GetGlobalNumber("001EBO_End") + 128 ) * 10;
  SetXP(GetFirstPC(), GetXP(GetFirstPC()) + gainedXp);

  // its definitive value!
  SetGlobalNumber("001EBO_End", 1);

}
