/// @function addItem
/// @description Add an item to a grid 
/// @argument0 DSGrid Grid_To_Add
/// @argument1 String Item_Name 
/// @argument2 Int Item_Amount
/// @argument3 String Item_Description 
/// @argument4 Sprite Item_Sprite 
/// @argument5 Script Item_Script 

gridToAddTo = argument0;
newItemName = argument1; 
newItemAmount = argument2;
newItemSprite = argument4;
newItemScript = argument5; 
//Case 1 - Item is already in the inventory 
for (i = 0; i < ds_grid_height(gridToAddTo); i++) 
{
	if (ds_grid_get(gridToAddTo, 0, i) == newItemName)
	{
		// we have found item in the inventory increment the amount 
		ds_grid_set(gridToAddTo, 1, i, ds_grid_get(gridToAddTo, 1, i) + newItemAmount);
		// returning boolean expression for aid in debugging 
		return true;
	}
};
//Case 2 - It's not in the inventory 
// 0 if its not in inventory else it's 1 
if (ds_grid_get(gridToAddTo, 0, 0) != 0)
{
	ds_grid_resize(gridAddTo, playerInventoryWidth, ds_grid_height(gridToAddTo) + 1);
}
newItemSpot = ds_grid_height(gridToAddTo) - 1;
ds_grid_set(gridToAddTo, 0, newItemSpot, newItemName);
ds_grid_set(gridToAddTo, 1, newItemSpot, newItemAmount);
ds_grid_set(gridToAddTo, 2, newItemSpot, newItemDescription);
ds_grid_set(gridToAddTo, 3, newItemSpot, newItemSprite);
ds_grid_set(gridToAddTo, 4, newItemSpot, newItemScript);
return true; 
