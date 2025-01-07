#Include %A_ScriptDir%\Lib\config.ahk

SaveChoiceGui := Gui("+Border +AlwaysOnTop")

SaveChoiceGui.Add("Text", "Center", "Choose Save Location:")
Button := SaveChoiceGui.Add("Button", "w100 h30 vbtnGlobal", "Global")
Button2 := SaveChoiceGui.Add("Button", "w100 h30 vbtnLocal", "Local")

Button.OnEvent('Click', SaveGlobal)
Button2.OnEvent('Click', SaveLocal)

LoadChoiceGui := Gui("+AlwaysOnTop +Border")

LoadChoiceGui.Add("Text", "Center", "Choose Load Location:")
Button := LoadChoiceGui.Add("Button", "w100 h30 vbtnGlobal", "Global")
Button2 := LoadChoiceGui.Add("Button", "w100 h30 vbtnLocal", "Local")

Button.OnEvent('Click', LoadGlobal)
Button2.OnEvent('Click', LoadLocal)