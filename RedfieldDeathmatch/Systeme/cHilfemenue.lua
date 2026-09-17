Hilfemenue = { state = false,
	["Kategorien"] = {
		["DE"] = {"Lobbys","Befehle und Tastenkombinationen","Minispiele","VIP","Adminbefehle","Regelwerk"},
		["EN"] = {"Lobbies","Commands and keybinds","Minigames","VIP","Admin commands","Rules"},
	},
	["Texte"] = {
		["DE"] = {
			["Adminbefehle"] = "Ab Adminlevel 1 (Probe-Supporter):\n-/mypos - Derzeitige x, y, z Koordinaten ausgeben\n- /amute [Spieler], [Zeit in Min.], [Grund] - Einen Spieler muten\n- /akick [Spieler] - Einen Spieler kicken, [Grund]\n- /AChat [Text] - Interner Adminchat (Alternativ auch über 'U' nutzbar)\n- /OChat [Text] - Öffentlicher Adminchat (Alternativ auch über 'O' nutzbar)\n\nAb Adminlevel 2 (Supporter):\n- /endmute [Spieler] - Einen Spieler entmuten\n- /aban [Spieler], [Zeit in Std.], [Grund] - Einen Spieler bannen\n\nAb Adminlevel 3 (Moderator):\n- /aunban [Spieler] - Einen Spieler entbannen",
			["Minispiele"] = "Alle 30 Minuten wird zufällig ein Minispiel ausgewählt, bei welchem eine kleine Rechenaufgabe gelöst werden muss.\nDer erste, der die richtige Antwort in den Chat schreibt, gewinnt einen Geldbetrag. Zurzeit sind folgende Minispiele verfügbar:\n- Quersumme ausrechnen\n- Buchstaben-/Zahlensalat",
			["Befehle und Tastenkombinationen"] = "- F1 - Hilfemenü öffnen/schließen\n- /status [Text] - Seinen Status ändern (Aktiver VIP-Status benötigt)\n- b - Cursor anzeigen/ausblenden\n- F2 - Lobby-Einstellungen (Nur in eigenen Deagle- und Deathmatch-Lobbys möglich)\n- F3 - Coins kaufen\n- F4 - VIP-Status-Shop öffnen/schließen\n- /reddot - Rotpunktvisier aktivieren/deaktivieren\n- /leave - Derzeitige Lobby verlassen\n- /resetscore - Kills und Tode in der Tactics-Lobby zurücksetzen (Kosten: $Kills * 3 + (Tode * 5))\n- F5 - Achievements anzeigen/ausblenden\n- 'M' - Mapauswahl in der Tactics-Lobby öffnen/schließen (Ab VIP-Status Silber möglich)\n- /admins - Teammitglieder, die online sind, einsehen",
			["VIP"] = "Es gibt drei verschiedene VIP-Status. Bronze, Silber und Gold. Einen VIP-Status kann man sich mit Coins über F4 kaufen, wo man ebenfalls sieht, welche Vorteile der jeweilige VIP-Status bringt. Coins kann man über F3 erwerben.",
			["Lobbys"] = "Tactics Lobby:\nIn der Tactics-Lobby kämpfen die Angels of Death gegen die Yakuza auf verschiedenen Maps.\n\nDeagle Lobby:\nIn der Deagle-Lobby kämpft jeder gegen jeden – ausschließlich mit einer Desert Eagle.\nDu kannst außerdem eigene Deagle-Lobbys erstellen und individuell einstellen.\n\nDeathmatch Lobby:\nIn der Deathmatch-Lobby kämpft jeder gegen jeden.\nDu bist mit Desert Eagle, MP5, M4 und Rifle ausgerüstet und kannst außerdem eigene Deathmatch-Lobbys erstellen.",
			["Regelwerk"] = "/",
		},
		["EN"] = {
			["Admin commands"] = "From admin level 1 (Trial Supporter):\n- /mypos - Display your current x, y, z coordinates\n- /amute [Player], [Time in min.], [Reason] - Mute a player\n- /akick [Player], [Reason] - Kick a player\n- /AChat [Text] - Internal admin chat (Alternatively usable with 'U')\n- /OChat [Text] - Public admin chat (Alternatively usable with 'O')\n\nFrom admin level 2 (Supporter):\n- /endmute [Player] - Unmute a player\n- /aban [Player], [Time in hours], [Reason] - Ban a player\n\nFrom admin level 3 (Moderator):\n- /aunban [Player] - Unban a player",
			["Minigames"] = "Every 30 minutes, a minigame is selected at random in which a small task has to be solved.\nThe first player to type the correct answer in the chat wins a cash prize. The following minigames are currently available:\n- Calculate the digit sum\n- Letter/number combination",
			["Commands and keybinds"] = "- F1 - Open/close help menu\n- /status [Text] - Change your status (Active VIP status required)\n- b - Show/hide cursor\n- F2 - Lobby settings (Only available in your own Deagle and Deathmatch lobbies)\n- F3 - Buy Coins\n- F4 - Open/close VIP status shop\n- /reddot - Enable/disable red dot sight\n- /leave - Leave your current lobby\n- /resetscore - Reset kills and deaths in the Tactics lobby (Cost: $Kills * 3 + (Deaths * 5))\n- F5 - Show/hide achievements\n- 'M' - Open/close map selection in the Tactics lobby (Available from VIP status Silver)\n- /admins - View team members who are currently online",
			["VIP"] = "There are three different VIP statuses: Bronze, Silver and Gold. You can purchase VIP status with Coins via F4, where you can also see the benefits of each VIP status. Coins can be purchased via F3.",
			["Lobbies"] = "Tactics Lobby:\nIn the Tactics lobby, the Angels of Death fight against the Yakuza on various maps.\n\nDeagle Lobby:\nIn the Deagle lobby, everyone fights everyone – exclusively with a Desert Eagle.\nYou can also create your own Deagle lobbies and customize them individually.\n\nDeathmatch Lobby:\nIn the Deathmatch lobby, everyone fights everyone.\nYou are equipped with a Desert Eagle, MP5, M4 and Rifle and can also create your own Deathmatch lobbies.",
			["Rules"] = "/",
		},
	},
}

--// Fenster öffnen
bindKey("f1","down",function()
	if(Hilfemenue.state == true)then
		Hilfemenue.state = false
		setWindowDatas("reset")
	else
		if(isWindowOpen())then
			GUIEditor.window[1] = guiCreateWindow(681, 271, 652, 470, loc("HilfemenueMessage1"), false)
			Hilfemenue.state = true

			GUIEditor.gridlist[1] = guiCreateGridList(10, 28, 246, 432, false, GUIEditor.window[1])
			kategorie = guiGridListAddColumn(GUIEditor.gridlist[1], loc("HilfemenueMessage2"), 0.9)
			GUIEditor.label[1] = guiCreateLabel(266, 28, 376, 432, loc("HilfemenueMessage3"), false, GUIEditor.window[1])
			guiLabelSetHorizontalAlign(GUIEditor.label[1], "left", true)
			setWindowDatas("set")
			
			local Language = getElementData(localPlayer,"Sprache")
			for _,v in pairs(Hilfemenue["Kategorien"][Language])do
				local row = guiGridListAddRow(GUIEditor.gridlist[1])
				guiGridListSetItemText(GUIEditor.gridlist[1],row,kategorie,v,false,false)
			end
			
			addEventHandler("onClientGUIClick",GUIEditor.gridlist[1],function()
				local clicked = guiGridListGetItemText(GUIEditor.gridlist[1],guiGridListGetSelectedItem(GUIEditor.gridlist[1]),1)
				if(clicked ~= "")then
					guiSetText(GUIEditor.label[1],Hilfemenue["Texte"][Language][clicked])
				end
			end,false)
		end
	end
end)