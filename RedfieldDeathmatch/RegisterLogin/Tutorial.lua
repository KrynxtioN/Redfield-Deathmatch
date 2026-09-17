Tutorial = {
	active = false,
	step = 1,
	cameraStart = nil,
	cameraDuration = 2500,
	cameraMoving = false,
	fading = false
}

Tutorial.cameras = {
	{280.81619262695,-26.571378707886,9.8324718475342,203.19061279297,7.3142232894897,-43.327995300293,0,70},
	{266.60552978516,-32.451953887939,4.6032829284668,179.66296386719,-74.947074890137,-20.599000930786,0,70},
	{260.13354492188,-27.250904083252,3.2342529296875,164.03852844238,-28.094415664673,-24.425048828125,0,70},
	{263.86108398438,-22.193349838257,3.2897906303406,168.994140625,-26.654733657837,-28.020883560181,0,70},
	{263.75985717773,-20.041482925415,3.2897906303406,168.89291381836,-24.502866744995,-28.020883560181,0,70},
	{263.39352416992,-12.255730628967,3.2897906303406,167.40089416504,-16.770051956177,-24.369510650635,0,70}
}

Tutorial.ped = createPed(29,272.08966064453,-21.005041122437,2.0960216522217,56.698097229004)

setElementData(Tutorial.ped,"PedName","Tutorial Guide")
setElementData(Tutorial.ped,"PedEvent","Tutorial.start")
setElementFrozen(Tutorial.ped,true)

function Tutorial.drawPedInfo()
	if(Tutorial.active == false and isElement(Tutorial.ped) and isWindowOpen() and getElementDimension(localPlayer) == getElementDimension(Tutorial.ped))then
		local px,py,pz = getElementPosition(localPlayer)
		local pedX,pedY,pedZ = getElementPosition(Tutorial.ped)

		if(getDistanceBetweenPoints3D(px,py,pz,pedX,pedY,pedZ) <= 5)then
			local sx,sy = getScreenFromWorldPosition(pedX,pedY,pedZ+1.55)

			if(sx and sy)then
				dxDrawRectangle(sx-175,sy-28,350,56,tocolor(0,0,0,190),true)

				dxDrawRectangle(sx-165,sy-18,36,36,tocolor(58,98,242,255),true)
				dxDrawText("B",sx-165,sy-18,sx-129,sy+18,tocolor(255,255,255,255),1.00,"default-bold","center","center",false,false,true)

				dxDrawText(loc("TutorialMessage1"),sx-119,sy-20,sx+165,sy+20,tocolor(255,255,255,255),0.9,"default-bold","left","center",false,true,true)
			end
		end
	end
end
addEventHandler("onClientRender",root,Tutorial.drawPedInfo)

function Tutorial.start()
	if(Tutorial.active == true or Tutorial.fading == true)then
		return
	end

	if(not isElement(Tutorial.ped))then
		return
	end

	local px,py,pz = getElementPosition(localPlayer)
	local pedX,pedY,pedZ = getElementPosition(Tutorial.ped)

	if(getDistanceBetweenPoints3D(px,py,pz,pedX,pedY,pedZ) > 5)then
		return
	end

	Tutorial.active = true
	Tutorial.fading = true
	Tutorial.step = 1
	Tutorial.cameraMoving = false
	Tutorial.cameraStart = nil

	setElementData(localPlayer,"elementClicked",true)

	showCursor(false)
	showChat(false)

	setPlayerHudComponentVisible("radar",false)
	setPlayerHudComponentVisible("area_name",false)

	setElementFrozen(localPlayer,true)
	toggleAllControls(false)
	
	bindKey("space","down",Tutorial.next)

	fadeCamera(false,1.0)

	setTimer(function()
		if(Tutorial.active == false)then
			return
		end

		local camera = Tutorial.cameras[1]

		setCameraMatrix(camera[1],camera[2],camera[3],camera[4],camera[5],camera[6],camera[7],camera[8])
		addEventHandler("onClientRender",root,Tutorial.render)

		fadeCamera(true,1.0)

		setTimer(function()
			if(Tutorial.active == true)then
				Tutorial.fading = false
			end
		end,1000,1)
	end,1000,1)
end
addEvent("Tutorial.start",true)
addEventHandler("Tutorial.start",root,Tutorial.start)

function Tutorial.next()
	if(Tutorial.active == false)then
		return
	end

	if(Tutorial.fading == true)then
		return
	end

	if(Tutorial.cameraMoving == true)then
		return
	end

	if(Tutorial.step >= #Tutorial.cameras)then
		Tutorial.stop()
		return
	end

	Tutorial.fromCamera = Tutorial.cameras[Tutorial.step]
	Tutorial.step = Tutorial.step+1
	Tutorial.toCamera = Tutorial.cameras[Tutorial.step]

	Tutorial.cameraStart = getTickCount()
	Tutorial.cameraMoving = true
end

function Tutorial.render()
	if(Tutorial.cameraMoving == true)then
		local progress = (getTickCount()-Tutorial.cameraStart)/Tutorial.cameraDuration

		if(progress > 1)then
			progress = 1
		end

		local from = Tutorial.fromCamera
		local to = Tutorial.toCamera

		local cameraX,cameraY,cameraZ = interpolateBetween(from[1],from[2],from[3],to[1],to[2],to[3],progress,"InOutQuad")

		local lookX,lookY,lookZ = interpolateBetween(from[4],from[5],from[6],to[4],to[5],to[6],progress,"InOutQuad")

		local roll = interpolateBetween(from[7],0,0,to[7],0,0,progress,"InOutQuad")

		local fov = interpolateBetween(from[8],0,0,to[8],0,0,progress,"InOutQuad")

		setCameraMatrix(cameraX,cameraY,cameraZ,lookX,lookY,lookZ,roll,fov)

		if(progress >= 1)then
			Tutorial.cameraMoving = false
			setCameraMatrix(to[1],to[2],to[3],to[4],to[5],to[6],to[7],to[8])
		end
	end

	dxDrawRectangle(0*(x/1920),0*(y/1080),1920*(x/1920),89*(y/1080),tocolor(1,0,0,255),false)
	dxDrawRectangle(0*(x/1920),991*(y/1080),1920*(x/1920),89*(y/1080),tocolor(1,0,0,255),false)
	dxDrawText(loc("TutorialMessage2"),10*(x/1920),10*(y/1080),1910*(x/1920),79*(y/1080),tocolor(255,255,255,255),1.50*(y/1080),"default-bold","center","center",false,false,false,false,false)
	dxDrawText(loc("TutorialMessage"..(Tutorial.step+2)),250*(x/1920),900*(y/1080),1670*(x/1920),975*(y/1080),tocolor(255,255,255,255),1.20*(y/1080),"default-bold","center","center",false,true,false,false,false)
	dxDrawText(Tutorial.step.."/"..#Tutorial.cameras,40*(x/1920),1000*(y/1080),250*(x/1920),1070*(y/1080),tocolor(180,180,180,255),1.00*(y/1080),"default-bold","left","center",false,false,false,false,false)

	if(Tutorial.cameraMoving == false and Tutorial.fading == false)then
		local text = loc("TutorialMessage9")

		if(Tutorial.step >= #Tutorial.cameras)then
			text = loc("TutorialMessage10")
		end

		dxDrawText(text,1400*(x/1920),1000*(y/1080),1880*(x/1920),1070*(y/1080),tocolor(255,255,255,255),1.00*(y/1080),"default-bold","right","center",false,false,false,false,false)
	end
end

function Tutorial.stop()
	if(Tutorial.active == false or Tutorial.fading == true)then
		return
	end

	Tutorial.fading = true

	fadeCamera(false,1.0)

	setTimer(function()
		if(Tutorial.active == false)then
			return
		end

		removeEventHandler("onClientRender",root,Tutorial.render)

		Tutorial.active = false
		Tutorial.step = 1
		Tutorial.cameraStart = nil
		Tutorial.cameraMoving = false
		Tutorial.fromCamera = nil
		Tutorial.toCamera = nil

		setCameraTarget(localPlayer)

		setElementFrozen(localPlayer,false)
		toggleAllControls(true)

		showChat(true)

		setPlayerHudComponentVisible("radar",true)
		setPlayerHudComponentVisible("area_name",true)
		
		unbindKey("space","down",Tutorial.next)

		fadeCamera(true,1.0)

		setTimer(function()
			setElementData(localPlayer,"elementClicked",false)
			Tutorial.fading = false
		end,1000,1)
	end,1000,1)
end