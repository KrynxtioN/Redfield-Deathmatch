Hilfemenue = { state = false,
	["Kategorien"] = {
		["DE"] = {"Adminbefehle","Minispiele","Befehle und Tastenkombinationen","VIP"},
	},
	["Texte"] = {
		["DE"] = {
			["Adminbefehle"] = "Ab Adminlevel 1 (Probe-Supporter):\n- /amute [Spieler], [Zeit in Min.], [Grund] - Einen Spieler muten\n- /akick [Spieler] - Einen Spieler kicken, [Grund]\n- /AChat [Text] - Interner Adminchat (Alternativ auch über 'U' nutzbar)\n- /OChat [Text] - Öffentlicher Adminchat (Alternativ auch über 'O' nutzbar)\n\nAb Adminlevel 2 (Supporter):\n- /endmute [Spieler] - Einen Spieler entmuten\n- /aban [Spieler], [Zeit in Std.], [Grund] - Einen Spieler bannen\n\nAb Adminlevel 3 (Moderator):\n- /aunban [Spieler] - Einen Spieler entbannen",
			["Minispiele"] = "Alle 30 Minuten wird zufällig ein Minispiel ausgewählt, bei welchem eine kleine Rechenaufgabe gelöst werden muss.\nDer erste, der die richtige Antwort in den Chat schreibt, gewinnt einen Geldbetrag. Zurzeit sind folgende Minispiele verfügbar:\n- Quersumme ausrechnen",
			["Befehle und Tastenkombinationen"] = "- F1 - Hilfemenü öffnen/schließen\n- /status [Text] - Seinen Status ändern\n- b - Cursor anzeigen/ausblenden\n- F2 - Lobby-Einstellungen\n- F3 - Coins kaufen\n- F4 - VIP-Status-Shop öffnen/schließen\n- /reddot - Rotpunktvisier aktivieren/deaktivieren\n- /leave - Derzeitige Lobby verlassen\n- /resetscore - Kills und Tode in der Tactics-Lobby zurücksetzen\n- F5 - Achievements anzeigen/ausblenden\n- 'M' - Mapauswahl in der Tactics-Lobby öffnen/schließen (Ab Premium Silber möglich)",
			["VIP"] = "Es gibt drei verschiedene VIP-Status Bronze, Silber und Gold. Einen VIP-Status kann man sich mit Coins über F4 kaufen, wo man ebenfalls sieht, welche Vorteile der jeweilige VIP-Status bringt. Coins kann man über F3 erwerben.",
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