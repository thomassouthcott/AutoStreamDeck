#Requires AutoHotkey v2.0

#Include create_image_button.ahk
; *********************** Gui ********************************
/**
 * @class
 * @description
 * Represents the Layer Selection GUI for the macro pad.
 * Manages the display and interaction of layers and their associated macros.
 */
class LayerSelectGui {
   /**
    * @description
    * Initializes the LayerSelectGui with the provided layout.
    * Sets up the GUI window, buttons, and labels based on the layout configuration.
    * @param {Layout} Layout
    * The layout configuration for the GUI.
    */
   __New(Layout) {
      ; Variables
      this.__selectedLayer := 0

      fontColor := "cFEFEFE"
      transColor := "0x010101"

      this.layout := Layout

      ; UI Elements
      this.buttons := []
      this.labels := []

      ; Window
      this.window := Gui()
      this.window.Opt("-MinimizeBox -MaximizeBox -SysMenu +AlwaysOnTop -Caption +Owner -Parent")
      this.window.Title := ""
      this.window.SetFont(fontColor " bold italic", "Consolas")
      this.window.BackColor := transColor
      WinSetTransColor(transColor, this.window)

      ; Add Layout Labels
      Loop Layout.keys.Length {
         this.labels.Push(this.window.AddText("r1 center x" Layout.keys[A_Index].label.x " y" Layout.keys[A_Index].label.y " w" Layout.keys[A_Index].label.w " h" Layout.keys[A_Index].label.h " Section", layout.keys[A_Index].key))
      }

      ; Add Layout Buttons
      Loop Layout.keys.Length {
         this.buttons.Push(this.window.AddButton("x" Layout.keys[A_Index].x " y" Layout.keys[A_Index].y " w" Layout.keys[A_Index].w " h" Layout.keys[A_Index].h " disabled"))
      }

      ; Initialize icons
      for (i, button in this.buttons) {
         Layout.InitializeIcon(i, button)
      }

      ; Select the first non-blank layer
      if (Layout.default >= 1 && Layout.default <= Layout.layers.Length && Layout.layers[Layout.default]) {
         this.SelectLayer(Layout.default)
      }
      else {
         for (i, layer in Layout.layers) {
            if (!layer) {
               continue
            } else {
               this.SelectLayer(i)
               break
            }
         }
      }

      if (Layout.showFn) {
         ; Show the function key label
         this.window.AddText("r1 center x" Layout.fn.label.x " y" Layout.fn.label.y " w" Layout.fn.label.w " h" Layout.fn.label.h " Section", Layout.showFn)
         ; Show the function key button
         fnButton := this.window.AddButton("x" Layout.fn.x " y" Layout.fn.y " w" Layout.fn.w " h" Layout.fn.h " disabled")
         icon := Layout.GetEmptyIcon(Layout.keys[i])
         CreateImageButton(this.buttons[i], 0, [icon, , , 32], [icon, , , 32])
      }
   }

   /**
    * @description
    * Returns the currently selected layer index.
    * @returns {number}
    * The index of the selected layer.
    */
   GetSelectedLayer() {
      return this.__selectedLayer
   }

   /**
    * @description
    * Selects a layer by its index and updates the GUI accordingly.
    * If no layer is found, the function exits without making changes.
    * @param {number} Value
    * The index of the layer to select.
    */
   SelectLayer(Value) {
      ; Validate input
      if (Value < 1 || Value > this.layout.layers.Length || !this.layout.layers[Value]) {
         return
      }

      ; If there was a previously selected layer, update its icon
      if (this.__selectedLayer) {
         this.layout.SetPreviousLayerIcon(this.__selectedLayer, Value, this.buttons[this.__selectedLayer])
      }

      ; Update labels and icons for the new selected layer
      this.layout.SetNextLayerIcon(Value, this.buttons[Value])

      ; Update label texts
      this.layout.SetNextLayerLabels(Value, this.labels)

      ; Update button icons
      this.layout.SetLayerIcons(this.__selectedLayer, Value, this.buttons)

      this.__selectedLayer := Value
   }

   /**
    * @description
    * Shows the GUI window.
    */
   Show() {
      this.window.Show()
   }

   /**
    * @description
    * Hides the GUI window.
    */
   Hide() {
      this.window.Hide()
   }

   /**
    * @description
    * Returns the appropriate empty icon path based on key dimensions.
    * @param {Key} Key
    * The key from the layout.
    * @returns {string}
    * The file path of the empty icon.
    */
   static GetEmptyIcon(Key) {
      if (Key.width == 1 && Key.height == 1) {
         return "img/empty_1x1.png"
      } else if (Key.width == 1 && Key.height == 2) {
         return "img/empty_1x2.png"
      } else if (Key.width == 2 && Key.height == 1) {
         return "img/empty_2x1.png"
      } else if (Key.width == 2 && Key.height == 2) {
         return "img/empty_2x2.png"
      }
      return "img/empty.png"
   }

   static GetBlankIcon() {
      return "img/blank.png"
   }
}
