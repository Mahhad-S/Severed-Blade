function scr_DialogueResponses(){
	switch (argument0) {
		case 0: break;
		
		//test-cases
		case 1: scr_NewTextBox("You gave response A!", 1); break;
		case 2: scr_NewTextBox("You gave response B! Any further response?", 1, ["3:Yes!", "0:No"]); break;
		case 3: scr_NewTextBox("Thanks for your responses!", 0); break;
		
		//Akari First Speach
		case 4: scr_NewTextBox("Are you ready for your first steps as a Samurai???", 0, ["5:Of Course!", "6:Not really"]); break;
		case 5: scr_NewTextBox("Very well, go to the South to the Cave of Rebirth", 0); break;
		case 6: scr_NewTextBox("Nonsense", 0, ["7:Continue..."]); break;
		case 7: scr_NewTextBox("Go challenge the Cave of Rebirth on the South", 0,); break;
		default: break;
	}
}