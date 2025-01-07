#Requires AutoHotkey v2.0
#MaxThreadsPerHotkey 2

OpenWebhooks() {
    WebhookGUI.Show("w300 h150")
}

WebhookGUI := Gui("+AlwaysOnTop")

WebhookGUI.SetFont("s8 bold", "Segoe UI")
WebhookGUI.Add("Text", "x10 y8 w280 cWhite", "If you would like the macro to send you updates occasionally on how the progression is going, you can use webhooks.")

WebhookGUI.Add("Text", "x10 y56 cWhite", "Enter your webhook URL")
WebhookURL := WebhookGUI.Add("Edit", "x10 y70 w280", "")

WebhookCheckbox := WebhookGUI.Add("Checkbox", "x10 y109 cWhite", "Enabled")
DisconnectCheckbox := WebhookGUI.Add("Checkbox", "x10 y125 cWhite", "Disconnection Notifications")

WebhookGUI.BackColor := "0c000a"
WebhookGUI.MarginX := 20
WebhookGUI.MarginY := 20

WebhookGUI.OnEvent("Close", (*) => WebhookGUI.Hide())
WebhookGUI.Title := "Webhooks"

SetWebhook(*) {
    try {
        if (WebhookURL.Value != "") {
            global Webhook := WebHookBuilder(WebhookURL.Value)
            AddToLog("Succesfully changed webhook URL")
        }
    } catch {
        MsgBox("Your webhook URL is not valid.", "Webhook", 4096 + 0)
    }
}

WebhookGUI.OnEvent("Close", SetWebhook)

Cancel() {
    WebhookGUI.Hide()
}
