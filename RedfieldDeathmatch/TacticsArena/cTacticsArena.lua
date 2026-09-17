Tactics = {nextMapOpen = false,
	["Maps"] = {
		["Namen"] = {"Drogenlabor SF","Drogenschiff","Lagerhalle SF","Skaterpark","Glen Park","Ghetto LS","Einkaufszentrum","Einkaufsstraße","Friedhof LS","Piratenschiff","Lagerhalle LV","LV Stadthalle"},
	},
}
--// Matrix Mapgrenzen
Tactics.matrixBoundary = nil

addEvent("Tactics.createMatrixBoundary",true)
addEventHandler("Tactics.createMatrixBoundary",root,function(x1,y1,x2,y2)
	Tactics.matrixBoundary = {x1 = math.min(x1,x2),y1 = math.min(y1,y2),x2 = math.max(x1,x2),y2 = math.max(y1,y2)}
end)

addEvent("Tactics.destroyMatrixBoundary",true)
addEventHandler("Tactics.destroyMatrixBoundary",root,function()
	Tactics.matrixBoundary = nil
end)

function Tactics.renderMatrixBoundary()
	if(getElementData(localPlayer,"Lobby") ~= "TacticsArena" or not Tactics.matrixBoundary)then return end

	local b = Tactics.matrixBoundary
	local px,py,pz = getElementPosition(localPlayer)
	local tick = getTickCount()
	local alpha = 130+math.floor((math.sin(tick/250)+1)*45)
	local z1,z2 = pz-8,pz+25
	local step = 3

	for z=z1,z2,3 do
		dxDrawLine3D(b.x1,b.y1,z,b.x2,b.y1,z,tocolor(0,255,90,alpha),1)
		dxDrawLine3D(b.x1,b.y2,z,b.x2,b.y2,z,tocolor(0,255,90,alpha),1)
		dxDrawLine3D(b.x1,b.y1,z,b.x1,b.y2,z,tocolor(0,255,90,alpha),1)
		dxDrawLine3D(b.x2,b.y1,z,b.x2,b.y2,z,tocolor(0,255,90,alpha),1)
	end

	for xx=b.x1,b.x2,step do
		local offset = ((tick/35)+(xx*13))%33
		dxDrawLine3D(xx,b.y1,z2-offset,xx,b.y1,z2-offset-5,tocolor(80,255,130,220),1.7)
		dxDrawLine3D(xx,b.y2,z2-offset,xx,b.y2,z2-offset-5,tocolor(80,255,130,220),1.7)
	end

	for yy=b.y1,b.y2,step do
		local offset = ((tick/35)+(yy*13))%33
		dxDrawLine3D(b.x1,yy,z2-offset,b.x1,yy,z2-offset-5,tocolor(80,255,130,220),1.7)
		dxDrawLine3D(b.x2,yy,z2-offset,b.x2,yy,z2-offset-5,tocolor(80,255,130,220),1.7)
	end

	dxDrawLine3D(b.x1,b.y1,z1,b.x2,b.y1,z1,tocolor(0,255,90,230),3)
	dxDrawLine3D(b.x1,b.y2,z1,b.x2,b.y2,z1,tocolor(0,255,90,230),3)
	dxDrawLine3D(b.x1,b.y1,z1,b.x1,b.y2,z1,tocolor(0,255,90,230),3)
	dxDrawLine3D(b.x2,b.y1,z1,b.x2,b.y2,z1,tocolor(0,255,90,230),3)
end
addEventHandler("onClientRender",root,Tactics.renderMatrixBoundary)

--// Lobby verlassen Information
function Tactics.renderLeaveInfo()
	if(getElementData(localPlayer,"Lobby") == "TacticsArena")then
		dxDrawText(loc("TacticArenaMessage13"),1350*(x/1920),1020*(y/1080),1890*(x/1920),1060*(y/1080),tocolor(255,255,255,200),1.00*(y/1080),"default-bold","right","center",false,false,false,false,false)
	end
end
addEventHandler("onClientRender",root,Tactics.renderLeaveInfo)

--// Killfeed
Tactics.killfeed = {}

addEvent("Tactics.addKillfeed",true)
addEventHandler("Tactics.addKillfeed",root,function(text)
	table.insert(Tactics.killfeed,1,{text = text,tick = getTickCount()})
	if(#Tactics.killfeed > 5)then table.remove(Tactics.killfeed)end
end)

function Tactics.renderKillfeed()
	if(getElementData(localPlayer,"Lobby") ~= "TacticsArena")then return end

	local now = getTickCount()
	for i=#Tactics.killfeed,1,-1 do
		if(now-Tactics.killfeed[i].tick >= 6000)then table.remove(Tactics.killfeed,i)end
	end

	for i,v in ipairs(Tactics.killfeed)do
		dxDrawText(v.text,1400*(x/1920),(450+(i-1)*38)*(y/1080),1870*(x/1920),(482+(i-1)*38)*(y/1080),tocolor(255,255,255,255),1.00*(y/1080),"default-bold","right","center",false,false,false,true,false)
	end
end
addEventHandler("onClientRender",root,Tactics.renderKillfeed)

--// Runden-MVP Anzeige
Tactics.mvpDisplay = nil

addEvent("Tactics.showMVP",true)
addEventHandler("Tactics.showMVP",root,function(names,damage,kills)
	Tactics.mvpDisplay = {
		names = names or {},
		damage = tonumber(damage) or 0,
		kills = tonumber(kills) or 0,
		endTick = getTickCount()+5000
	}
end)

function Tactics.renderMVP()
	local data = Tactics.mvpDisplay
	if(not data)then return end
	if(getTickCount() >= data.endTick)then
		Tactics.mvpDisplay = nil
		return
	end

	local names = table.concat(data.names," & ")
	local title = (#data.names > 1) and "MVPs" or "MVP"

	-- Schlichter dunkler Hintergrund, damit die Anzeige auf jeder Map gut lesbar ist.
	dxDrawRectangle(710*(x/1920),430*(y/1080),500*(x/1920),145*(y/1080),tocolor(0,0,0,175),false)
	dxDrawRectangle(710*(x/1920),430*(y/1080),500*(x/1920),3*(y/1080),tocolor(255,190,35,255),false)

	dxDrawText(title,725*(x/1920),442*(y/1080),1195*(x/1920),470*(y/1080),tocolor(255,190,35,255),0.95*(y/1080),"default-bold","center","center",false,false,false,false,false)
	dxDrawText(names,725*(x/1920),472*(y/1080),1195*(x/1920),515*(y/1080),tocolor(255,255,255,255),1.20*(y/1080),"default-bold","center","center",false,false,false,true,false)
	dxDrawText("Damage: "..math.floor(data.damage).."  |  Kills: "..math.floor(data.kills),725*(x/1920),520*(y/1080),1195*(x/1920),555*(y/1080),tocolor(220,220,220,255),0.90*(y/1080),"default-bold","center","center",false,false,false,false,false)
end
addEventHandler("onClientRender",root,Tactics.renderMVP)

--// Spieler in ein Team tun
addEvent("Tactics.putPlayerInTeam",true)
addEventHandler("Tactics.putPlayerInTeam",root,function()
	triggerServerEvent("Tactics.putPlayerInTeam",localPlayer)
end)

--// Map verlassen Information
addEvent("Tactics.createRedBildschirm",true)
addEventHandler("Tactics.createRedBildschirm",root,function()
	Tactics.seconds = 10
	addEventHandler("onClientRender",root,Tactics.renderRedBildschirm)
	Tactics.killTimer = setTimer(function()
		playSoundFrontEnd(38)
		Tactics.seconds = Tactics.seconds - 1
		setElementHealth(localPlayer,getElementHealth(localPlayer)-5)
		if(Tactics.seconds == 0)then
			removeEventHandler("onClientRender",root,Tactics.renderRedBildschirm)
		end
	end,1000,10)
end)

addEvent("Tactics.destroyRedBildschirm",true)
addEventHandler("Tactics.destroyRedBildschirm",root,function()
	removeEventHandler("onClientRender",root,Tactics.renderRedBildschirm)
	if(isTimer(Tactics.killTimer))then killTimer(Tactics.killTimer)end
end)

function Tactics.renderRedBildschirm()
    dxDrawRectangle(0*(x/1920), 0*(y/1080), 1920*(x/1920), 1080*(y/1080), tocolor(255, 0, 0, 100), false)
    dxDrawText(loc("TacticArenaMessage1"):format(Tactics.seconds), 0*(x/1920), 0*(y/1080), 1920*(x/1920), 1080*(y/1080), tocolor(255, 255, 255, 255), 1.50*(y/1080), "default-bold", "center", "center", false, false, false, true, false)
end

--// Countdown
addEvent("Tactics.createCountdown",true)
addEventHandler("Tactics.createCountdown",root,function(counter)
	Tactics.countdown = counter
	addEventHandler("onClientRender",root,Tactics.dxCountdown)
end)

addEvent("Tactics.countdownRefresh",true)
addEventHandler("Tactics.countdownRefresh",root,function(counter)
	Tactics.countdown = counter
end)

addEvent("Tactics.countdownDestroy",true)
addEventHandler("Tactics.countdownDestroy",root,function(nosound)
	removeEventHandler("onClientRender",root,Tactics.dxCountdown)
	if(isTimer(Tactics.killTimer))then killTimer(Tactics.killTimer)end
	if(not(nosound))then playSound("Files/Sounds/letsgo.wav")end
end)

function Tactics.dxCountdown()
	if(isWindowOpen())then
		dxDrawText(Tactics.countdown, 0*(x/1920), 0*(y/1080), 1920*(x/1920), 1080*(y/1080), tocolor(255, 255, 255, 255), 1.40*(y/1080), "default-bold", "center", "center", false, false, false, false, false)
	end
end

--// Gamespeed
addEvent("setGamespeed",true)
addEventHandler("setGamespeed",root,function(gamespeed)
	setGameSpeed(tonumber(gamespeed))
end)

--// Map wählen
addEvent("Tactics.nextMap",true)
addEventHandler("Tactics.nextMap",root,function()
	if(Tactics.nextMapOpen == true)then
		Tactics.nextMapOpen = false
		setWindowDatas("reset")
	else
		if(isWindowOpen())then
			if(getElementData(localPlayer,"Lobby") == "TacticsArena")then
				GUIEditor.window[1] = guiCreateWindow(706, 264, 386, 389, loc("TacticArenaMessage9"), false)

				GUIEditor.gridlist[1] = guiCreateGridList(10, 26, 366, 317, false, GUIEditor.window[1])
				map = guiGridListAddColumn(GUIEditor.gridlist[1], loc("TacticArenaMessage10"), 0.9)
				GUIEditor.button[1] = guiCreateButton(10, 353, 178, 26, loc("TacticArenaMessage11"), false, GUIEditor.window[1])
				GUIEditor.button[2] = guiCreateButton(198, 353, 178, 26, loc("TacticArenaMessage12"), false, GUIEditor.window[1])
				setWindowDatas("set")
				Tactics.nextMapOpen = true
				
				for _,v in pairs(Tactics["Maps"]["Namen"])do
					local row = guiGridListAddRow(GUIEditor.gridlist[1])
					guiGridListSetItemText(GUIEditor.gridlist[1],row,map,v,false,false)
				end
				
				addEventHandler("onClientGUIClick",GUIEditor.button[1],function()
					local clicked = guiGridListGetItemText(GUIEditor.gridlist[1],guiGridListGetSelectedItem(GUIEditor.gridlist[1]),1)
					if(clicked ~= "")then
						triggerServerEvent("Tactics.setNextMap",localPlayer,clicked)
					else infobox(loc("TacticArenaMessage8"),125,0,0)end
				end,false)
				
				addEventHandler("onClientGUIClick",GUIEditor.button[2],function()
					setWindowDatas("reset")
					Tactics.nextMapOpen = false
				end,false)
			end
		end		
    end
end)