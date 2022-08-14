
void main();

void _start() {
	main();
	return;
}

void main() {


	if (GetIsPC(GetEnteringObject()) && GetGlobalBoolean("PER_TURNINTO_T3M4")) {
		SetGlobalBoolean("PER_TURNINTO_T3M4", 0);
  	SwitchPlayerCharacter(NPC_T3_M4);

    // Save XP obtained by T3 here: should be around 400PX
    // Global numbers appears to be saved as a "signed char" (8bits) which means it can go within -128 and +127
    // We compress the XP value by adding a divider:
    int divider = 10;
    // int currentXp = -128 + GetXP(GetObjectByTag("T3M4", 0))/divider; // both work
    int currentXp = -128 + GetXP(GetFirstPC())/divider;

    // cap if the starting XP is lower than beginXp and no xp is gained
    if( currentXp < -128 ){
      currentXp = -128;
    }

    // cap if we got more than the max allowed by "signed char"
    if( currentXp > 127 ){
      currentXp = 127;
    }

    // store the value
    SetGlobalNumber("001EBO_End", currentXp);

  	SetGlobalFadeIn(0., 2., 0., 0., 0.);
	}

  return;
}
