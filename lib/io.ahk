#Requires AutoHotkey v2.0

; *********************** IO Functions ********************************
/**
 * @description
 * Toggles the layer selection GUI while the specified key is held down.
 * @param {(String)} KeyName
 * The {@link https://www.autohotkey.com/docs/v2/KeyList.htm|name of a key} used for selection.  
 * Controller buttons can be used but none of the others controller inputs.  
 * A virtual code such as `vkFF` can be used for {@link https://www.autohotkey.com/docs/v2/KeyList.htm#SpecialKeys|special cases}.
 */
ToggleLayerSelection(Keyname)
{
   ; variables
   global mode
   global selectionGui
   
   ; enable layer selection mode
   mode := 1 
   selectionGui.Show()

   ; disable layer selection mode on Keyname release
   KeyWait(Keyname)
   mode := 0 
   selectionGui.Hide()
}

/**
 * @description
 * Activates a macro or selects a layer depending on the current mode.
 * @param {(String)} Keyname
 * The {@link https://www.autohotkey.com/docs/v2/KeyList.htm|name of a key} used for a macro button.  
 * Controller buttons can be used but none of the others controller inputs.  
 * A virtual code such as `vkFF` can be used for {@link https://www.autohotkey.com/docs/v2/KeyList.htm#SpecialKeys|special cases}.
 */
ActivateOrSelectMacro(Keyname)
{
   ; variables
   global mode
   global selectionGui
   if (selectionGui.layout.IsNoLayers())
      return

   value := selectionGui.layout.GetKeyIndex(Keyname)

   ; if Layer Selection mode is enabled
   if (mode == 1) {
      mode := 2
      selectionGui.SelectLayer(value)
      mode := 1
   }
   ; if Macro mode is enabled
   else if (mode == 0) {
      ; get the selected layer
      try {
         selectedLayer := selectionGui.GetSelectedLayer()
         ; if not a blank macro
         if (selectionGui.layout.layers[selectedLayer].macros[value])
            ; function of key on the selected layer
            selectionGui.layout.layers[selectedLayer].macros[value].action()
      } catch Error as err {
         if (err.message != "Invalid index.")
            throw err
      }
   }
   ; do nothing if changing layer
   ; wait for key release to prevent stuck keys
   KeyWait(Keyname)
}

/**
 * @description
 * A function that does nothing.
 * @param {(String)} Keyname
 * The {@link https://www.autohotkey.com/docs/v2/KeyList.htm|name of a key} used for a macro button.  
 * Controller buttons can be used but none of the others controller inputs.  
 * A virtual code such as `vkFF` can be used for {@link https://www.autohotkey.com/docs/v2/KeyList.htm#SpecialKeys|special cases}.
 */
DoNothing(Keyname) {
   return
}

/**
 * @description Handles mouse events for tooltips and clicks on the GUI elements.
 * @param wParam 
 * @param lParam 
 * @param msg
 * @param hwnd 
 */
OnMouseEvent(wParam, lParam, msg, hwnd) {
   static TME_LEAVE := 0x2
   global selectionGui
   if (selectionGui.layout.IsNoLayers())
      return
   if (msg = WM_LBUTTONDOWN) {
      ; Get the hwnd of the control the mouse is over
      MouseGetPos(, , , &ctrl, 2)
      ; See if its a label
      Loop selectionGui.labels.Length {
         if (selectionGui.labels[A_Index].Hwnd = ctrl) {
            if (selectionGui.layout.macroIcons) {
               if (A_Index <= selectionGui.layout.layers.Length && selectionGui.layout.layers[A_Index])
                  ; Select the layer
                  if (selectionGui.layout.layers[A_Index])
                     selectionGui.SelectLayer(A_Index)
               return
            }
            ; Activate the macro 
            selectionGui.layout.layers[selectionGui.GetSelectedLayer()].macros[A_Index].action()
         }
      }
      ; See if its a button
      Loop selectionGui.buttons.Length {
         if (selectionGui.buttons[A_Index].Hwnd = ctrl && selectionGui.layout.layers.Length >= A_Index) {
            if ((selectionGui.layout.iconAction || !selectionGui.layout.showLabels) || (selectionGui.layout.macroIcons || !selectionGui.layout.showLabels)) { 
               if (A_Index <= selectionGui.layout.layers[selectionGui.GetSelectedLayer()].macros.Length && selectionGui.layout.layers[selectionGui.GetSelectedLayer()].macros[A_Index])
                  selectionGui.layout.layers[selectionGui.GetSelectedLayer()].macros[A_Index].action()
               return
            }
            ; Select the layer
            if (selectionGui.layout.layers[A_Index])
               selectionGui.SelectLayer(A_Index)
            return
         }
      }
   }
   if msg = WM_MOUSEMOVE {
      ; Start tracking so we know when the mouse leaves the window
      TRACKMOUSEEVENT := Buffer(8 + A_PtrSize * 2)
      NumPut('UInt', TRACKMOUSEEVENT.Size,
            'UInt', TME_LEAVE,
            'Ptr', hwnd,
            'Ptr', 10, TRACKMOUSEEVENT)
      DllCall('TrackMouseEvent', 'Ptr', TRACKMOUSEEVENT)
      ; Get the hwnd of the control the mouse is over
      MouseGetPos(, , , &ctrl, 2)
      ; See if its a label
      Loop selectionGui.labels.Length {
         ; Set the tooltip to the macro description
         if (selectionGui.labels[A_Index].Hwnd = ctrl) {
            if (selectionGui.layout.macroIcons) {
               if (A_Index <= selectionGui.layout.layers.Length && selectionGui.layout.layers[A_Index])
                  ToolTip(selectionGui.layout.layers[A_Index].title, , , 1)
                  return
            }
            ToolTip(selectionGui.layout.layers[selectionGui.GetSelectedLayer()].macros[A_Index].name "`n" selectionGui.layout.layers[selectionGui.GetSelectedLayer()].macros[A_Index].description, , , 1)
            return
         }
      }
      ; See if its a button
      Loop selectionGui.buttons.Length {
         if (selectionGui.buttons[A_Index].Hwnd = ctrl && selectionGui.layout.keys.Length >= A_Index) {
            if ((selectionGui.layout.iconAction || !selectionGui.layout.showLabels) || (selectionGui.layout.macroIcons || !selectionGui.layout.showLabels)) {
               if (A_Index <= selectionGui.layout.layers[selectionGui.GetSelectedLayer()].macros.Length && selectionGui.layout.layers[selectionGui.GetSelectedLayer()].macros[A_Index])
                  ToolTip(selectionGui.layout.layers[selectionGui.GetSelectedLayer()].macros[A_Index].name "`n" selectionGui.layout.layers[selectionGui.GetSelectedLayer()].macros[A_Index].description, , , 1)
               return
            }
            ; Set the tooltip to the layer title
            if (selectionGui.layout.layers.Length >= A_Index && selectionGui.layout.layers[A_Index])
               ToolTip(selectionGui.layout.layers[A_Index].title, , , 1)
               return
         }
      }
   } 
   if msg = WM_MOUSELEAVE {
      ToolTip( , 0, 0, 1)
   }
}