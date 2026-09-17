--// Fenster öffnen
bindKey("f3","down",function()
	if(getElementData(localPlayer,"loggedin") == 1 and isWindowOpen())then
        GUIEditor.window[1] = guiCreateWindow(976, 192, 468, 250, "Coins", false)

        GUIEditor.label[1] = guiCreateLabel(10, 27, 448, 70, loc("GDMCoinsMessage1"), false, GUIEditor.window[1])
		guiLabelSetHorizontalAlign(GUIEditor.label[1], "center", true)

		GUIEditor.label[2] = guiCreateLabel(10, 105, 100, 25, loc("GDMCoinsMessage6"), false, GUIEditor.window[1])
		guiLabelSetVerticalAlign(GUIEditor.label[2], "center")
		
        GUIEditor.edit[1] = guiCreateEdit(110, 105, 348, 25, "", false, GUIEditor.window[1])
		guiEditSetMaxLength(GUIEditor.edit[1], 6)

		GUIEditor.label[3] = guiCreateLabel(10, 140, 448, 35, loc("GDMCoinsMessage7"):format(0), false, GUIEditor.window[1])
		guiLabelSetHorizontalAlign(GUIEditor.label[3], "center", true)
		guiLabelSetVerticalAlign(GUIEditor.label[3], "center")

        GUIEditor.button[1] = guiCreateButton(10, 216, 219, 24, loc("GDMCoinsMessage2"), false, GUIEditor.window[1])
        GUIEditor.button[2] = guiCreateButton(240, 216, 218, 24, loc("GDMCoinsMessage3"), false, GUIEditor.window[1])   
		setWindowDatas("set")

		addEventHandler("onClientGUIChanged",GUIEditor.edit[1],function()
			local coins = tonumber(guiGetText(source)) or 0
			coins = math.floor(coins)
			if(coins < 0)then coins = 0 end
			guiSetText(GUIEditor.label[3],loc("GDMCoinsMessage7"):format(coins*5000))
		end,false)
		
		addEventHandler("onClientGUIClick",GUIEditor.button[1],function()
			local coins = tonumber(guiGetText(GUIEditor.edit[1]))
			if(coins and coins > 0 and coins == math.floor(coins))then
				triggerServerEvent("BuyCoins.server",localPlayer,coins)
			end
		end,false)
		
		addEventHandler("onClientGUIClick",GUIEditor.button[2],function()
			setWindowDatas("reset")
		end,false)
    end
end)