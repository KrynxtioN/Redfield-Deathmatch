VIP = {
	["Farbcodes"] = {
		[1] = "#c2883b",
		[2] = "#C0C0C0",
		[3] = "#e8b923",
	},
}

--// Hat Spieler aktiven VIP-Status?
function isPremium(player)
	local Bronze, Silber, Gold = tonumber(getElementData(player,"VIPBronzeZeit")),tonumber(getElementData(player,"VIPSilberZeit")),tonumber(getElementData(player,"VIPGoldZeit"))
	if(Bronze >= 1 or Silber >= 1 or Gold >= 1)then
		return true
	else
		return false
	end
end
 
function hasBronzePremium(player)
	local Bronze = tonumber(getElementData(player,"VIPBronzeZeit"))
	if(Bronze >= 1)then
		return true
	else
		return false
	end
end

function hasSilberPremium(player)
	local Silber = tonumber(getElementData(player,"VIPSilberZeit"))
	if(Silber >= 1)then
		return true
	else
		return false
	end
end

function hasGoldPremium(player)
	local Gold = tonumber(getElementData(player,"VIPGoldZeit"))
	if(Gold >= 1)then
		return true
	else
		return false
	end
end

--// Check VIP
function VIP.checkStatus(player)
	local time = getRealTime()
	local timestamp = time.timestamp
	local Bronze,Silber,Gold = tonumber(getElementData(player,"VIPBronzeZeit")),tonumber(getElementData(player,"VIPSilberZeit")),tonumber(getElementData(player,"VIPGoldZeit"))
	if(timestamp > Bronze and Bronze >= 1)then
		outputChatBox(loc(player,"VIPMessage11"),player,125,0,0)
		setElementData(player,"VIPBronzeZeit",0)
	end
	if(timestamp > Silber and Silber >= 1)then
		outputChatBox(loc(player,"VIPMessage12"),player,125,0,0)
		setElementData(player,"VIPSilberZeit",0)
	end
	if(timestamp > Gold and Gold >= 1)then
		outputChatBox(loc(player,"VIPMessage13"),player,125,0,0)
		setElementData(player,"VIPGoldZeit",0)
	end
	setElementData(player,"PremiumLevel",0)
	if(hasBronzePremium(player))then setElementData(player,"PremiumLevel",1)end
	if(hasSilberPremium(player))then setElementData(player,"PremiumLevel",2)end
	if(hasGoldPremium(player))then setElementData(player,"PremiumLevel",3)end
end

--// Teleporter in den VIP-Bereich
local TeleporterRein = createPickup(259.87393188477,-15.097911834717,2.0729942321777,3,1318,50)
local TeleporterRaus = createPickup(1727.0236816406,-1637.8325195313,20.222938537598,3,1318,50)
setElementInterior(TeleporterRaus,18)

addEventHandler("onPickupHit",TeleporterRein,function(player)
	if(getElementData(player,"loggedin") == 1 and not(isPedInVehicle(player)) and getElementDimension(player) == getElementDimension(source))then
		if(isPremium(player))then
			fadeCamera(player,false,0.5)
			setTimer(function(player)
				if(isElement(player))then
					setElementPosition(player,1727.1295166016,-1640.1915283203,20.224090576172)
					setElementRotation(player,0,0,180)
					setElementInterior(player,18)
					setElementDimension(player,0)
					fadeCamera(player,true,0.5)
				end
			end,500,1,player)
		else infobox(player,loc(player,"VIPMessage1"),125,0,0)end
	end
end)

addEventHandler("onPickupHit",TeleporterRaus,function(player)
	if(getElementData(player,"loggedin") == 1 and not(isPedInVehicle(player)) and getElementDimension(player) == getElementDimension(source))then
		if(isPremium(player))then
			fadeCamera(player,false,0.5)
			setTimer(function(player)
				if(isElement(player))then
					setElementPosition(player,262.37243652344,-14.983618736267,2.0755796432495)
					setElementInterior(player,0)
					setElementDimension(player,0)
					setTimer(function(player)
						if(isElement(player))then
							setElementRotation(player,0,0,270)
						end
					end,500,1,player)
					fadeCamera(player,true,0.5)
				end
			end,500,1,player)
		else infobox(player,loc(player,"VIPMessage1"),125,0,0)end
	end
end)

--// VIP kaufen
addEvent("VIP.buy",true)
addEventHandler("VIP.buy",root,function(kosten,type)
	local kosten = tonumber(kosten)
	local time = getRealTime()
	local timestamp = time.timestamp
	local Bronze,Silber,Gold = tonumber(getElementData(client,"VIPBronzeZeit")),tonumber(getElementData(client,"VIPSilberZeit")),tonumber(getElementData(client,"VIPGoldZeit"))

	if(type == "Bronze" and (hasSilberPremium(client) or hasGoldPremium(client)))then
		infobox(client,loc(client,"VIPMessage23"),125,0,0)
		return
	end
	if(type == "Silber" and hasGoldPremium(client))then
		infobox(client,loc(client,"VIPMessage24"),125,0,0)
		return
	end

	if(getElementData(client,"GDMCoins") >= kosten)then
		setElementData(client,"GDMCoins",getElementData(client,"GDMCoins")-kosten)
		if(type == "Bronze")then
			if(Bronze == 0)then
				setElementData(client,"VIPBronzeZeit",time.timestamp + (30*86400))
				RegisterLogin.spawnEingangshalle(client)
			else
				setElementData(client,"VIPBronzeZeit",getElementData(client,"VIPBronzeZeit") + (30*86400))
			end
			infobox(client,loc(client,"VIPMessage15"),0,125,0)
		end
		if(type == "Silber")then
			setElementData(client,"VIPBronzeZeit",0)
			if(Silber == 0)then
				setElementData(client,"VIPSilberZeit",time.timestamp + (30*86400))
				RegisterLogin.spawnEingangshalle(client)
			else
				setElementData(client,"VIPSilberZeit",getElementData(client,"VIPSilberZeit") + (30*86400))
			end
			infobox(client,loc(client,"VIPMessage16"),0,125,0)
		end
		if(type == "Gold")then
			setElementData(client,"VIPBronzeZeit",0)
			setElementData(client,"VIPSilberZeit",0)
			if(Gold == 0)then
				setElementData(client,"VIPGoldZeit",time.timestamp + (30*86400))
				RegisterLogin.spawnEingangshalle(client)
			else
				setElementData(client,"VIPGoldZeit",getElementData(client,"VIPGoldZeit") + (30*86400))
			end
			infobox(client,loc(client,"VIPMessage17"),0,125,0)
		end
		RegisterLogin.savePlayerDatas(client)
		if(hasBronzePremium(client))then
			setElementData(client,"PremiumLevel",1)
			outputChatBox(loc(client,"RegisterLoginMessage14"):format(TimestampToDate(getPlayerData("userdata","Username",getPlayerName(client),"VIPBronzeZeit"))),client,0,125,0)
		elseif(hasSilberPremium(client))then
			setElementData(client,"PremiumLevel",2)
			outputChatBox(loc(client,"RegisterLoginMessage15"):format(TimestampToDate(getPlayerData("userdata","Username",getPlayerName(client),"VIPSilberZeit"))),client,0,125,0)
		elseif(hasGoldPremium(client))then
			setElementData(client,"PremiumLevel",3)
			outputChatBox(loc(client,"RegisterLoginMessage16"):format(TimestampToDate(getPlayerData("userdata","Username",getPlayerName(client),"VIPGoldZeit"))),client,0,125,0)
		end
	else infobox(client,loc(client,"VIPMessage14"):format(kosten),125,0,0)end
end)