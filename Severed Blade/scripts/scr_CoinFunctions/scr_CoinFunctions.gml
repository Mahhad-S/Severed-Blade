function CollectCoins(_amount) {
    global.playerMoney += _amount;
    show_debug_message("Added " + string(_amount) + " coins! (Total: " + string(global.playerMoney) + ")");
}

function RemoveCoins(_amount) {
    if (global.playerMoney >= _amount) {
        global.playerMoney -= _amount;
        show_debug_message("Removed " + string(_amount) + " coins.");
    } else {
        show_debug_message("Not enough coins to remove " + string(_amount));
    }
}