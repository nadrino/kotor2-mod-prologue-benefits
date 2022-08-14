// Decompiled using ncsdecomp
void main();

void _start() {
	main();
	return;
}

void main() {

	if (GetIsObjectValid(GetObjectByTag("t3m4", 0))) {
		AurPostString("t3m4 should now be in the party!", 5, 15, 10.);
    AddAvailableNPCByObject(NPC_T3_M4, GetObjectByTag("t3m4", 0));
	}

	//SetGlobalFadeOut(0., 0.75, 0., 0., 0.);

  SetGlobalBoolean("PER_TURNINTO_T3M4", 1);

  object exileStorage = GetObjectByTag("Adm_Console");
  object player = GetFirstPC();
  object nextItem = GetFirstItemInInventory(player);
  while( nextItem != OBJECT_INVALID ){
    GiveItem(nextItem, exileStorage);
    nextItem = GetFirstItemInInventory(player);
    // DEBUG If the item is still in the inventory, use GetNextItemInInventory();
  }

  object t3Storage = GetObjectByTag("MedCom");
  nextItem = GetFirstItemInInventory(t3Storage);
  while( nextItem != OBJECT_INVALID ){
    GiveItem(nextItem, player);
    nextItem = GetFirstItemInInventory(t3Storage);
  }

  int prologueXP = 5 * ( GetGlobalNumber("001EBO_End") + 128 );
  SetXP(GetFirstPC(), GetXP(GetFirstPC()) + prologueXP);
  // GiveXPToCreature(GetFirstPC(), prologueXP);

  // Not working for T3
  // SetXP(GetPartyMemberByIndex(1), GetXP(GetPartyMemberByIndex(1)) + prologueXP);

  SetGlobalNumber("001EBO_End", 1);

	ApplyEffectToObject(1, EffectCutSceneParalyze(), player, 4.000000);

  StartNewModule("106PER", "", "", "", "", "", "", "");

  return;
}
