/// @function RemoveCoins(amount)
/// @param amount

function RemoveCoins(amount) {
    if (global.playerMoney >= amount) {
        global.playerMoney -= amount;
        show_debug_message("Removed " + string(amount) + " coins.");
    } else {
        show_debug_message("Not enough coins to remove " + string(amount));
        // Optionally block the action
    }
}