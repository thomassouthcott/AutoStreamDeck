#Requires AutoHotkey v2.0

; *********************** Windows Functions *********************
/**
 * Opens or activates File Explorer.
 * @param {Macro} Macro - The macro object (not used).
 */
OpenFileExplorer(Macro) {
    ActivateOrOpen("ahk_exe explorer.exe",'explorer', "")
}

/**
 * Opens or activates Windows PowerShell.
 * @param {Macro} Macro - The macro object (not used).
 */
OpenPowershell(Macro) {
    ActivateOrOpen("ahk_exe powershell.exe",'powershell', "")
}

/**
 * Opens or activates Command Prompt.
 * @param {Macro} Macro - The macro object (not used).
 */
OpenCommandPrompt(Macro) {
    ActivateOrOpen("ahk_exe cmd.exe",'cmd', "")
}

/**
 * Opens or activates Task Manager.
 * @param {Macro} Macro - The macro object (not used).
 */
OpenTaskManager(Macro) {
    ActivateOrOpen("ahk_exe taskmgr.exe",'taskmgr', "")
}

/**
 * Opens the Control Panel.
 * @param {Macro} Macro - The macro object (not used).
 */
OpenControlPanel(Macro) {
    Run("control")
}

/**
 * Opens the Windows Settings app.
 * @param {Macro} Macro - The macro object (not used).
 */
OpenSettings(Macro) {
    Run("ms-settings:")
}

/**
 * Opens the Windows Services management console.
 * @param {Macro} Macro - The macro object (not used).
 */
OpenServices(Macro) {
    Run("services.msc")
}

/**
 * Snaps the active window to the top half of the screen.
 * @param {Macro} Macro - The macro object (not used).
 */
SnapWindowTop(Macro) {
    Send("{LWin Down}{LAlt Down}{Up}{LAlt Up}{LWin Up}")
}

/**
 * Snaps the active window to the bottom half of the screen.
 * @param {Macro} Macro - The macro object (not used).
 */
SnapWindowBottom(Macro) {
    Send("{LWin Down}{LAlt Down}{Down}{LAlt Up}{LWin Up}")
}

/**
 * Snaps the active window to the left half of the screen.
 * @param {Macro} Macro - The macro object (not used).
 */
SnapWindowLeft(Macro) {
    Send("{LWin Down}{Left}{LWin Up}")
}

/**
 * Snaps the active window to the left third of the screen.
 * @param {Macro} Macro - The macro object (not used).
 */
SnapThirdsLeft(Macro) {
    Send("{LWin Down}{LAlt Down}{Left}{LAlt Up}{LWin Up}")
}

/**
 * Snaps the active window to the right half of the screen.
 * @param {Macro} Macro - The macro object (not used).
 */
SnapWindowRight(Macro) {
    Send("{LWin Down}{Right}{LWin Up}")
}

/**
 * Snaps the active window to the right third of the screen.
 * @param {Macro} Macro - The macro object (not used).
 */
SnapThirdsRight(Macro) {
    Send("{LWin Down}{LAlt Down}{Right}{LAlt Up}{LWin Up}")
}

/**
 * Moves the active window up
 * @param {Macro} Macro - The macro object (not used).
 */
MoveWindowUp(Macro) {
    Send("{LWin Down}{Up}{LWin Up}")
}

/**
 * Moves the active window down
 * @param {Macro} Macro - The macro object (not used).
 */
MoveWindowDown(Macro) {
    Send("{LWin Down}{Down}{LWin Up}")
}

/**
 * Alt Tab to the next window
 * @param {Macro} Macro - The macro object (not used).
 */
NextWindow(Macro) {
    Send("{Alt Down}{Shift Down}{Tab}{Shift Up}{Alt Up}")
}

/**
 * Alt Shift Tab to the previous window
 * @param {Macro} Macro - The macro object (not used).
 */
PreviousWindow(Macro) {
    Send("{Alt Down}{Tab}{Alt Up}")
}

/**
 * Focuses the current window (restores if minimized)
 * @param {Macro} Macro - The macro object (not used).
 */
FocusWindow(Macro) {
    Send("{LWin Down}{Home}{LWin Up}")
}

/**
 * Closes the current window
 * @param {Macro} Macro - The macro object (not used).
 */
CloseWindow(Macro) {
    Send("{Alt Down}{F4}{Alt Up}")
}

/**
 * Create a new virtual desktop
 * @param {Macro} Macro - The macro object (not used).
 */
CreateDesktop(Macro) {
    Send("{LWin Down}{Ctrl Down}d{Ctrl Up}{LWin Up}")
}

/**
 * Close the current virtual desktop
 * @param {Macro} Macro - The macro object (not used).
 */
CloseDesktop(Macro) {
    Send("{LWin Down}{Ctrl Down}{F4}{Ctrl Up}{LWin Up}")
}

/**
 * Switch to the next virtual desktop
 * @param {Macro} Macro - The macro object (not used).
 */
NextDesktop(Macro) {
    Send("{Ctrl Down}{LWin Down}{Right}{LWin Up}{Ctrl Up}")
}

/**
 * Switch to the previous virtual desktop
 * @param {Macro} Macro - The macro object (not used).
 */
PreviousDesktop(Macro) {
    Send("{Ctrl Down}{LWin Down}{Left}{LWin Up}{Ctrl Up}")
}

/**
 * Show the desktop (minimize all windows)
 * @param {Macro} Macro - The macro object (not used).
 */
ShowDesktop(Macro) {
    Send("{LWin Down}d{LWin Up}")
}

/**
 * Switch to the next screen (for multi-monitor setups)
 * @param {Macro} Macro - The macro object (not used).
 */
NextScreen(Macro) {
    Send("{LWin Down}{Shift Down}{Right}{Shift Up}{LWin Up}")
}

/**
 * Switch to the previous screen (for multi-monitor setups)
 * @param {Macro} Macro - The macro object (not used).
 */
PreviousScreen(Macro) {
    Send("{LWin Down}{Shift Down}{Left}{Shift Up}{LWin Up}")
}

/**
 * Open Task View (virtual desktops and timeline)
 * @param {Macro} Macro - The macro object (not used).
 */
TaskView(Macro) {
    Send("{LWin Down}{Tab}{LWin Up}")
}

/**
 * Print the screen (screenshot of entire screen)
 * @param {Macro} Macro - The macro object (not used).
 */
PrintScreen(Macro) {
    Send("{PrintScreen}")
}

/**
 * Print the active window (screenshot of active window)
 * @param {Macro} Macro - The macro object (not used).
 */
PrintActiveWindow(Macro) {
    Send("{Alt Down}{PrintScreen}{Alt Up}")
}

/**
 * Open the Snipping Tool (screenshot utility)
 * @param {Macro} Macro - The macro object (not used).
 */
SnippingTool(Macro) {
    Run("ms-screenclip:")
}

/**
 * Left arrow key (for moving focus in dialogs)
 * @param {Macro} Macro - The macro object (not used).
 */
MoveFocusLeft(Macro) {
    Send("{Left}")
}

/**
 * Enter key (for moving focus in dialogs)
 * @param {Macro} Macro - The macro object (not used).
 */
Enter(Macro) {
    Send("{Enter}")
}

/**
 * Escape key (for moving focus in dialogs)
 * @param {Macro} Macro - The macro object (not used).
 */
Escape(Macro) {
    Send("{Escape}")
}

/**
 * Right arrow key (for moving focus in dialogs)
 * @param {Macro} Macro - The macro object (not used).
 */
MoveFocusRight(Macro) {
    Send("{Right}")
}