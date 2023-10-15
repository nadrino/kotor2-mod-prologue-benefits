// Decompiled using ncsdecomp

// This script is executed right before loading the hangar area of Peragus (cf. last line).
// The game is switching playable character at this moment to T3-M4.

// T3-M4 is not supposed have access to the inventory of the Exile.
// The inventory is first moved to a temporary inventory: Adm_Console

// Then we want to grab back all the inventory items temporarly stored in the MedCom
// and get back the XP we stored into the global var 001EBO_End at the end of the prologue



void main();

void _start() {
  main();
  return;
}

void main() {

  // Add T3-M4 to the party
  if (GetIsObjectValid(GetObjectByTag("t3m4", 0))) {
    AurPostString("t3m4 should now be in the party!", 5, 15, 10.);
    AddAvailableNPCByObject(NPC_T3_M4, GetObjectByTag("t3m4", 0));
  }

  //SetGlobalFadeOut(0., 0.75, 0., 0., 0.);

  SetGlobalBoolean("PER_TURNINTO_T3M4", 1);

  // Move the exile inventory to the invisible admin console inventory
  object exileStorage = GetObjectByTag("Adm_Console");
  object player = GetFirstPC();
  object nextItem = GetFirstItemInInventory(player);
  while( nextItem != OBJECT_INVALID ){
    GiveItem(nextItem, exileStorage);
    nextItem = GetFirstItemInInventory(player);
    // DEBUG If the item is still in the inventory, use GetNextItemInInventory();
  }

  // Grab back the inventory of the Medical computer
  object t3Storage = GetObjectByTag("MedCom");
  nextItem = GetFirstItemInInventory(t3Storage);
  while( nextItem != OBJECT_INVALID ){
    GiveItem(nextItem, player);
    nextItem = GetFirstItemInInventory(t3Storage);
  }

  // Give back the XP from the prologue
  int prologueXP = 5 * ( GetGlobalNumber("001EBO_End") + 128 );
  SetXP(GetFirstPC(), GetXP(GetFirstPC()) + prologueXP);
  // GiveXPToCreature(GetFirstPC(), prologueXP);

  // Not working for T3
  // SetXP(GetPartyMemberByIndex(1), GetXP(GetPartyMemberByIndex(1)) + prologueXP);


  // Finally move to the hangar bay
  SetGlobalNumber("001EBO_End", 1);

  ApplyEffectToObject(1, EffectCutSceneParalyze(), player, 4.000000);

  StartNewModule("106PER", "", "", "", "", "", "", "");

  return;
}
