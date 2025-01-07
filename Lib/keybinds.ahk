#Include %A_ScriptDir%\Macro.ahk

global hotkeyKeybind1 := "F1"
global hotkeyKeybind2 := "F2"
global hotkeyKeybind3 := "F3"

OpenKeybinds() {
    keybindsGui.Show("w280 h180")
}

keybindsGui := Gui("+AlwaysOnTop")
keybindsGui.Add("Text", "x10 y10 w100", "Resize roblox:")
hotkey1 := keybindsGui.Add("Hotkey", "x120 y10 w150", hotkeyKeybind1)

keybindsGui.Add("Text", "x10 y50 w100", "Start macro:")
hotkey2 := keybindsGui.Add("Hotkey", "x120 y50 w150", hotkeyKeybind2)

keybindsGui.Add("Text", "x10 y90 w100", "Stop macro:")
hotkey3 := keybindsGui.Add("Hotkey", "x120 y90 w150", hotkeyKeybind3)

saveButton := keybindsGui.Add("Button", "x10 y130 w260", "Save Keybinds")
saveButton.OnEvent('Click', SaveConfig)