--// Nachricht abschicken
addEvent("BuyCoins.server",true)
addEventHandler("BuyCoins.server",root,function(coins)
	local coins = tonumber(coins)
	local price = coins * 5000
	local playerMoney = tonumber(getElementData(client,"Geld"))
	
	if(playerMoney >= price)then
		setElementData(client,"Geld",getElementData(client,"Geld")-price)
		setElementData(client,"GDMCoins",getElementData(client,"GDMCoins")+coins)
		infobox(client,loc(client,"GDMCoinsMessage5"):format(coins),0,125,0)
	else infobox(client,loc(client,"GDMCoinsMessage4"),125,0,0)end
end)