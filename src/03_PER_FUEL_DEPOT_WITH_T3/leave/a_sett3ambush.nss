// Decompiled using ncsdecomp
void main();

void _start() {
	main();
	return;
}

void main() {

  // The original script does:
	SetGlobalNumber("103PER_T3_Ambush", 1);

  // Save lost XP obtained by T3 here

  // begining XP was saved with "a_transformt3m4.nss"
  int beginXp = ( GetGlobalNumber("001EBO_End") + 128 ) * 10;

  // Global numbers appears to be saved as a "signed char" (8bits) which means it can go within -128 and +127
  // We compress the XP value by adding a divider:
  int divider = 10;
  int gainedXp = -128 + (GetXP(GetFirstPC()) - beginXp)/divider;

  // cap if the starting XP is lower than beginXp and no xp is gained
  if( gainedXp < -128 ){
    gainedXp = -128;
  }

  // cap if we got more than the max allowed by "signed char"
  if( gainedXp > 127 ){
    gainedXp = 127;
  }

  // store the value
  SetGlobalNumber("001EBO_End", gainedXp);


  // store inside "Fuel Control Station", aka this console
  object t3Storage = GetObjectByTag("ComputerPanel");
  object player = GetPartyMemberByIndex(0);
  object nextItem = GetFirstItemInInventory(player);
  while( nextItem != OBJECT_INVALID ){
    GiveItem(nextItem, t3Storage);
    nextItem = GetFirstItemInInventory(player);
    // DEBUG If the item is still in the inventory, use GetNextItemInInventory();
  }

  // Will get back this inventory when grouping back with T3
}
