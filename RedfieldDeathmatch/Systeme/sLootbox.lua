Lootbox = {}

--// Lootbox vergeben
setTimer(function()
	local time = getRealTime()
	if(#getElementsByType("player") >= 5)then
		if(time.hour >= 16 and time.hour <= 18 or time.hour >= 21 and time.hour <= 23)then
			if(math.random(1,1) == 1)then
				local allPlayers = {}
				for _,v in pairs(getElementsByType("player"))do
					if(getElementData(v,"loggedin") == 1)then
						table.insert(allPlayers,getPlayerName(v))
					end
				end
				local rnd = math.random(1,#allPlayers)
				local target = getPlayerFromName(allPlayers[rnd])
				for _,v in pairs(getElementsByType("player"))do
					if(getElementData(v,"loggedin") == 1)then
						outputChatBox(loc(v,"LootboxMessage8"):format(getPlayerName(v)),v,255,255,255,true)
					end
				end
				setElementData(target,"Lootbox",getElementData(target,"Lootbox")+1)
			end
		end
	end
end,1800000,0)

--// Skin vergeben
addEvent("Lootbox.givePlayerSkin",true)
addEventHandler("Lootbox.givePlayerSkin",root,function(skin)
	local skin = tonumber(skin)
	local newSkins = getPlayerData("userdata","Username",getPlayerName(client),"Skins")..skin.."|"
	dbExec(handler,"UPDATE userdata SET Skins = '"..newSkins.."' WHERE Username = '"..getPlayerName(client).."'")
	dbExec(handler,"UPDATE userdata SET SkinNumbers = '"..getPlayerData("userdata","Username",getPlayerName(client),"SkinNumbers")+1 .."' WHERE Username = '"..getPlayerName(client).."'")

	local allSkins = {}
	for _,skins in pairs({
		{1,2,9,10,11,12,14,15,16,17,20,23,24,25,26,28,31,34,35,36,37,38,39,40,41,43,51,52,53,54,55,56,58,60,63,64,69,72,73,75,76,77,78,79,85,87,88,89,94,95,96,99,128,129,130,131,132,133,134,135,136,151,158,159,160,161,168,182,183,184,196,197,198,199,200,201,202,205,207,212,213,218,219,220,221,222,230,231,232,238,243,244,245,246,256,257,258,259,261,262},
		{309,308,305,302,298,295,277,278,279,268,7,19,21,22,29,32,45,46,47,48,57,59,61,62,66,68,70,71,90,91,93,97,98,121,138,139,140,142,143,144,145,147,148,153,154,156,170,171,172,180,188,189,190,191,192,193,194,206,209,210,211,214,215,216,217,226,227,228,229,233,234,235,236,240,241,242,250,251,252,253,255},
		{312,306,303,290,280,281,282,274,275,276,13,18,30,50,67,80,81,82,83,84,100,101,103,105,112,117,118,125,126,146,150,152,163,164,176,177,179,223,224,225,247,249,254,263,265,266,267},
		{310,307,304,27,33,44,107,110,111,114,127,165,166,169,174,178,185,186,203,204,248,260,272,284,286,297},
		{269,104,106,109,115,120,123,124,173,264,284,288,287,291,301,296},
		{311,49,92,102,108,113,116,122,137,141,155,162,167,175,181,187,195,237,239,270,271,285,292,293,294,299}
	})do
		for _,skinID in pairs(skins)do
			allSkins[skinID] = true
		end
	end

	local playerSkins = getPlayerData("userdata","Username",getPlayerName(client),"Skins")..skin.."|"
	local hasAllSkins = true
	for skinID,_ in pairs(allSkins)do
		if(not string.find("|"..playerSkins,"|"..skinID.."|",1,true))then
			hasAllSkins = false
			break
		end
	end

	if(hasAllSkins)then
		setPlayerAchievement(client,1)
	end
end)

--// Lootbox öffnen
addEvent("Lootbox.open",true)
addEventHandler("Lootbox.open",root,function()
	if(getElementData(client,"loggedin") == 1)then
		if(tonumber(getElementData(client,"Lootbox")) >= 1)then
			setElementData(client,"LootboxenOpen",getElementData(client,"LootboxenOpen")+1)
			setElementData(client,"Lootbox",getElementData(client,"Lootbox")-1)
			triggerClientEvent(client,"Lootbox.open",client)

			local LootboxenOpen = getElementData(client,"LootboxenOpen")
			if(LootboxenOpen == 1)then setPlayerAchievement(client,26)end
			if(LootboxenOpen == 5)then setPlayerAchievement(client,27)end
			if(LootboxenOpen == 10)then setPlayerAchievement(client,28)end
		else
			infobox(client,loc(client,"LootboxMessage17"),125,0,0)
		end
	end
end)

--// Skins laden
addEvent("Lootbox.loadStuff",true)
addEventHandler("Lootbox.loadStuff",root,function()
	local tbl = {}
	local Skins = getPlayerData("userdata","Username",getPlayerName(client),"Skins")
	local SkinNumbers = getPlayerData("userdata","Username",getPlayerName(client),"SkinNumbers")
	for i = 1,SkinNumbers do
		local wstring = gettok(Skins,i,string.byte("|"))
		table.insert(tbl,{wstring})
	end
	triggerClientEvent(client,"Lootbox.refreshSkins",client,tbl)
end)

--// Lootbox kaufen
addEvent("Lootbox.buy",true)
addEventHandler("Lootbox.buy",root,function()
	if(getElementData(client,"loggedin") == 1)then
		if(getElementData(client,"GDMCoins") >= 1)then
			setElementData(client,"GDMCoins",getElementData(client,"GDMCoins")-1)
			setElementData(client,"Lootbox",getElementData(client,"Lootbox")+2)
			triggerClientEvent(client,"Lootbox.refreshSkins",client)
			infobox(client,loc(client,"LootboxMessage19"),0,125,0)
		else infobox(client,loc(client,"LootboxMessage18"),125,0,0)end
	end
end)

--// Lootbox Skin anziehen
addEvent("Lootbox.useSkin",true)
addEventHandler("Lootbox.useSkin",root,function(skin)
	if(getElementData(client,"loggedin") == 1)then
		local skin = tonumber(skin)
		setElementModel(client,skin)
		setElementData(client,"SkinID",skin)
		infobox(client,loc(client,"LootboxMessage20"),0,125,0)
	end
end)