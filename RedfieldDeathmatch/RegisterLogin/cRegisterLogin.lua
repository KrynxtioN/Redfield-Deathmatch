RegisterLogin = {text = nil, type = nil, passwordVisible = false, cameraStart = nil,
	["Sprachen"] = {
		["DE"] = true,
		["EN"] = true,
	},
}
setElementData(localPlayer,"Sprache","EN")
fadeCamera(true)
setElementDimension(localPlayer,0)
setElementInterior(localPlayer,0)
clearChatBox()
setElementData(localPlayer,"loggedin",0)

--// Register/Login erstellen
function RegisterLogin.dxDraw()
	if(RegisterLogin.cameraStart)then
		local elapsed = getTickCount()-RegisterLogin.cameraStart
		local movement = math.sin(elapsed/4500)*12
		local height = math.sin(elapsed/6000)*2
		setCameraMatrix(338.16870117188+movement,-1995.6628417969,22.10756111145+height,401.01724243164,-2071.3950195313,4.3680448532104)
	end
	dxDrawRectangle(0*(x/1920), 0*(y/1080), 1920*(x/1920), 89*(y/1080), tocolor(1, 0, 0, 255), false)
    dxDrawRectangle(0*(x/1920), 991*(y/1080), 1920*(x/1920), 89*(y/1080), tocolor(1, 0, 0, 255), false)
    dxDrawText(Serverinfos.name.." "..Serverinfos.version, 10*(x/1920), 10*(y/1080), 1910*(x/1920), 79*(y/1080), tocolor(255, 255, 255, 255), 1.50*(y/1080), "default", "center", "center", false, false, false, false, false)
    dxDrawRectangle(705*(x/1920), 409*(y/1080), 511*(x/1920), 263*(y/1080), tocolor(0, 0, 0, 200), false)
    dxDrawRectangle(705*(x/1920), 409*(y/1080), 511*(x/1920), 40*(y/1080), tocolor(58, 98, 242, 200), false)
    dxDrawText(RegisterLogin.secondText, 715*(x/1920), 459*(y/1080), 1206*(x/1920), 503*(y/1080), tocolor(255, 255, 255, 255), 1.00, "arial", "center", "center", false, true, false, false, false)
    dxDrawText(loc("RegisterLoginMessage10"), 705*(x/1920), 409*(y/1080), 1216*(x/1920), 449*(y/1080), tocolor(255, 255, 255, 255), 1.20*(y/1080), "default-bold", "center", "center", false, true, false, false, false)
    dxDrawText(loc("RegisterLoginMessage11"), 715*(x/1920), 513*(y/1080), 781*(x/1920), 541*(y/1080), tocolor(255, 255, 255, 255), 1.00*(y/1080), "arial", "left", "center", false, true, false, false, false)
    dxDrawText(loc("RegisterLoginMessage12"), 715*(x/1920), 551*(y/1080), 781*(x/1920), 579*(y/1080), tocolor(255, 255, 255, 255), 1.00*(y/1080), "arial", "left", "center", false, true, false, false, false)
	
    -- Serverinformation
    dxDrawRectangle(1231*(x/1920), 409*(y/1080), 300*(x/1920), 180*(y/1080), tocolor(0, 0, 0, 200), false)
    dxDrawRectangle(1231*(x/1920), 409*(y/1080), 300*(x/1920), 40*(y/1080), tocolor(58, 98, 242, 200), false)
    dxDrawText(loc("RegisterLoginMessage20"), 1241*(x/1920), 409*(y/1080), 1521*(x/1920), 449*(y/1080), tocolor(255,255,255,255), 1.2*(y/1080), "default-bold", "center", "center", false, false, false, false, false)
    dxDrawText(loc("RegisterLoginMessage21"), 1246*(x/1920), 459*(y/1080), 1516*(x/1920), 579*(y/1080), tocolor(255,255,255,255), 1.00*(y/1080), "arial", "left", "top", false, true, false, false, false)

	-- Sprachauswahl
	local deAlpha = RegisterLogin.Sprachen["DE"] and 255 or 80
	local enAlpha = RegisterLogin.Sprachen["EN"] and 255 or 80

	dxDrawImage(1246*(x/1920), 599*(y/1080), 50*(x/1920), 30*(y/1080), "Files/Images/Germany.png", 0, 0, 0, tocolor(255,255,255,deAlpha), false)
	dxDrawImage(1306*(x/1920), 599*(y/1080), 50*(x/1920), 30*(y/1080), "Files/Images/UK.png", 0, 0, 0, tocolor(255,255,255,enAlpha), false)

	if(getElementData(localPlayer,"Sprache") == "DE")then
		dxDrawRectangle(1244*(x/1920), 597*(y/1080), 54*(x/1920), 34*(y/1080), tocolor(58,98,242,180), false)
		dxDrawImage(1246*(x/1920), 599*(y/1080), 50*(x/1920), 30*(y/1080), "Files/Images/Germany.png", 0, 0, 0, tocolor(255,255,255,deAlpha), false)
	elseif(getElementData(localPlayer,"Sprache") == "EN")then
		dxDrawRectangle(1304*(x/1920), 597*(y/1080), 54*(x/1920), 34*(y/1080), tocolor(58,98,242,180), false)
		dxDrawImage(1306*(x/1920), 599*(y/1080), 50*(x/1920), 30*(y/1080), "Files/Images/UK.png", 0, 0, 0, tocolor(255,255,255,enAlpha), false)
	end

	if(RegisterLogin.type == "Registrieren")then
		dxDrawText("Bestätigen", 715*(x/1920), 589*(y/1080), 781*(x/1920), 617*(y/1080), tocolor(255, 255, 255, 255), 1.00*(y/1080), "arial", "left", "center", false, true, false, false, false)
	end

	-- Auge Icon
	local eyeX, eyeY = 1189*(x/1920), 565*(y/1080)
	local eyeW, eyeH = 9*(x/1920), 6*(y/1080)
	dxDrawLine(eyeX-eyeW, eyeY, eyeX, eyeY-eyeH, tocolor(255,255,255,255), 2*(y/1080), false)
	dxDrawLine(eyeX, eyeY-eyeH, eyeX+eyeW, eyeY, tocolor(255,255,255,255), 2*(y/1080), false)
	dxDrawLine(eyeX-eyeW, eyeY, eyeX, eyeY+eyeH, tocolor(255,255,255,255), 2*(y/1080), false)
	dxDrawLine(eyeX, eyeY+eyeH, eyeX+eyeW, eyeY, tocolor(255,255,255,255), 2*(y/1080), false)
	dxDrawCircle(eyeX, eyeY, 2.5*(y/1080), 0, 360, tocolor(255,255,255,255), tocolor(255,255,255,255), 16, 1, false)
end

addEvent("RegisterLogin.createWindow",true)
addEventHandler("RegisterLogin.createWindow",root,function(type)
	showChat(false)
	setCameraMatrix(338.16870117188,-1995.6628417969,22.10756111145,401.01724243164,-2071.3950195313,4.3680448532104)
	RegisterLogin.cameraStart = getTickCount()
	RegisterLogin.type = type
	RegisterLogin.passwordVisible = false
	RegisterLogin.text = type
	setElementData(localPlayer,"elementClicked",true)
	if(type == "Registrieren")then
		RegisterLogin.secondText = loc("RegisterLoginMessage9")
		if(getElementData(localPlayer,"Sprache") == "EN")then
			RegisterLogin.text = "Register"
		end
	elseif(type == "Einloggen")then
		RegisterLogin.secondText = loc("RegisterLoginMessage8")
		if(getElementData(localPlayer,"Sprache") == "EN")then
			RegisterLogin.text = "Login"
		end
	end
	setWindowDatas("set")
	addEventHandler("onClientRender",root,RegisterLogin.dxDraw)
	Elements.edit[1] = Edit:create(791, 513, 415, 28,1920,1080,getPlayerName(localPlayer))
	Elements.edit[1].editActiv = false
	Elements.edit[2] = Edit:create(791, 551, 377, 28,1920,1080,"",true)
	if(type == "Registrieren")then
		Elements.edit[3] = Edit:create(791, 589, 415, 28,1920,1080,"",true)
	end
	Elements.button[1] = Button:create(715, 634, 491, 28,1920,1080,RegisterLogin.text,"RegisterLogin.triggerToServer")
	Elements.button[2] = Button:create(1175, 551, 31, 28,1920,1080,"","RegisterLogin.togglePassword")
	setPlayerHudComponentVisible("radar",false)
	setPlayerHudComponentVisible("area_name",false)
	addEventHandler("onClientClick",root,RegisterLogin.clickLanguage)
end)

--// Sprache ändern
function RegisterLogin.clickLanguage(button,state,absoluteX,absoluteY)
	if(button == "left" and state == "down")then
		local deX,deY,deW,deH = 1246*(x/1920),599*(y/1080),50*(x/1920),30*(y/1080)
		local enX,enY,enW,enH = 1306*(x/1920),599*(y/1080),50*(x/1920),30*(y/1080)

		if(absoluteX >= deX and absoluteX <= deX+deW and absoluteY >= deY and absoluteY <= deY+deH)then
			if(RegisterLogin.Sprachen["DE"])then
				RegisterLogin.changeLanguage("DE")
			end
		elseif(absoluteX >= enX and absoluteX <= enX+enW and absoluteY >= enY and absoluteY <= enY+enH)then
			if(RegisterLogin.Sprachen["EN"])then
				RegisterLogin.changeLanguage("EN")
			end
		end
	end
end

function RegisterLogin.changeLanguage(language)
	setElementData(localPlayer,"Sprache",language)

	if(RegisterLogin.type == "Registrieren")then
		RegisterLogin.secondText = loc("RegisterLoginMessage9")
		if(language == "EN")then
			RegisterLogin.text = "Register"
		else
			RegisterLogin.text = "Registrieren"
		end
	elseif(RegisterLogin.type == "Einloggen")then
		RegisterLogin.secondText = loc("RegisterLoginMessage8")
		if(language == "EN")then
			RegisterLogin.text = "Login"
		else
			RegisterLogin.text = "Einloggen"
		end
	end

	if(Elements.button[1])then
		Elements.button[1]:destroy()
		Elements.button[1] = Button:create(715, 634, 491, 28,1920,1080,RegisterLogin.text,"RegisterLogin.triggerToServer")
	end
end

addEvent("RegisterLogin.togglePassword",true)
addEventHandler("RegisterLogin.togglePassword",root,function()
	local passwort = Elements.edit[2]:getText()
	local passwortBestaetigen = nil
	
	if(Elements.edit[3])then
		passwortBestaetigen = Elements.edit[3]:getText()
	end
	
	RegisterLogin.passwordVisible = not RegisterLogin.passwordVisible
	
	Elements.edit[2]:destroy()
	Elements.edit[2] = Edit:create(791, 551, 377, 28,1920,1080,passwort,not RegisterLogin.passwordVisible)
	
	if(Elements.edit[3])then
		Elements.edit[3]:destroy()
		Elements.edit[3] = Edit:create(791, 589, 415, 28,1920,1080,passwortBestaetigen,not RegisterLogin.passwordVisible)
	end
end)

addEvent("RegisterLogin.triggerToServer",true)
addEventHandler("RegisterLogin.triggerToServer",root,function()
	local passwort = Elements.edit[2]:getText()
	if(RegisterLogin.type == "Registrieren" and Elements.edit[3] and passwort ~= Elements.edit[3]:getText())then
		infobox("Die Passwörter stimmen nicht überein.",125,0,0)
		return
	end
	if(#passwort >= 6)then
		triggerServerEvent("RegisterLogin.server",localPlayer,RegisterLogin.text,passwort)
	else infobox(loc("RegisterLoginMessage13"),125,0,0)end
end)

--// Register/Login zerstören
addEvent("RegisterLogin.destroy",true)
addEventHandler("RegisterLogin.destroy",root,function()
	if(Elements.edit[1])then
		Elements.edit[1]:destroy()
		Elements.edit[2]:destroy()
		if(Elements.edit[3])then Elements.edit[3]:destroy() Elements.edit[3] = nil end
		Elements.button[1]:destroy()
		if(Elements.button[2])then Elements.button[2]:destroy() Elements.button[2] = nil end
		removeEventHandler("onClientRender",root,RegisterLogin.dxDraw)
	end
	removeEventHandler("onClientClick",root,RegisterLogin.clickLanguage)
	RegisterLogin.cameraStart = nil
	setWindowDatas("reset")
	showChat(true)
	setPlayerHudComponentVisible("radar",true)
end)

triggerServerEvent("RegisterLogin.checkAccount",localPlayer)