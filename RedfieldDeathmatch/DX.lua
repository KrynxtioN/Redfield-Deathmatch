Elements = {edit = {}, button = {}}
Edit = {} Button = {}

--// Edits
function Edit:create(x,y,w,h,gx,gy,text,password)
	if(not(text))then text = "" end
	local self = setmetatable({},{__index = self})
	self.x = x self.y = y self.w = w self.h = h
	self.text = text
	self.active = false
	self.shiftactive = false
	self.editActiv = true
	self.gx = gx self.gy = gy
	self.render = function() self:onRender() end
	self.click = function(button,state) self:onClick(button,state) end
	self.shift = function(key,state) self:onShift(key,state) end
	self.passwordType = false
	if(password)then self.passwordType = true end
	bindKey("lshift","both",self.shift)
	bindKey("rshift","both",self.shift)
	addEventHandler("onClientRender",root,self.render)
	addEventHandler("onClientClick",root,self.click)
	return self
end

function Edit:destroy()
	removeEventHandler("onClientRender",root,self.render)
	removeEventHandler("onClientClick",root,self.click)
	unbindKey("lshift","both",self.shift)
	unbindKey("rshift","both",self.shift)
	if(Edit.backspaceEdit == self)then
		if(isTimer(Edit.backspaceTimer))then killTimer(Edit.backspaceTimer)end
		Edit.backspaceTimer = nil
		Edit.backspaceEdit = nil
	end
	self = nil
end

function Edit:onRender()
	dxDrawRectangle(self.x*(x/self.gx),self.y*(y/self.gy),self.w*(x/self.gx),self.h*(y/self.gy),tocolor(220,220,220,255),true) -- Main Rectangle
	local drawText = self.text
	if(self.passwordType == true)then
		drawText = ""
		for i = 1,#self.text do drawText = drawText.."*" end
		dxDrawText(drawText,self.x*(x/self.gx),self.y*(y/self.gy),(self.x+self.w)*(x/self.gx),(self.y+self.h)*(y/self.gy),tocolor(0,0,0,255),1.00*(y/self.gy),"default-bold","left","center",_,_,true) -- Text
	else
		dxDrawText(" "..drawText,self.x*(x/self.gx),self.y*(y/self.gy),(self.x+self.w)*(x/self.gx),(self.y+self.h)*(y/self.gy),tocolor(0,0,0,255),1.00*(y/self.gy),"default-bold","left","center",_,_,true) -- Text
	end
	if(self.active == true)then
		dxDrawLine(self.x*(x/self.gx),self.y*(y/self.gy),(self.x+self.w-1)*(x/self.gx),self.y*(y/self.gy),tocolor(58,98,242,255),2,true) -- Line oben
		dxDrawLine(self.x*(x/self.gx),(self.y+self.h)*(y/self.gy),(self.x+self.w)*(x/self.gx),(self.y+self.h)*(y/self.gy),tocolor(58,98,242,255),2,true) -- Line unten
		dxDrawLine(self.x*(x/self.gx),self.y*(y/self.gy),self.x*(x/self.gx),(self.y+self.h)*(y/self.gy),tocolor(58,98,242,255),2,true) -- Line links
		dxDrawLine((self.x+self.w)*(x/self.gx),self.y*(y/self.gy),(self.x+self.w)*(x/self.gx),(self.y+self.h-0)*(y/self.gy),tocolor(58,98,242,255),2,true) -- Line rechts

		if(getTickCount()%1000 < 500)then
			local prefix = ""
			if(self.passwordType ~= true)then prefix = " " end
			local textWidth = dxGetTextWidth(prefix..drawText,1.00*(y/self.gy),"default-bold")
			local cursorX = self.x*(x/self.gx)+textWidth
			local maxCursorX = (self.x+self.w-4)*(x/self.gx)
			if(cursorX > maxCursorX)then cursorX = maxCursorX end
			dxDrawLine(cursorX,(self.y+5)*(y/self.gy),cursorX,(self.y+self.h-5)*(y/self.gy),tocolor(0,0,0,255),1,true)
		end
	end
end

function Edit:onClick(button,state)
	if(button == "left" and state == "down")then
		if(isCursorOnElement(self.x*(x/self.gx),self.y*(y/self.gy),self.w*(x/self.gx),self.h*(y/self.gy)))then
			self.active = true
		else
			self.active = false
		end
	end
end

NotAllowedKeys = {"mouse1","mouse2","mouse3","mouse4","mouse5","mouse_wheel_up","mouse_wheel_down","arrow_l","arrow_u","arrow_r","arrow_D","num_0","num_1","num_2","num_3","num_4","num_5","num_6","num_7","num_8","num_9","num_mul","num_add","num_sep","num_sub","num_div","num_dec","num_enter","F1","F2","F3","F4","F5","F6","F7","F8","F9","F10","F11","F12","escape","tab","lalt","ralt","enter","pgup","pgdn","end","home","insert","delete","lctrl","rctrl","[","]","pause","capslock","scroll","lshift","rshift", "-", ".", "+", "*", "/", "%"}
SpecialKeys = {["1"] = "!",["2"] = '"',["3"] = "§",["4"] = "$",["5"] = "%",["6"] = "&",["7"] = "/",["8"] = "(",["9"] = ")",["0"] = "="}

function Edit.deleteLastCharacter(edit)
	if(edit and edit.editActiv == true and edit.active == true and #edit.text > 0)then
		edit.text = string.sub(edit.text,1,#edit.text-1)
	end
end

function EditInput(key,press)
	if(#Elements.edit >= 1)then
		local edit = nil
		for _,v in pairs(Elements.edit)do
			if(v.active == true)then
				edit = v
				break
			end
		end

		if(key == "backspace")then
			if(press)then
				if(edit and edit.editActiv == true)then
					Edit.deleteLastCharacter(edit)

					if(isTimer(Edit.backspaceTimer))then killTimer(Edit.backspaceTimer)end
					Edit.backspaceEdit = edit
					Edit.backspaceTimer = setTimer(function()
						if(Edit.backspaceEdit and Edit.backspaceEdit.active == true and Edit.backspaceEdit.editActiv == true and getKeyState("backspace"))then
							Edit.deleteLastCharacter(Edit.backspaceEdit)
						else
							if(isTimer(Edit.backspaceTimer))then killTimer(Edit.backspaceTimer)end
							Edit.backspaceTimer = nil
							Edit.backspaceEdit = nil
						end
					end,60,0)
				end
			else
				if(isTimer(Edit.backspaceTimer))then killTimer(Edit.backspaceTimer)end
				Edit.backspaceTimer = nil
				Edit.backspaceEdit = nil
			end
			return
		end

		if(press)then
			if(edit and edit.editActiv == true)then
				local state = true
				for _,v in pairs(NotAllowedKeys)do
					if(key == v)then
						state = false
						break
					end
				end
				if(state == true)then
					if(key == "space")then
						edit.text = edit.text.." "
					else
						if(edit.shiftactive == true)then
							if(SpecialKeys[key])then
								key = SpecialKeys[key]
							else
								key = string.upper(key)
							end
						end
						edit.text = edit.text..key
					end
				end
			end
		end
	end
end
addEventHandler("onClientKey",root,EditInput)

function Edit:onShift(key,state)
	if(self.active == true)then
		if(state == "down")then
			self.shiftactive = true
		else
			self.shiftactive = false
		end
	end
end

function Edit:getText() return self.text end

--// Buttons
function Button:create(x,y,w,h,gx,gy,title,callfunc)
	local self = setmetatable({},{__index = self})
	self.x = x self.y = y self.w = w self.h = h
	self.r = 58 self.g = 98 self.b = 242
	self.title = title
	self.callfunc = callfunc
	self.gx = gx self.gy = gy
	self.render = function() self:onRender() end
	self.click = function(button,state) self:onClick(button,state) end
	addEventHandler("onClientRender",root,self.render)
	addEventHandler("onClientClick",root,self.click)
	return self
end

function Button:onRender()
	dxDrawRectangle(self.x*(x/self.gx),self.y*(y/self.gy),self.w*(x/self.gx),self.h*(y/self.gy),tocolor(self.r,self.g,self.b,175),true) -- Main rectangle
	dxDrawText(self.title,self.x*(x/self.gx),self.y*(y/self.gy),(self.x+self.w)*(x/self.gx),(self.y+self.h)*(y/self.gy),tocolor(255,255,255,255),1.00*(y/self.gy),"default-bold","center","center",_,_,true) -- Title

	if(isCursorOnElement(self.x*(x/self.gx),self.y*(y/self.gy),self.w*(x/self.gx),self.h*(y/self.gy)))then self.r = 51 self.g = 86 self.b = 212 else self.r = 0 self.g = 0 self.b = 0 end
end

function Button:onClick(button,state)
	if(button == "left" and state == "down")then
		if(isCursorOnElement(self.x*(x/self.gx),self.y*(y/self.gy),self.w*(x/self.gx),self.h*(y/self.gy)))then
			triggerEvent(self.callfunc,localPlayer)
		end
	end
end

function Button:destroy()
	removeEventHandler("onClientRender",root,self.render)
	removeEventHandler("onClientClick",root,self.click)
	self = nil
end