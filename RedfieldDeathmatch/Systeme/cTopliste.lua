Topliste = {
	["Kategorien"] = {
		["DE"] = {
			["Allgemein"] = {"Geld","Coins","Spielstunden","Erreichte Achievements"},
			["Kills"] = {"Kills [Gesamt]","Kills [Deagle-Arena]","Kills [Tactics-Arena]","Kills [Deathmatch-Arena]"},
			["Tode"] = {"Tode [Gesamt]","Tode [Deagle-Arena]","Tode [Tactics-Arena]","Tode [Deathmatch-Arena]"},
			["Damage"] = {"Damage [Gesamt]","Damage [Deagle-Arena]","Damage [Tactics-Arena]","Damage [Deathmatch-Arena]"},
			["MVP's"] = {"MVP's [Gesamt]","MVP's [Tactics-Arena]"},
		},
		["EN"] = {
			["General"] = {"Money","Coins","Playtime","Unlocked Achievements"},
			["Kills"] = {"Kills [Total]","Kills [Deagle-Arena]","Kills [Tactics-Arena]","Kills [Deathmatch-Arena]"},
			["Deaths"] = {"Deaths [Total]","Deaths [Deagle-Arena]","Deaths [Tactics-Arena]","Deaths [Deathmatch-Arena]"},
			["Damage"] = {"Damage [Total]","Damage [Deagle-Arena]","Damage [Tactics-Arena]","Damage [Deathmatch-Arena]"},
			["MVP's"] = {"MVP's [Total]","MVP's [Tactics-Arena]"},
		},
	},
	["Database"] = {["Geld"] = "Geld",["Coins"] = "GDMCoins",["Spielstunden"] = "Spielstunden",["Kills [Gesamt]"] = "KillsGesamt",["Tode [Gesamt]"] = "TodeGesamt",["Kills [Deagle-Arena]"] = "KillsDeagleArena",["Tode [Deagle-Arena]"] = "TodeDeagleArena",["Kills [Deathmatch-Arena]"] = "KillsDeathmatch",["Tode [Deathmatch-Arena]"] = "TodeDeathmatch",["Kills [Tactics-Arena]"] = "KillsTacticArena",["Tode [Tactics-Arena]"] = "TodeTacticArena",["Damage [Gesamt]"] = "DamageGesamt",["Damage [Deagle-Arena]"] = "DamageDeagleArena",["Damage [Deathmatch-Arena]"] = "DamageDeathmatch",["Damage [Tactics-Arena]"] = "DamageTacticArena",["MVP's [Gesamt]"] = "MVPsGesamt",["MVP's [Tactics-Arena]"] = "MVPsTactics",["Erreichte Achievements"] = "Achievements", ["Money"] = "Geld",["Playtime"] = "Spielstunden",["Kills [Total]"] = "KillsGesamt",["Deaths [Total]"] = "TodeGesamt",["Deaths [Deagle-Arena]"] = "TodeDeagleArena",["Deaths [Deathmatch-Arena]"] = "TodeDeathmatch",["Deaths [Tactics-Arena]"] = "TodeTacticArena",["Damage [Total]"] = "DamageGesamt",["MVP's [Total]"] = "MVPsGesamt",["Unlocked Achievements"] = "Achievements"},
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

function Topliste.renderPickupText()
	if(isWindowOpen())then
		local px,py,pz = getElementPosition(localPlayer)
		for _,pickup in pairs({Topliste.pickup1,Topliste.pickup2})do
			if(getElementInterior(localPlayer) == getElementInterior(pickup) and getElementDimension(localPlayer) == getElementDimension(pickup))then
				local x,y,z = getElementPosition(pickup)
				if(getDistanceBetweenPoints3D(px,py,pz,x,y,z) <= 20)then
					local sx,sy = getScreenFromWorldPosition(x,y,z+0.5)
					if(sx and sy)then
						dxDrawText(loc("ToplisteMessage4"),sx-100,sy-20,sx+100,sy+20,tocolor(255,255,255,255),1.15,"default-bold","center","center",false,false,false,true)
					end
				end
			end
		end
	end
end
addEventHandler("onClientRender",root,Topliste.renderPickupText)

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

		for k,_ in pairs(Topliste["Kategorien"][getElementData(localPlayer,"Sprache")])do
			local row = guiGridListAddRow(GUIEditor.gridlist[1])
			guiGridListSetItemText(GUIEditor.gridlist[1],row,category,k,false,false)
		end
		
		addEventHandler("onClientGUIClick",GUIEditor.gridlist[1],function()
			local clicked = guiGridListGetItemText(GUIEditor.gridlist[1],guiGridListGetSelectedItem(GUIEditor.gridlist[1]),1)
			if(clicked ~= "")then
				if(clicked == "<-")then
					guiGridListClear(GUIEditor.gridlist[1])
					guiSetText(GUIEditor.label[1],loc("ToplisteMessage2"))
					for k,_ in pairs(Topliste["Kategorien"][getElementData(localPlayer,"Sprache")])do
						local row = guiGridListAddRow(GUIEditor.gridlist[1])
						guiGridListSetItemText(GUIEditor.gridlist[1],row,category,k,false,false)
					end
					return
				end
				local tbl = Topliste["Kategorien"][getElementData(localPlayer,"Sprache")][clicked]
				if(tbl)then
					guiGridListClear(GUIEditor.gridlist[1])
					local row = guiGridListAddRow(GUIEditor.gridlist[1])
					guiGridListSetItemText(GUIEditor.gridlist[1],row,category,"<-",false,false)
					guiGridListSetItemColor(GUIEditor.gridlist[1],row,category,255,255,255,255)
					for _,v in pairs(tbl)do
						local row = guiGridListAddRow(GUIEditor.gridlist[1])
						guiGridListSetItemText(GUIEditor.gridlist[1],row,category,v,false,false)
					end
				elseif(Topliste["Database"][clicked])then
					Topliste.currentCategory = Topliste["Database"][clicked]
					triggerServerEvent("Topliste.getDatas",localPlayer,Topliste["Database"][clicked])
				end
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
			local value = currentTop[i][2]
			if(Topliste.currentCategory == "Geld")then value = "$"..tostring(value) end
			text = text.." \n"..i..". "..currentTop[i][1].." ("..value..")"
		end
		guiSetText(GUIEditor.label[1],text)
	end
end)