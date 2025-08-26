#Requires AutoHotkey v2.0

; *************************** Libraries ***************************
#Include lib\icon.ahk
#Include lib\key.ahk
#Include lib\layout.ahk
#Include lib\layer.ahk
#Include lib\macro.ahk

; *************************** Commands ***************************
#Include commands\helper.ahk
#Include commands\media.ahk
#Include commands\power.ahk
#Include commands\windows.ahk

; ************************ Custom Commands ************************
; Add your custom command files here
#Include commands\custom\vscode.ahk


; *********************** Macro Definitions ***********************
/**
 * @description
 * Configures and returns the layout for the macropad.
 * Create a <b>Layout</b> object with the function key, macro keys and macros.
 *     See lib\key.ahk for details on the Key function.
 * <b>Layers</b> are assigned to the key of the same index as the macro key in the layout.
 * Each layer has a title, icon and a list of macros.
 * You can add "" if you need to skip a layer.
 *     See lib\layout.ahk for details on the Layout class.
 *     See lib\icon.ahk for details on Icons.
 * <b>Macros</b> are assigned to the key of the same index as the macro key in the layout.
 * You can add "" if you need to skip a macro key.
 *     See lib\macro.ahk for details on Macros.
 * @returns {Layout} The configured layout object.
 */
Config() {
    return Layout(Key("ScrollLock", 4, 1, 2, 1), [
        Key("F13", 1, 1),
        Key("F14", 1, 2),
        Key("F15", 1, 3),
        Key("F16", 2, 1),
        Key("F17", 2, 2),
        Key("F18", 2, 3),
        Key("F19", 3, 1),
        Key("F20", 3, 2),
        Key("F21", 3, 3),
        Key("F22", 1, 4, 1, 2),
        Key("F23", 3, 4, 1, 2),
        Key("F24", 4, 3)
    ], [
        Layer("Programs", Icon("programs"), [
            Macro(OpenPowershell, "Powershell", "Open Powershell"),
            Macro(OpenCommandPrompt, "Cmd Prompt", "Open Command Prompt"),
            Macro(OpenFileExplorer, "File Explorer", "Open File Explorer"),
        ]),
        Layer("VS Code", Icon("vs_code"), [
            Macro(VsCodeGoToDefinition, "Go to Def", "Go to Definition in VS Code"),
            Macro(VsCodeGoToImplementation, "Go to Impl", "Go to Implementation in VS Code"),
            Macro(VsCodeGoToReferences, "Go to Refs", "Go to References in VS Code"),
            Macro(VsCodePreviousEditor, "Prev Ed", "Switch to Previous Editor in VS Code"),
            Macro(VsCodePreviousGroup, "Prev Grp", "Switch to Previous Editor Group in VS Code"),
            Macro(VsCodeMovePanelLeft, "Mv Ed <-", "Move Editor Left in VS Code"),
            Macro(VsCodeNextEditor, "Next Ed", "Switch to Next Editor in VS Code"),
            Macro(VsCodeNextGroup, "Next Grp", "Switch to Next Editor Group in VS Code"),
            Macro(VsCodeMovePanelRight, "Mv Ed ->", "Move Editor Right in VS Code"),
            Macro(VsCodeToggleBottomPanel, "Btm Panel", "Toggle Bottom Panel in VS Code"),
            Macro(VsCodeToggleSidebar, "Sidebar", "Toggle Sidebar in VS Code"),
        ]),
        Layer("VS Code Debug", Icon("vs_code_debug"), [
            Macro(VsCodeDebug, "Debug", "Start/Continue Debugging in VS Code"),
            Macro(VsCodePauseDebugging, "Pause", "Pause Debugging in VS Code"),
            Macro(VsCodeStopDebugging, "Stop", "Stop Debugging in VS Code"),
            Macro(VsCodeStepOver, "Step Over", "Step Over in VS Code Debugger"),
            Macro(VsCodeStepInto, "Step Into", "Step Into in VS Code Debugger"),
            Macro(VsCodeStepOut, "Step Out", "Step Out in VS Code Debugger"),
            "",
            Macro(VsCodeAddBreakpoint, "Add Bkpt", "Add Breakpoint in VS Code"),
            Macro(VsCodeAddInlineBreakpoint, "Inline Bkpt", "Add Inline Breakpoint in VS Code"),
            Macro(VsCodeRestartDebugging, "Restart", "Restart Debugging in VS Code"),
            Macro(VsCodeStopDebugging, "Stop", "Stop Debugging in VS Code"),
        ]),
        "",
        "",
        "",
        Layer("Windows", Icon("windows"), [
            Macro(Shutdown, "Shutdown", "Shutdown the computer"),
            Macro(WinSleep, "Sleep", "Put the computer to sleep"),
            Macro(TurnMonitorsOff, "Screen Off", "Turn Off Monitors"),
            "",
            "",
            Macro(CloseWindow, "Close Win", "Close Current Window"),
            Macro(PreviousDesktop, "Prev Dsktp", "Switch to Previous Virtual Desktop"),
            Macro(ShowDesktop, "Show Dsktp", "Minimize all windows and show the desktop"),
            Macro(NextDesktop, "Next Dsktp", "Switch to Next Virtual Desktop"),
            Macro(CreateDesktop, "New Dsktp", "Create New Virtual Desktop"),
            Macro(CloseDesktop, "Del Dsktp", "Close Current Virtual Desktop"),
            Macro(Escape, "Esc"),
        ]),
        Layer("Window Management", Icon("window_management"), [
            Macro(PreviousWindow, "Prev Win", "Switch to Previous Window"),
            Macro(MoveWindowUp, "Move Up", "Move Active Window Up "),
            Macro(NextWindow, "Next Win", "Switch to Next Window"),
            Macro(SnapWindowLeft, "Snp L", "Snap Active Window to Left Half of Screen"),
            Macro(MoveWindowDown, "Move Down", "Move Active Window Down"),
            Macro(SnapWindowRight, "Snp R", "Snap Active Window to Right Half of Screen"),
            Macro(MoveFocusLeft, "<-"),
            Macro(Enter, "Enter"),
            Macro(MoveFocusRight, "->"),
            Macro(FocusWindow, "Focus Win", "Focus Last Active Window"),
            Macro(NextScreen, "Next Mon", "Switch to Next Monitor"),
            Macro(TaskView, "Task View", "Open Task View (virtual desktops and timeline)"),
        ])
    ], 11, , true, true, , )
}