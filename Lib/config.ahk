#Include %A_ScriptDir%\Lib\gui.ahk
#Include %A_ScriptDir%\Lib\configgui.ahk
#Include %A_ScriptDir%\Macro.ahk
#Include %A_ScriptDir%\Lib\PriorityPicker.ahk
#Include %A_ScriptDir%\Lib\keybinds.ahk

SaveConfig(*) {
    global enabled1, enabled2, enabled3, enabled4, enabled5, enabled6
    global placement1, placement2, placement3, placement4, placement5, placement6

    SaveChoiceGui.Show("AutoSize Center")
    return
}

LoadConfig(*) {
    global enabled1, enabled2, enabled3, enabled4, enabled5, enabled6
    global placement1, placement2, placement3, placement4, placement5, placement6

    LoadChoiceGui.Show("AutoSize Center")
    return
}

GuiClose() {
    LoadChoiceGui.Hide()
    SaveChoiceGui.Hide()
    keybindsGui.Hide()
}

StringJoin(delimiter, arr) {
    result := ""
    for index, value in arr {
        if (result != "")
            result .= delimiter
        result .= value
    }
    return result
}

SaveConfigToFile(filePath) {
    global hotkey1, hotkey2, hotkey3, AutoUpdate, PlacementDropdown
    directory := "Lib\Settings"

    if !DirExist(directory) {
        DirCreate(directory)
    }
    if !FileExist(filePath) {
        FileAppend("", filePath)
    }

    File := FileOpen(filePath, "w")
    if !File {
        AddToLog("Failed to save the configuration.")
        return
    }

    if (hotkey1.Value == "" or hotkey2.Value == "" or hotkey3.Value == "") {
        AddToLog("One of the keybinds is empty. Please change it.")
        return
    }

    if (hotkey1.Value == hotkey2.Value || hotkey1.Value == hotkey3.Value || hotkey2.Value == hotkey3.Value) {
        AddToLog("Duplicate keybinds detected. Please assign unique keys to each function.")
        return
    }

    File.WriteLine("[Config]")
    File.WriteLine("Enabled1=" enabled1.Value)
    File.WriteLine("Enabled2=" enabled2.Value)
    File.WriteLine("Enabled3=" enabled3.Value)
    File.WriteLine("Enabled4=" enabled4.Value)
    File.WriteLine("Enabled5=" enabled5.Value)
    File.WriteLine("Enabled6=" enabled6.Value)

    File.WriteLine("Placement1=" placement1.Text)
    File.WriteLine("Placement2=" placement2.Text)
    File.WriteLine("Placement3=" placement3.Text)
    File.WriteLine("Placement4=" placement4.Text)
    File.WriteLine("Placement5=" placement5.Text)
    File.WriteLine("Placement6=" placement6.Text)

    File.WriteLine("[CardPriority]")
    for index, dropDown in dropDowns {
        File.WriteLine(Format("Enabled{}={}", index + 1, dropDown.Value))
    }
    File.WriteLine("CardEnabled=" CardPicker.Value)

    File.WriteLine("[ChatSettings]")
    File.WriteLine("MessageToSend=" ChatToSend.Value)
    File.WriteLine("ChatEnabled=" ChatStatusBox.Value)

    File.WriteLine("[WebhookSettings]")
    File.WriteLine("WebhookURL=" WebhookURL.Value)
    File.WriteLine("WebhookEnabled=" WebhookCheckbox.Value)
    File.WriteLine("DCIEnabled=" DisconnectCheckbox.Value)

    File.WriteLine("[Keybinds]")
    File.WriteLine("Hotkey1=" hotkey1.Value)
    File.WriteLine("Hotkey2=" hotkey2.Value)
    File.WriteLine("Hotkey3=" hotkey3.Value)

    File.WriteLine("[UnitPriority]")
    For index, value in unitPriorityOrder {
        File.WriteLine("UnitPriorityOrder" . index + 1 . "=" . value)
    }
    File.WriteLine("UUPEnabled=" UUPCheckbox.Value)

    File.WriteLine("[Update]")
    File.WriteLine("AutoUpdateEnabled=" AutoUpdate.Value)

    File.WriteLine("[PlacementLogic]")
    File.WriteLine("Logic=" PlacementDropdown.Value)

    File.Close()
    AddToLog("Configuration saved successfully to " filePath ".`nIf you changed keybinds, you will have to restart the macro.`n")
}

LoadConfigFromFile(filePath) {
    global enabled1, enabled2, enabled3, enabled4, enabled5, enabled6
    global placement1, placement2, placement3, placement4, placement5, placement6
    global dropDowns, ChatToSend, ChatStatusBox, WebhookURL, WebhookCheckbox, DisconnectCheckbox, UUPCheckbox
    global hotkey1, hotkey2, hotkey3
    global CardPicker, PlacementDropdown

    if !FileExist(filePath) {
        AddToLog("No configuration file found. Default settings will be used.")
        Hotkey("F1", (*) => SetupMacro())
        Hotkey("F2", (*) => InitializeMacro())
        Hotkey("F3", (*) => StopMacro())

        KeyBinds.Text := "F1 - Fix Roblox Position `n F2 - Start Macro `n F3 - Stop Macro"
        global autoUpdateEnabled := 1
        AutoUpdate.Value := 1
        PlacementDropdown.Value := 1
    } else {
        ; Open file for reading
        file := FileOpen(filePath, "r", "UTF-8")
        if !file {
            AddToLog("Failed to load the configuration.")
            return
        }

        section := ""
        ; Read settings from the file
        while !file.AtEOF {
            line := file.ReadLine()

            ; Detect section headers
            if RegExMatch(line, "^\[(.*)\]$", &match) {
                section := match.1
                continue
            }

            ; Process the lines based on the section
            if (section = "Config") {
                if RegExMatch(line, "Enabled(\d)=(\d+)", &match) {
                    slot := match.1
                    value := match.2
                    enabledgui := "Enabled" slot
                    enabledgui := %enabledgui%
                    enabledgui.Value := value ; Set checkbox value
                }
                if RegExMatch(line, "Placement(\d)=(\d+)", &match) {
                    slot := match.1
                    value := match.2
                    placementgui := "Placement" slot
                    placementgui := %placementgui%
                    placementgui.Text := value ; Set dropdown value
                }
            }
            else if (section = "CardPriority") {
                if RegExMatch(line, "Enabled(\d+)=(\d+)", &match) {
                    slot := match.1
                    value := match.2
                    dropDown := dropDowns[slot - 1]
                    if (dropDown) {
                        dropDown.Value := value
                    }
                }
                else if RegExMatch(line, "CardEnabled=(\d+)", &match) {
                    global cardPickerEnabled := match.1
                    CardPicker.Value := cardPickerEnabled
                }
            }
            else if (section = "ChatSettings") {
                if RegExMatch(line, "MessageToSend=(.+)", &match) {
                    ChatToSend.Value := match.1 ; Set the chat message
                }
                if RegExMatch(line, "ChatEnabled=(\d+)", &match) {
                    ChatStatusBox.Value := match.1 ; Set the checkbox value
                }
            }
            else if (section = "WebhookSettings") {
                if RegExMatch(line, "WebhookURL=(.+)", &match) {
                    WebhookURL.Value := match.1 ; Set the webhook URL
                }
                if RegExMatch(line, "WebhookEnabled=(\d+)", &match) {
                    WebhookCheckbox.Value := match.1 ; Set the checkbox value
                }
                if RegExMatch(line, "DCIEnabled=(\d+)", &match) {
                    DisconnectCheckbox.Value := match.1 ; Set the checkbox value
                }
            }
            else if (section = "Keybinds") {
                if RegExMatch(line, "Hotkey1=(.+)", &match) {
                    hotkey1.Value := match.1
                }
                if RegExMatch(line, "Hotkey2=(.+)", &match) {
                    hotkey2.Value := match.1
                }
                if RegExMatch(line, "Hotkey3=(.+)", &match) {
                    hotkey3.Value := match.1
                }
            }
            else if (section = "UnitPriority") {
                if RegExMatch(line, "UnitPriorityOrder(\d+)=(\w+)", &match) {
                    slot := match.1
                    value := match.2

                    unitPriorityOrder[slot - 1] := value

                    dropDown := unitUpgradePrioritydropDowns[slot - 1]
                    if (dropDown) {
                        dropDown.Text := value
                    }
                }
                if RegExMatch(line, "UUPEnabled=(\d+)", &match) { ; unit priority toggle
                    UUPCheckbox.Value := match.1 ; Set the checkbox value
                }
            }
            else if (section = "Update") {
                if RegExMatch(line, "AutoUpdateEnabled=(\d+)", &match) {
                    AutoUpdate.Value := match.1
                    global autoUpdateEnabled := match.1
                }
            }
            else if (section = "PlacementLogic") {
                if RegExMatch(line, "Logic=(\d+)", &match) {
                    PlacementDropdown.Value := match.1 ; Set the checkbox value
                }
            }
        }

        hotkeyKeybind1 := hotkey1.Value or "F1"
        hotkeyKeybind2 := hotkey2.Value or "F2"
        hotkeyKeybind3 := hotkey3.Value or "F3"

        Hotkey(hotkeyKeybind1, (*) => SetupMacro())
        Hotkey(hotkeyKeybind2, (*) => InitializeMacro())
        Hotkey(hotkeyKeybind3, (*) => StopMacro())

        KeyBinds.Text := hotkeyKeybind1 " - Fix Roblox Position`n" . hotkeyKeybind2 " - Start Macro`n" . hotkeyKeybind3 " - Stop Macro"
        file.Close()
        AddToLog("Configuration loaded successfully.")
    }
}

SaveGlobal(*) {
    if (IsProcessElevated(DllCall("GetCurrentProcessId")) != 1) {
        AddToLog("Failed to save to global config, make sure macro is running with admin rights.")
        return
    }

    SaveConfigToFile("C:\config.txt")
    GuiClose()
}

SaveLocal(*) {
    SaveConfigToFile("Lib\Settings\config.txt")
    GuiClose()
}

LoadGlobal(*) {
    LoadConfigFromFile("C:\config.txt")
    GuiClose()
}

LoadLocal(*) {
    LoadConfigFromFile("Lib\Settings\config.txt")
    GuiClose()
}