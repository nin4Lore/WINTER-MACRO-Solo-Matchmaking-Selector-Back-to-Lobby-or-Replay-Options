#Requires AutoHotkey v2.0
#MaxThreadsPerHotkey 2

; Function to open the guide
OpenGuide() {
    GuideGUI.Show("w800")
}

; Function to load built-in macros

GuideGUI := Gui("+AlwaysOnTop")
GuideGUI.SetFont("s10 bold", "Segoe UI")
GuideGUI.Title := "Auto Challenge Guide"

GuideGUI.BackColor := "0c000a"
GuideGUI.MarginX := 20
GuideGUI.MarginY := 20
GuideGUI.OnEvent("Close", (*) => GuideGUI.Hide())

; Add an image\

GuideGUI.SetFont("s16 bold", "Segoe UI")

GuideGUI.Add("Text", "x0 w800 cWhite +Center", "1 - In your AA settings make sure you have these 2 settings set to this")
GuideGUI.Add("Picture", "x100 w600 h160 cWhite +Center", "Lib\Images\aasettings.png")

GuideGUI.Add("Text", "x0 w800 cWhite +Center", "2 - In your ROBLOX settings, make sure your keyboard is set to Default and your graphics are set to 1")
GuideGUI.Add("Picture", "x50 w700   cWhite +Center", "Lib\Images\defaultkeyboard.png")
GuideGUI.Add("Picture", "x50 w700   cWhite +Center", "Lib\Images\graphics1.png")
GuideGUI.Add("Text", "x0 w800 cWhite +Center", "3 - Set up the unit setup however you want, however I'd avoid hill only units if you can since it might break")

GuideGUI.Add("Text", "x0 w800 cWhite +Center", "4 - Rejoin Anime Adventures, dont move your camera at all and press F2 to start the macro. Good luck!" )

#Requires AutoHotkey v2.0
#MaxThreadsPerHotkey 2


