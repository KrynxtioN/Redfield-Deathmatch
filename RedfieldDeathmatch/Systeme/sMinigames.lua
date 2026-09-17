Minigames = { activeMinigame = nil }

--// Quersumme ausrechnen
function generateQuersumme()
	local tbl = {}
	Minigames.quersumme = ""
	Minigames.quersummeLoesung = 0
	Minigames.quersummeBelohnung = math.random(200,400)
	Minigames.quersummeGelouest = false
	Minigames.activeMinigame = "Quersumme"
	for i = 1,10 do
		local rnd = math.random(0,9)
		Minigames.quersumme = Minigames.quersumme..rnd
		Minigames.quersummeLoesung = Minigames.quersummeLoesung + rnd
	end
	for _,v in pairs(getElementsByType("player"))do
		if(getElementData(v,"loggedin") == 1)then
			outputChatBox(loc(v,"MinigamesMessage1"):format(Minigames.quersumme,Minigames.quersummeBelohnung),v,255,255,255,true)
		end
	end
	Minigames.endTimer = setTimer(function()
		for _,v in pairs(getElementsByType("player"))do
			if(getElementData(v,"loggedin") == 1)then
				outputChatBox(loc(v,"MinigamesMessage2"),v,255,255,255,true)
			end
		end
	end,120000,1)
end

function Minigames.quersummeFinished(player)
	for _,v in pairs(getElementsByType("player"))do
		if(getElementData(v,"loggedin") == 1)then
			outputChatBox(loc(v,"MinigamesMessage3"):format(getPlayerName(player),Minigames.quersummeLoesung,Minigames.quersummeBelohnung),v,255,255,255,true)
		end
	end
	setElementData(player,"Geld",getElementData(player,"Geld")+Minigames.quersummeBelohnung)
	if(isTimer(Minigames.endTimer))then killTimer(Minigames.endTimer)end
end

--// Buchstaben-Zahlen-Kombination
function generateBuchstabenZahlen()
	local zeichen = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
	Minigames.buchstabenZahlen = ""
	Minigames.buchstabenZahlenBelohnung = math.random(200,400)
	Minigames.buchstabenZahlenGeloest = false
	Minigames.activeMinigame = "BuchstabenZahlen"

	for i = 1,8 do
		local rnd = math.random(1,#zeichen)
		Minigames.buchstabenZahlen = Minigames.buchstabenZahlen..zeichen:sub(rnd,rnd)
	end

	for _,v in pairs(getElementsByType("player"))do
		if(getElementData(v,"loggedin") == 1)then
			outputChatBox(loc(v,"MinigamesMessage4"):format(Minigames.buchstabenZahlen,Minigames.buchstabenZahlenBelohnung),v,255,255,255,true)
		end
	end

	Minigames.endTimer = setTimer(function()
		for _,v in pairs(getElementsByType("player"))do
			if(getElementData(v,"loggedin") == 1)then
				outputChatBox(loc(v,"MinigamesMessage5"),v,255,255,255,true)
			end
		end
	end,120000,1)
end

function Minigames.buchstabenZahlenFinished(player)
	for _,v in pairs(getElementsByType("player"))do
		if(getElementData(v,"loggedin") == 1)then
			outputChatBox(loc(v,"MinigamesMessage6"):format(getPlayerName(player),Minigames.buchstabenZahlen,Minigames.buchstabenZahlenBelohnung),v,255,255,255,true)
		end
	end
	setElementData(player,"Geld",getElementData(player,"Geld")+Minigames.buchstabenZahlenBelohnung)
	if(isTimer(Minigames.endTimer))then killTimer(Minigames.endTimer)end
end

--// Minigame Antworten überprüfen
addEventHandler("onPlayerChat",root,function(message)
	if(Minigames.activeMinigame == "Quersumme")then
		if(tonumber(message) == Minigames.quersummeLoesung)then
			Minigames.quersummeFinished(source)
			Minigames.activeMinigame = nil
		end
	elseif(Minigames.activeMinigame == "BuchstabenZahlen")then
		if(message == Minigames.buchstabenZahlen)then
			Minigames.buchstabenZahlenFinished(source)
			Minigames.activeMinigame = nil
		end
	end
end)

--// Minigame auslösen
setTimer(function()
	local rnd = math.random(1,2)
	if(rnd == 1)then
		generateQuersumme()
	elseif(rnd == 2)then
		generateBuchstabenZahlen()
	end
end,1800000,0)