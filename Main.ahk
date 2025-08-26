#Requires AutoHotkey v2.0
#SingleInstance force

#Include lib\ui.ahk
#Include lib\io.ahk

#Include config.ahk
; *********************** Header - some configuration  ***********************
; #Warn  ; Enable warnings to assist with detecting common errors. (disabled by default)

; TODOS:
; - Web app to generate the layers and macros json config FUTURE

; *********************** Main ********************************
; To use CreateImageButton function must first call
UseGDIP()
TraySetIcon("img\icon.ico")

; MODE 0 = Macro Mode
; MODE 1 = Layer Selection Mode
; MODE 2 = Changing Layer
global mode := 0
global selectionGui := LayerSelectGui(Config())

; ***************************** Layout Hotkey Handling  *********************************
Hotkey(selectionGui.layout.fn.key, ToggleLayerSelection) ; Fn key

for(i, j in selectionGui.layout.keys) {
   Hotkey(j.key, ActivateOrSelectMacro) ; Macro keys
   Hotkey(j.key " Up", DoNothing)
}

; *********************** Mouse Handling for Tooltips and Clicks  ***********************
OnMessage(WM_MOUSEMOVE  := 0x0200, OnMouseEvent)
OnMessage(WM_MOUSELEAVE := 0x02A3, OnMouseEvent)
OnMessage(WM_LBUTTONDOWN := 0x0201, OnMouseEvent)