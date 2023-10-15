// Decompiled using ncsdecomp

// This script execute after seeing the HK-50 neutralise T3-M4
// Inventory has already been wiped out (a_clear_inv.ncs)
// Storing the amount of XP gained during the prologue within 001EBO_End variable

void main();

void _start() {
  main();
  return;
}

void main() {

  // Play the movie
  if (GetScriptParameter(1)) {
    if (GetGlobalNumber("001EBO_Movie_End") == 0) {
      SetGlobalNumber("001EBO_Movie_End", 1);
      PlayMovie("permov02", 0);
    }
  }

  // Set planet 11 not availble and not selectable? Is it the Ebon Hawk or Peragus? -> probably Ebon Hawk
  // 11 probably means PLANET_LIVE_01
  if (!GetIsXBox()) {
    SetPlanetAvailable(PLANET_LIVE_01, 0);
    SetPlanetSelectable(PLANET_LIVE_01, 0);
  }

  int journalState = 88;
  if (!GetIsXBox()) { int journalState = 89; }

  if (GetJournalEntry("tutorial_3CFD") != 0) {
    AurPostString("Completing tutorial_3CFD", 5, 10, 5.000000);
    AddJournalQuestEntry("tutorial_3CFD", journalState, 0);
  }
  if (GetJournalEntry("tutorial_heal_pc") != 0) {
    AurPostString("Completing tutorial_heal_pc", 5, 11, 5.000000);
    AddJournalQuestEntry("tutorial_heal_pc", 89, 0);
  }
  if (GetJournalEntry("tutorial_garage") != 0) {
    AurPostString("Completing tutorial_garage", 5, 12, 5.000000);
    AddJournalQuestEntry("tutorial_garage", 89, 0);
  }

  AurPostString("Completing tutorial_fix_ebo", 5, 13, 5.000000);
  AddJournalQuestEntry("tutorial_fix_ebo", 90, 0);

  // Unequip all -> not all, invalid items will appear in inventory (CARMOR slot)
  // int iSlot = 0;
  // while( iSlot < NUM_INVENTORY_SLOTS ){
  // // for( int iSlot = 0 ; iSlot < NUM_INVENTORY_SLOTS ; iSlot++ ){
  //   GiveItem(GetItemInSlot(iSlot++, GetFirstPC()), GetFirstPC());
  // }
  // GiveItem(GetItemInSlot(INVENTORY_SLOT_CWEAPON_L, GetFirstPC()), GetFirstPC());
  // GiveItem(GetItemInSlot(INVENTORY_SLOT_CWEAPON_R, GetFirstPC()), GetFirstPC());
  // GiveItem(GetItemInSlot(INVENTORY_SLOT_CWEAPON_B, GetFirstPC()), GetFirstPC());


  // Unequip each items and store them in the inventory
  GiveItem(GetItemInSlot(INVENTORY_SLOT_HEAD, GetFirstPC()), GetFirstPC());
  GiveItem(GetItemInSlot(INVENTORY_SLOT_BODY, GetFirstPC()), GetFirstPC());
  GiveItem(GetItemInSlot(INVENTORY_SLOT_HANDS, GetFirstPC()), GetFirstPC());

  GiveItem(GetItemInSlot(INVENTORY_SLOT_LEFTARM, GetFirstPC()), GetFirstPC());
  GiveItem(GetItemInSlot(INVENTORY_SLOT_RIGHTARM, GetFirstPC()), GetFirstPC());

  GiveItem(GetItemInSlot(INVENTORY_SLOT_RIGHTWEAPON, GetFirstPC()), GetFirstPC());
  GiveItem(GetItemInSlot(INVENTORY_SLOT_LEFTWEAPON, GetFirstPC()), GetFirstPC());

  GiveItem(GetItemInSlot(INVENTORY_SLOT_RIGHTWEAPON2, GetFirstPC()), GetFirstPC());
  GiveItem(GetItemInSlot(INVENTORY_SLOT_LEFTWEAPON2, GetFirstPC()), GetFirstPC());

  // Save lost XP obtained by T3 here:
  int beginXp = 3000;

  // Global numbers appears to be saved as a "signed char" (8bits) which means it can go within -128 and +127
  // We compress the XP value by adding a divider:
  int divider = 5;
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
  SetGlobalNumber( "001EBO_End", gainedXp );

  DisableHealthRegen(0);
  SwitchPlayerCharacter(-1); // -1 specifies to switch back to the original PC
  RemoveAvailableNPC(NPC_T3_M4);
  RemoveAvailableNPC(NPC_MIRA); // 3C-FD is at Mira's place

  // Now the current player is your character. Attribute back the XP
  // WILL DO THIS LATER: Otherwise a dialog with Kreia won't trigger once you reached level 2
  // SetXP(GetFirstPC(), gainedXp);

  // Go to peragus
  StartNewModule("101PER", "", "", "", "", "", "", "");

  return;
}
