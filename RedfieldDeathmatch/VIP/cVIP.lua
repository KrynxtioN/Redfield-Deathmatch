VIP = {open = false,
	["Farbcodes"] = {
		[1] = "#c2883b",
		[2] = "#C0C0C0",
		[3] = "#e8b923",
	},
}

--// Fenster öffnen
bindKey("f4","down",function()
	if(VIP.open == true)then
		setWindowDatas("reset")
		VIP.open = false
	else
		if(getElementData(localPlayer,"loggedin") == 1 and isWindowOpen())then
			if(getElementData(localPlayer,"Lobby") == "Eingangshalle")then
				GUIEditor.window[1] = guiCreateWindow(494, 260, 710, 418, loc("VIPMessage2"), false)

				GUIEditor.button[1] = guiCreateButton(10, 29, 187, 39, loc("VIPMessage3"), false, GUIEditor.window[1])
				GUIEditor.button[2] = guiCreateButton(10, 78, 187, 39, loc("VIPMessage4"), false, GUIEditor.window[1])
				GUIEditor.button[3] = guiCreateButton(10, 127, 187, 39, loc("VIPMessage5"), false, GUIEditor.window[1])
				GUIEditor.button[4] = guiCreateButton(207, 29, 187, 39, loc("VIPMessage6"), false, GUIEditor.window[1])
				GUIEditor.button[5] = guiCreateButton(207, 78, 187, 39, loc("VIPMessage6"), false, GUIEditor.window[1])
				GUIEditor.button[6] = guiCreateButton(207, 127, 187, 39, loc("VIPMessage6"), false, GUIEditor.window[1])
				GUIEditor.memo[1] = guiCreateMemo(10, 176, 690, 232, "", false, GUIEditor.window[1])
				guiMemoSetReadOnly(GUIEditor.memo[1], true)
				GUIEditor.label[1] = guiCreateLabel(404, 29, 296, 137, loc("VIPMessage7"), false, GUIEditor.window[1])
				guiLabelSetHorizontalAlign(GUIEditor.label[1], "center", true)
				guiLabelSetVerticalAlign(GUIEditor.label[1], "center")
				setWindowDatas("set")
				VIP.open = true
				
				addEventHandler("onClientGUIClick",GUIEditor.button[1],function()
					triggerServerEvent("VIP.buy",localPlayer,10,"Bronze")
				end,false)
				addEventHandler("onClientGUIClick",GUIEditor.button[2],function()
					if(hasBronzePremium(localPlayer))then
						VIP.confirmBuy(15,"Silber","Bronze")
					else
						triggerServerEvent("VIP.buy",localPlayer,15,"Silber")
					end
				end,false)
				addEventHandler("onClientGUIClick",GUIEditor.button[3],function()
					if(hasBronzePremium(localPlayer))then
						VIP.confirmBuy(25,"Gold","Bronze")
					elseif(hasSilberPremium(localPlayer))then
						VIP.confirmBuy(25,"Gold","Silber")
					else
						triggerServerEvent("VIP.buy",localPlayer,25,"Gold")
					end
				end,false)
				addEventHandler("onClientGUIClick",GUIEditor.button[4],function() guiSetText(GUIEditor.memo[1],loc("VIPMessage8")) end,false)
				addEventHandler("onClientGUIClick",GUIEditor.button[5],function() guiSetText(GUIEditor.memo[1],loc("VIPMessage9")) end,false)
				addEventHandler("onClientGUIClick",GUIEditor.button[6],function() guiSetText(GUIEditor.memo[1],loc("VIPMessage10")) end,false)
			else infobox(loc("VIPMessage18"),125,0,0)end
		end
	end
end)

function hasBronzePremium(player)
	return tonumber(getElementData(player,"VIPBronzeZeit")) >= 1
end

function hasSilberPremium(player)
	return tonumber(getElementData(player,"VIPSilberZeit")) >= 1
end

function VIP.confirmBuy(kosten,type,oldType)
	GUIEditor.window[2] = guiCreateWindow(594, 390, 510, 160, loc("VIPMessage19"):format(oldType,type,oldType), false)
	centerWindow(GUIEditor.window[2],true)
	GUIEditor.label[2] = guiCreateLabel(10, 30, 490, 70, loc("VIPMessage20"):format(oldType,type,oldType), false, GUIEditor.window[2])
	guiSetFont(GUIEditor.label[2],"default-bold-small")
	guiLabelSetHorizontalAlign(GUIEditor.label[2],"center",true)
	guiLabelSetVerticalAlign(GUIEditor.label[2],"center")
	GUIEditor.button[7] = guiCreateButton(10, 115, 240, 35, loc("VIPMessage21"), false, GUIEditor.window[2])
	guiSetFont(GUIEditor.button[7],"default-bold-small")
	GUIEditor.button[8] = guiCreateButton(260, 115, 240, 35, loc("VIPMessage22"), false, GUIEditor.window[2])
	guiSetFont(GUIEditor.button[8],"default-bold-small")

	addEventHandler("onClientGUIClick",GUIEditor.button[7],function()
		destroyElement(GUIEditor.window[2])
		triggerServerEvent("VIP.buy",localPlayer,kosten,type)
	end,false)

	addEventHandler("onClientGUIClick",GUIEditor.button[8],function()
		destroyElement(GUIEditor.window[2])
	end,false)
end

--// Beschriftung über dem VIP-Teleporter
local vipX, vipY, vipZ = 259.87393188477, -15.097911834717, 2.0729942321777

addEventHandler("onClientRender", root, function()
	if(getElementData(localPlayer,"loggedin") ~= 1)then return end
	if(getElementInterior(localPlayer) ~= 0 or getElementDimension(localPlayer) ~= 0)then return end

	local px,py,pz = getElementPosition(localPlayer)
	local distance = getDistanceBetweenPoints3D(px,py,pz,vipX,vipY,vipZ)

	if(distance <= 5)then
		if(isWindowOpen())then
			local sx,sy = getScreenFromWorldPosition(vipX,vipY,vipZ+1.0)

			if(sx and sy)then
				dxDrawText(loc("VIPMessage25"),sx+1,sy+1,sx+1,sy+1,tocolor(0,0,0,255),1.15,"default-bold","center","center")
				dxDrawText(loc("VIPMessage25"),sx,sy,sx,sy,tocolor(232,185,35,255),1.15,"default-bold","center","center")
			end
		end
	end
end)
