Topliste = {
	["Kategorien"] = {
		["DE"] = {"Geld","Coins","Spielstunden","Kills [Gesamt]","Kills [Deagle-Arena]","Kills [Tactics-Arena]","Kills [Deathmatch-Arena]","Tode [Gesamt]","Tode [Deagle-Arena]","Tode [Tactics-Arena]","Tode [Deathmatch-Arena]","Damage [Gesamt]","Damage [Deagle-Arena]","Damage [Tactics-Arena]","Damage [Deathmatch-Arena]","MVP's [Gesamt]","MVP's [Tactics-Arena]","Erreichte Achievements"},
	},
	["Database"] = {["Geld"] = "Geld",["Coins"] = "GDMCoins",["Spielstunden"] = "Spielstunden",["Kills [Gesamt]"] = "KillsGesamt",["Tode [Gesamt]"] = "TodeGesamt",["Kills [Deagle-Arena]"] = "KillsDeagleArena",["Tode [Deagle-Arena]"] = "TodeDeagleArena",["Kills [Deathmatch-Arena]"] = "KillsDeathmatch",["Tode [Deathmatch-Arena]"] = "TodeDeathmatch",["Kills [Tactics-Arena]"] = "KillsTacticArena",["Tode [Tactics-Arena]"] = "TodeTacticArena",["Damage [Gesamt]"] = "DamageGesamt",["Damage [Deagle-Arena]"] = "DamageDeagleArena",["Damage [Deathmatch-Arena]"] = "DamageDeathmatch",["Damage [Tactics-Arena]"] = "DamageTacticArena",["MVP's [Gesamt]"] = "MVPsGesamt",["MVP's [Tactics-Arena]"] = "MVPsTactics",["Erreichte Achievements"] = "Achievements"},
}

--// Pickups
Topliste.pickup1 = createPickup(1729.130859375,-1655.529296875,20.236106872559,3,1247,50)
setElementInterior(Topliste.pickup1,18)
Topliste.pickup2 = createPickup(258.59539794922,-36.483043670654,1.5949423313141,3,1247,50)

function Topliste.hitPickup(player)
	if(player == localPlayer)then
		if(getElementDimension(player) == getElementDimension(source))then
			Topliste.openWindow()
		end
	end
end
addEventHandler("onClientPickupHit",Topliste.pickup1,Topliste.hitPickup)
addEventHandler("onClientPickupHit",Topliste.pickup2,Topliste.hitPickup)

--// Fenster erstellen
function Topliste.openWindow()
	if(isWindowOpen())then
        GUIEditor.window[1] = guiCreateWindow(536, 338, 548, 339, loc("ToplisteMessage1"), false)
        GUIEditor.gridlist[1] = guiCreateGridList(10, 27, 246, 302, false, GUIEditor.window[1])
        category = guiGridListAddColumn(GUIEditor.gridlist[1], "", 0.9)
        GUIEditor.label[1] = guiCreateLabel(266, 27, 272, 265, loc("ToplisteMessage2"), false, GUIEditor.window[1])
		guiLabelSetHorizontalAlign(GUIEditor.label[1], "left", true)
		GUIEditor.button[1] = guiCreateButton(266, 302, 272, 27, loc("ToplisteMessage3"), false, GUIEditor.window[1]) 
		setWindowDatas("set")

		for _,v in pairs(Topliste["Kategorien"][getElementData(localPlayer,"Sprache")])do
			local row = guiGridListAddRow(GUIEditor.gridlist[1])
			guiGridListSetItemText(GUIEditor.gridlist[1],row,category,v,false,false)
		end
		
		addEventHandler("onClientGUIClick",GUIEditor.gridlist[1],function()
			local clicked = guiGridListGetItemText(GUIEditor.gridlist[1],guiGridListGetSelectedItem(GUIEditor.gridlist[1]),1)
			if(clicked ~= "")then
				triggerServerEvent("Topliste.getDatas",localPlayer,Topliste["Database"][clicked])
			end
		end,false)
		
		addEventHandler("onClientGUIClick",GUIEditor.button[1],function()
			setWindowDatas("reset")
		end,false)
	end
end

--// Topliste Daten setzen
addEvent("Topliste.setDatas",true)
addEventHandler("Topliste.setDatas",root,function(currentTop)
	if(#currentTop >= 1)then
		local text = ""
		for i = 1,#currentTop do
			text = text.." \n"..i..". "..currentTop[i][1].." ("..currentTop[i][2]..")"
		end
		guiSetText(GUIEditor.label[1],text)
	end
end)