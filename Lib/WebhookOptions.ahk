#Include %A_ScriptDir%\Lib\Discord-Webhook-master\lib\WEBHOOK.ahk
#Include %A_ScriptDir%\Macro.ahk
#Include %A_ScriptDir%\Lib\Gdip_All.ahk

CalculateElapsedTime(StartTime) {
    ElapsedTimeMs := A_TickCount - StartTime
    ElapsedTimeSec := Floor(ElapsedTimeMs / 1000)
    ElapsedHours := Floor(ElapsedTimeSec / 3600)
    ElapsedMinutes := Floor(Mod(ElapsedTimeSec, 3600) / 60)
    ElapsedSeconds := Mod(ElapsedTimeSec, 60)
    Return Format("{} hours, {} minutes", ElapsedHours, ElapsedMinutes)
}

sendWebhook() {
    MacroRuntime := CalculateElapsedTime(MacroStartTime)
    StageRuntime := CalculateElapsedTime(StageStartTime)

    pToken := Gdip_Startup()
    if !pToken {
        MsgBox("Failed to initialize GDI+")
        return
    }

    pBitmap := Gdip_BitmapFromScreen()
    if !pBitmap {
        MsgBox("Failed to capture the screen")
        Gdip_Shutdown(pToken)
        return
    }

    pCroppedBitmap := CropImage(pBitmap, 27, 15, 1100, 640)
    if !pCroppedBitmap {
        MsgBox("Failed to crop the bitmap")
        Gdip_DisposeImage(pBitmap)
        Gdip_Shutdown(pToken)
        return
    }
    ; Prepare the attachment and embed
    attachment := AttachmentBuilder(pCroppedBitmap)
    myEmbed := EmbedBuilder()
    myEmbed.setTitle(":tada: Stage Completed :tada:")
    myEmbed.setDescription(":stopwatch: Macro Runtime: " MacroRuntime "`n:stopwatch: Stage Runtime: " StageRuntime "")
    myEmbed.setColor(0x0A5EB0)
    myEmbed.setImage(attachment)
    myEmbed.setFooter({ text: "Taxi Webhooks" })

    try {
        if (WebhookURL.Value != "") {
            global Webhook := WebHookBuilder(WebhookURL.Value)
        }
    } catch {
        MsgBox("Your webhook URL is not valid.", "Webhook", 4096 + 0)
        return
    }

    ; Send the webhook
    try {
        Webhook.send({
            embeds: [myEmbed],
            files: [attachment]
        })

        AddToLog("Sent webhook successfully")
    } catch {
        AddToLog("Failed to send webhook")
    }

    ; Clean up resources
    Gdip_DisposeImage(pBitmap)
    Gdip_DisposeImage(pCroppedBitmap)
    Gdip_Shutdown(pToken)
}

sendDCWebhook() {
    MacroRuntime := CalculateElapsedTime(MacroStartTime)
    StageRuntime := CalculateElapsedTime(StageStartTime)

    ; Prepare the embed
    myEmbed := EmbedBuilder()
    myEmbed.setTitle(":exclamation: Client Disconnected :exclamation:")
    myEmbed.setDescription(":stopwatch: Disconnected At: " MacroRuntime "`n:stopwatch: Stage Runtime: " StageRuntime "")
    myEmbed.setColor(0xB00A0A)
    myEmbed.setFooter({ text: "Taxi Webhooks" })

    try {
        if (WebhookURL.Value != "") {
            global Webhook := WebHookBuilder(WebhookURL.Value)
        }
    } catch {
        MsgBox("Your webhook URL is not valid.", "Webhook", 4096 + 0)
        return
    }

    ; Send the webhook
    try {
        Webhook.send({
            embeds: [myEmbed],
        })

        AddToLog("Sent webhook successfully")
    } catch {
        AddToLog("Failed to send webhook")
    }

}

sendRCWebhook() {
    MacroRuntime := CalculateElapsedTime(MacroStartTime)
    StageRuntime := CalculateElapsedTime(StageStartTime)

    pToken := Gdip_Startup()
    if !pToken {
        MsgBox("Failed to initialize GDI+")
        return
    }

    pBitmap := Gdip_BitmapFromScreen()
    if !pBitmap {
        MsgBox("Failed to capture the screen")
        Gdip_Shutdown(pToken)
        return
    }

    pCroppedBitmap := CropImage(pBitmap, 27, 15, 1100, 640)
    if !pCroppedBitmap {
        MsgBox("Failed to crop the bitmap")
        Gdip_DisposeImage(pBitmap)
        Gdip_Shutdown(pToken)
        return
    }
    ; Prepare the attachment and embed
    attachment := AttachmentBuilder(pCroppedBitmap)
    myEmbed := EmbedBuilder()
    myEmbed.setTitle(":white_check_mark: Client Reconnected :white_check_mark:")
    myEmbed.setDescription(":stopwatch: Reconnected At: " MacroRuntime "")
    myEmbed.setColor(0x0AB02D)
    myEmbed.setImage(attachment)
    myEmbed.setFooter({ text: "Taxi Webhooks" })

    try {
        if (WebhookURL.Value != "") {
            global Webhook := WebHookBuilder(WebhookURL.Value)
        }
    } catch {
        MsgBox("Your webhook URL is not valid.", "Webhook", 4096 + 0)
        return
    }

    ; Send the webhook
    try {
        Webhook.send({
            embeds: [myEmbed],
            files: [attachment]
        })

        AddToLog("Sent webhook successfully")
    } catch {
        AddToLog("Failed to send webhook")
    }

    ; Clean up resources
    Gdip_DisposeImage(pBitmap)
    Gdip_DisposeImage(pCroppedBitmap)
    Gdip_Shutdown(pToken)
}

; credits to faxi
CropImage(pBitmap, x, y, width, height) {
    ; Initialize GDI+ Graphics from the source bitmap
    pGraphics := Gdip_GraphicsFromImage(pBitmap)
    if !pGraphics {
        MsgBox("Failed to initialize graphics object")
        return
    }

    ; Create a new bitmap for the cropped image
    pCroppedBitmap := Gdip_CreateBitmap(width, height)
    if !pCroppedBitmap {
        MsgBox("Failed to create cropped bitmap")
        Gdip_DeleteGraphics(pGraphics)
        return
    }

    ; Initialize GDI+ Graphics for the new cropped bitmap
    pTargetGraphics := Gdip_GraphicsFromImage(pCroppedBitmap)
    if !pTargetGraphics {
        MsgBox("Failed to initialize graphics for cropped bitmap")
        Gdip_DisposeImage(pCroppedBitmap)
        Gdip_DeleteGraphics(pGraphics)
        return
    }

    ; Copy the selected area from the source bitmap to the new cropped bitmap
    Gdip_DrawImage(pTargetGraphics, pBitmap, 0, 0, width, height, x, y, width, height)

    ; Cleanup
    Gdip_DeleteGraphics(pGraphics)
    Gdip_DeleteGraphics(pTargetGraphics)

    ; Return the cropped bitmap
    return pCroppedBitmap
}
