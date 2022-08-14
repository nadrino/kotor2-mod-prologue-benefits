// Decompiled using ncsdecomp
void main();

void _start() {
	main();
	return;
}

void main() {
	AurPostString("Adding T3M4 to party...", 5, 5, 5.);

	ClearAllEffects();

  // AssignCommand(GetObjectByTag("T3M4", 0), );

  ApplyEffectToObject(0, EffectResurrection(100), GetObjectByTag("T3M4", 0), 0.0);

  AddPartyMember(NPC_T3_M4, GetObjectByTag("T3M4", 0));
  SetNPCSelectability(NPC_T3_M4, 1);

  // Merge T3 inventory with yours
  object t3Storage = GetObjectByTag("ComputerPanel");
  object player = GetPartyMemberByIndex(0);
  object nextItem = GetFirstItemInInventory(t3Storage);
  while( nextItem != OBJECT_INVALID ){
    GiveItem(nextItem, player);
    nextItem = GetFirstItemInInventory(t3Storage);
  }
}
