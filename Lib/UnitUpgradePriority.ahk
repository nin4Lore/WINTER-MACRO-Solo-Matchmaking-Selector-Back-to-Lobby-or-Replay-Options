global UnitUpgradePriority := Gui("+AlwaysOnTop")
UnitUpgradePriority.SetFont("s10 bold", "Segoe UI")
UnitUpgradePriority.BackColor := "0c000a"
UnitUpgradePriority.MarginX := 20
UnitUpgradePriority.MarginY := 20

UnitUpgradePriorityOrder := UnitUpgradePriority.Add("GroupBox", "x20 y30 w180 h400 cWhite", "Unit Upgrade Priority Order")
UUPCheckbox := UnitUpgradePriority.Add("Checkbox", "x20 y10 w150 cWhite", "Enabled")

options := ["slot_1", "slot_2", "slot_3", "slot_4", "slot_5", "slot_6"]

numDropDowns := 6
yStart := 70
ySpacing := 32

global unitUpgradePrioritydropDowns := []

For index, _ in options {
    if (index > numDropDowns)
        Break
    yPos := yStart + ((index - 1) * ySpacing)
    UnitUpgradePriority.Add("Text", Format("x38 y{} w20 h23 +0x200 cWhite", yPos), index)
    unitUpgradePrioritydropDown := UnitUpgradePriority.Add("DropDownList", Format("x60 y{} w120 Choose{}", yPos, index), options)
    unitUpgradePrioritydropDowns.Push(unitUpgradePrioritydropDown)

    AttachUpgradeDropDownEvent(unitUpgradePrioritydropDown, index)
}

AttachUpgradeDropDownEvent(dropDown, index) {
    dropDown.OnEvent("Change", (*) => OnUpgradeDropDownChange(dropDown, index))
}

global unitPriorityOrder := ["slot_1", "slot_2", "slot_3", "slot_4", "slot_5", "slot_6"]

OnUpgradeDropDownChange(ctrl, index) {
    if (index >= 0 and index <= 10) {
        unitPriorityOrder[index] := ctrl.Text
        AddToLog(Format("Priority {} set to {}", index, ctrl.Text))
        RemoveEmptyStrings(unitPriorityOrder)
    } else {
        AddToLog(Format("Invalid index {} for dropdown", index))
    }
}

OpenUnitUpgrade() {
    UnitUpgradePriority.Show()
}