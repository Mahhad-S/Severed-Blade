function scr_DialogueResponses(){
	switch (argument0) {
		case 0: break;
		case 1: scr_NewTextBox("You gave response A!", 1); break;
		case 2: scr_NewTextBox("You gave response B! Any further response?", 1, ["3:Yes!", "0:No"]); break;
		case 3: scr_NewTextBox("Thanks for your responses!", 0); break;
		default: break;
	}
}