#Requires AutoHotkey v2.0

; *********************** VS Code Functions *********************
/**
 * Toggles the bottom panel (Explorer, Search, Source Control, etc.).
 * @param {Macro} Macro - The macro object (not used in this function).
 */
VsCodeToggleBottomPanel(Macro) {
    Send("{Ctrl Down}j{Ctrl Up}")
}

/**
 * Toggles the sidebar (File Explorer).
 * @param {Macro} Macro - The macro object (not used in this function).
 */
VsCodeToggleSidebar(Macro) {
    Send("{Ctrl Down}b{Ctrl Up}")
}

VsCodeToggleZenMode(Macro) {
    Send("{Ctrl Down}k{Ctrl Up}")
    Sleep 100
    Send("z")
}

VsCodeCloseEditor(Macro) {
    Send("{Ctrl Down}w{Ctrl Up}")
}

VsCodeReopenClosedEditor(Macro) {
    Send("{Ctrl Down}{Shift Down}t{Shift Up}{Ctrl Up}")
}

VsCodeNextEditor(Macro) {
    Send("{Ctrl Down}{PgDn}{Ctrl Up}")
}

VsCodePreviousEditor(Macro) {
    Send("{Ctrl Down}{PgUp}{Ctrl Up}")
}

VsCodeNextGroup(Macro) {
    Send("{Ctrl Down}k{Ctrl Up}")
    Sleep 100
    Send("{Ctrl Down}{Right}{Ctrl Up}")
}

VsCodePreviousGroup(Macro) {
    Send("{Ctrl Down}k{Ctrl Up}")
    Sleep 100
    Send("{Ctrl Down}{Left}{Ctrl Up}")
}

VsCodeMoveGroupLeft(Macro) {
    Send("{Ctrl Down}k{Ctrl Up}")
    Sleep 100
    Send("{Left}")
}

VsCodeMoveGroupRight(Macro) {
    Send("{Ctrl Down}k{Ctrl Up}")
    Sleep 100
    Send("{Right}")
}

VsCodeSearchInFiles(Macro) {
    Send("{Ctrl Down}{Shift Down}f{Shift Up}{Ctrl Up}")
}

VsCodeMovePanelRight(Macro) {
    Send("{Ctrl Down}{LAlt Down}{Right}{LAlt Up}{Ctrl Up}")
}

VsCodeMovePanelLeft(Macro) {
    Send("{Ctrl Down}{LAlt Down}{Left}{LAlt Up}{Ctrl Up}")
}

/**
 * Opens the Source Control view.
 * @param {Macro} Macro - The macro object (not used in this function).
 */
VsCodeOpenSourceControl(Macro) {
    Send("{Ctrl Down}{Shift Down}g{Shift Up}{Ctrl Up}")
}

/**
 * Splits the current editor panel.
 * @param {Macro} Macro - The macro object (not used in this function).
 */
VsCodeSplitPanel(Macro) {
    Send("{Ctrl Down}{\\}{Ctrl Up}")
}

/**
 * Opens the Command Palette.
 * @param {Macro} Macro - The macro object (not used in this function).
 */
VsCodeOpenCommandPalette(Macro) {
    Send("{Ctrl Down}{Shift Down}p{Shift Up}{Ctrl Up}")
}

/**
 * Opens a new terminal instance.
 * @param {Macro} Macro - The macro object (not used in this function).
 */
VsCodeOpenTerminal(Macro) {
    Send("{Ctrl Down}{Shift Down}'{Shift Up}{Ctrl Up}")
}

VsCodeDebug(Macro) {
    Send("{F5}")
}

; *********************** Debugger Functions *********************

VsCodeAddBreakpoint(Macro) {
    Send("{F9}")
}

VsCodeAddInlineBreakpoint(Macro) {
    Send("{Ctrl Down}{F9}{Ctrl Up}")
}

VsCodeStopDebugging(Macro) {
    Send("{Shift Down}{F5}{Shift Up}")
}

VsCodeRestartDebugging(Macro) {
    Send("{Ctrl Down}{Shift Down}F5{Shift Up}{Ctrl Up}")
}

VsCodePauseDebugging(Macro) {
    Send("{Ctrl Down}{Shift Down}F5{Shift Up}{Ctrl Up}")
}

VsCodeStepInto(Macro) {
    Send("{F11}")
}

VsCodeStepOut(Macro) {
    Send("{Shift Down}{F11}{Shift Up}")
}

VsCodeStepOver(Macro) {
    Send("{F10}")
}

; *********************** Go to *********************
VsCodeGoToDefinition(Macro) {
    Send("{F12}")
}

VsCodePeekDefinition(Macro) {
    Send("{Alt Down}{F12}{Alt Up}")
}

VsCodeGoToReferences(Macro) {
    Send("{Shift Down}{F12}{Shift Up}")
}

VsCodePeekImplementations(Macro) {
    Send("{Ctrl Down}{Shift Down}F12{Shift Up}{Ctrl Up}")
}

VsCodeGoToImplementation(Macro) {
    Send("{Ctrl Down}{F12}{Ctrl Up}")
}
