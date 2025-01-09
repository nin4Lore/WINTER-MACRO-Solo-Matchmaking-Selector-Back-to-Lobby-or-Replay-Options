#Requires AutoHotkey v2
#Include %A_ScriptDir%\Lib\guidegui.ahk
#Include %A_ScriptDir%\Lib\webhooksgui.ahk
#Include %A_ScriptDir%\Lib\config.ahk
#Include %A_ScriptDir%\Lib\mainsettingsui.ahk
#Include %A_ScriptDir%\Lib\keybinds.ahk
#Include %A_ScriptDir%\Lib\PriorityPicker.ahk
#Include %A_ScriptDir%\Lib\UnitUpgradePriority.ahk

GemsEarned := 0
ShibuyaFood := 0
TraitRerolls := 0
StatChips := 0
SuperStatChips := 0
GreenEssence := 0
ColoredEssence := 0
CurrentChallenge := "None"
MinimizeImage := "Lib\Images\minimize.png"
CloseImage := "Lib/Images/close.png"
TaxiImage := "Lib\Images\faxi pfp.png"
DiscordImage := "Lib\Images\Discord-Logo.png"
lastlog := ""
MainGUI := Gui("-Caption +Border +AlwaysOnTop", "Taxi Winter Event Farm")

MainGUI.BackColor := "0c000a"
MainGUI.SetFont("s9 bold", "Segoe UI")

CloseAppButton := MainGUI.Add("Picture", "x910 y8 w60 h34 +BackgroundTrans cffffff", DiscordImage)
CloseAppButton.OnEvent("Click", (*) => OpenDiscord())

MinimizeButton := MainGUI.Add("Picture", "x1000 y22 w37 h9 +BackgroundTrans cffffff", MinimizeImage)
MinimizeButton.OnEvent("Click", (*) => MinimizeGUI())

CloseAppButton := MainGUI.Add("Picture", "x1052 y10 w30 h32 +BackgroundTrans cffffff", CloseImage)
CloseAppButton.OnEvent("Click", (*) => ExitApp())

GuideBttn := MainGui.Add("Button", "x830 y632 w105 cffffff +BackgroundTrans +Center", "How to use?")
GuideBttn.OnEvent("Click", (*) => OpenGuide())

#Requires AutoHotkey v2.0
#MaxThreadsPerHotkey 2


; Create the initial GUI
MainSettings := Gui("+AlwaysOnTop")
MainSettings.SetFont("s8 bold", "Segoe UI")

; Set GUI properties
MainSettings.BackColor := "0c000a"
MainSettings.MarginX := 20
MainSettings.MarginY := 20
MainSettings.OnEvent("Close", (*) => MainSettings.Hide())
MainSettings.Title := "Main Settings UI"

MainSettings.Add("Text", "x30 y20 w340 h190 +Center cffffff", "Settings")

; Add Launch Button
Webhookbttn := MainSettings.Add("Button", "x30 y45 w150", "Webhook Settings")
Webhookbttn.OnEvent("Click", (*) => OpenWebhooks())

SendChatBttn := MainSettings.Add("Button", "x220 y45 w150", "Send Chat")
SendChatBttn.OnEvent("Click", (*) => OpenSendChat())

SendChatBttn := MainSettings.Add("Button", "x30 y110 w150", "Keybinds")
SendChatBttn.OnEvent("Click", (*) => OpenKeybinds())

SendChatBttn := MainSettings.Add("Button", "x30 y170 w150", "Unit upgrade priority order")
SendChatBttn.OnEvent("Click", (*) => OpenUnitUpgrade())

SendChatBttn := MainSettings.Add("Button", "x220 y110 w150", "Card priority order")
SendChatBttn.OnEvent("Click", (*) => OpenPriorityPicker())

SendChatBttn := MainSettings.Add("Button", "x220 y170 w150", "Placement Logic")
SendChatBttn.OnEvent("Click", (*) => OpenPlacementLogic())

global PlacementLogicUI := Gui("+AlwaysOnTop")
PlacementLogicUI.SetFont("s10 bold", "Segoe UI")
PlacementLogicUI.BackColor := "0c000a"
PlacementLogicUI.MarginX := 20
PlacementLogicUI.MarginY := 20

PlacementLogicUI.Add("Text", "x10 y8 w250 cWhite", "If you feel like the placement is not working as intended, change this option")

PlacementLogicUI.SetFont("s8", "Segoe UI")
global PlacementDropdown := PlacementLogicUI.Add("DropDownList", "x10 y60  w250 cffffff", ["Spiral", "Lines"])

OpenPlacementLogic() {
    PlacementLogicUI.Show()
}

; Show the main settings GUI
; Show the initial GUI
OpenSettings() {
    MainSettings.Show("AutoSize Center")
}

WebhookBtn := MainGui.Add("Button", "x965 y632 w105 cffffff +BackgroundTrans +Center", "Settings")
WebhookBtn.OnEvent('Click', (*) => OpenSettings())



; Card Picker Checkbox
CardPicker := MainGUI.Add("Checkbox", "x700 y640 w105 cffffff Checked", "Card picker")
changeCardPicker() {
    global cardPickerEnabled := CardPicker.Value
}
CardPicker.OnEvent('Click', (*) => changeCardPicker())

; Auto Update Checkbox
AutoUpdate := MainGUI.Add("Checkbox", "x480 y640 w100 cffffff Checked", "Auto update")
ChangedAutoUpdate() {
    global autoUpdateEnabled := AutoUpdate.Value
}
AutoUpdate.OnEvent("Click", (*) => ChangedAutoUpdate())

; Matchmaking Checkbox
MatchMode := MainGUI.Add("Checkbox", "x590 y640 w105 cffffff Checked", "Matchmaking")
changeMatchMode() {
    global matchModeEnabled := MatchMode.Value
}
MatchMode.OnEvent('Click', (*) => changeMatchMode())

; LobbyOrReplay Checkbox
LobbyReplay := MainGUI.Add("Checkbox", "x360 y640 w105 cffffff Checked", "Back To Lobby")
changeLobbyReplay() {
    global backToLobbyEnabled := LobbyReplay.Value
}
LobbyReplay.OnEvent('Click', (*) => changeLobbyReplay())







MainGUI.Add("Picture", "x820 y-20 w90 h90 +BackgroundTrans cffffff", TaxiImage)

MainGUI.AddProgress("c0x7e4141 x8 y27 h602 w800", 100) ; box behind roblox, credits to yuh for this idea
WinSetTransColor("0x7e4141 255", MainGUI)

MainGUI.Add("GroupBox", "x830 y60 w238 h250 cfffd90 ", "Unit Setup")
enabled1 := MainGUI.Add("Checkbox", "x840 y80 cffffff", "Slot 1")
enabled2 := MainGUI.Add("Checkbox", "x840 y110 cffffff", "Slot 2")
enabled3 := MainGUI.Add("Checkbox", "x840 y140 cffffff", "Slot 3")
enabled4 := MainGUI.Add("Checkbox", "x840 y170 cffffff", "Slot 4")
enabled5 := MainGUI.Add("Checkbox", "x840 y200 cffffff", "Slot 5")
enabled6 := MainGUI.Add("Checkbox", "x840 y230 cffffff", "Slot 6")

placement1 := MainGUI.Add("DropDownList", "x1020 y80  w40 cffffff Choose3", [1, 2, 3, 4, 5])
placement2 := MainGUI.Add("DropDownList", "x1020 y110 w40 cffffff Choose3", [1, 2, 3, 4, 5])
placement3 := MainGUI.Add("DropDownList", "x1020 y140 w40 cffffff Choose3", [1, 2, 3, 4, 5])
placement4 := MainGUI.Add("DropDownList", "x1020 y170 w40 cffffff Choose3", [1, 2, 3, 4, 5])
placement5 := MainGUI.Add("DropDownList", "x1020 y200 w40 cffffff Choose3", [1, 2, 3, 4, 5])
placement6 := MainGUI.Add("DropDownList", "x1020 y230 w40 cffffff Choose3", [1, 2, 3, 4, 5])

MainGUI.Add("Text", "x940 y80 h60 cffffff +BackgroundTrans", "Placements: ")
MainGUI.Add("Text", "x940 y110 h60 cffffff +BackgroundTrans", "Placements: ")
MainGUI.Add("Text", "x940 y140 h60 cffffff +BackgroundTrans", "Placements: ")
MainGUI.Add("Text", "x940 y170 h60 cffffff +BackgroundTrans", "Placements: ")
MainGUI.Add("Text", "x940 y200 h60 cffffff +BackgroundTrans", "Placements: ")
MainGUI.Add("Text", "x940 y230 h60 cffffff +BackgroundTrans", "Placements: ")

SaveConfigBttn := MainGUI.Add("Button", "x840 y270 w95 h30 cffffff +Center", "Load config")
SaveConfigBttn.OnEvent("Click", (*) => LoadConfig())

SaveConfigBttn := MainGUI.Add("Button", "x960 y270 w95 h30 cffffff +Center", "Save config")
SaveConfigBttn.OnEvent("Click", (*) => SaveConfig())


MainGUI.Add("GroupBox", "x830 y320 w238 h210 cab00fa ", "Activity Log ")
ActivityLog := MainGUI.Add("Text", "x830 y340 w238 h300 r11 cffffff +BackgroundTrans +Center", "Macro Launched")

MainGUI.Add("GroupBox", "x830 y540 w238 h80 cab00fa ", "Keybinds")
KeyBinds := MainGUI.Add("Text", "x830 y560 w238 h300 r7 cffffff +BackgroundTrans +Center", "F1 - Fix Roblox Position `n F2 - Start Macro `n F3 - Stop Macro")

MainGUI.SetFont("s16 bold", "Segoe UI")

MainGUI.Add("Text", "x12 y632 w800 cab00fa +BackgroundTrans", "Taxi Macro")

MainGUI.Show("x27 y15 w1100 h665")

AddToLog(text) {
    global lastlog
    ActivityLog.Value := text "`n" ActivityLog.Value
}

MinimizeGUI() {
    WinMinimize("Taxi Winter Event Farm")
}

OpenDiscord() {
    Run("https://discord.gg/UB9AaPzqdq")
}


SendChatGUI := Gui("+AlwaysOnTop")

SendChatGUI.SetFont("s8 bold", "Segoe UI")
SendChatGUI.Add("Text", "x10 y8 w280 cWhite", "Would you like the macro to send a message once it loads in a game? (it only sends it once per game and this is optional)")

SendChatGUI.Add("Text", "x10 y56 cWhite", "Message to send")
ChatToSend := SendChatGUI.Add("Edit", "x10 y70 w280", "")

ChatStatusBox := SendChatGUI.Add("Checkbox", "x10 y109 cWhite", "Enabled")

SendChatGUI.BackColor := "0c000a"
SendChatGUI.MarginX := 20
SendChatGUI.MarginY := 20

SendChatGUI.OnEvent("Close", (*) => SendChatGUI.Hide())
SendChatGUI.Title := "Send Chat"


OpenSendChat() {
    SendChatGUI.Show("w300 h150")
}

if FileExist("C:\config.txt") {
    LoadGlobal()
} else {
    LoadLocal()
}