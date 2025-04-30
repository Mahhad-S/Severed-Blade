/// @function CollectCoins(amount)
/// @param amount

function CollectCoins(_amount) {
    global.playerMoney += _amount;
    show_debug_message("Added " + string(_amount) + " coins!");
}