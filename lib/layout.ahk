#Requires AutoHotkey v2.0

#Include create_image_button.ahk
#Include layer.ahk

; TODO - Then add in macro icons switch on

/**
 * @class
 * @description
 * Represents a layout for the macropad.
 */
class Layout {
    /**
     * @description
     * Creates a new Layout object.
     * @param {Key} FunctionKey 
     * The key used as the function key.
     * @param {Key[]} MacroKeys 
     * An array of keys used for macros.
     * @param {Layer[]} [Layers=[]]
     * An array of layers for the layout. The number of layers must not exceed the number of keys in the layout.
     * @param {(Number)} [Default=1]
     * The default layer index to start on. Must be between `1` and the number of layers.
     * @param {(Boolean)} [ShowFn=false]
     * Whether to show the function key outline.
     * @param {(Boolean)} [ShowMacroMarkers=false]
     * Whether to show macro markers on the buttons.
     * @param {(Boolean)} [ShowLabels=false]
     * Whether to show labels on the buttons.
     * @param {(Boolean)} [UseMacroIcons=false]
     * Whether to use macro icons on the buttons instead of layer icons when a macro is assigned. If macro has no icon, it will use the layer icon.
     * @param {(String)} [IconAction="Layer"]
     * The action to set for icon clicks. Must be either "Macro" to trigger the macro action or "Layer" to switch layers. Default is "Layer".
     */
    __New(FunctionKey, MacroKeys, Layers := [], Default := 1, ShowFn := false, ShowMacroMarkers := false, ShowLabels := false, UseMacroIcons := false, IconAction := "Layer") {
        this.keys := MacroKeys
        this.fn := FunctionKey
        this.layers := []
        this.SetLayers(Layers)
        ; display options
        this.showFn := ShowFn
        this.showMacroMarkers := ShowMacroMarkers
        this.showLabels := ShowLabels
        this.__ApplyLabels()
        this.macroIcons := UseMacroIcons
        this.default := Default
        ; icon click action option
        this.IconClickAction(IconAction)
    }

    /**
     * @description Sets the layers of the layout.
     * @param {Layer[]} Layers 
     * An array of layers to set for the layout. The number of layers must not exceed the number of keys in the layout.
     * @returns {Layout} The current layout object, allowing for method chaining.
     * @throws {Error} 
     * - If the number of layers exceeds the number of buttons in the layout.
     * - If any layer has more macros than the number of buttons in the layout.
     */
    SetLayers(Layers) {
        if (Layers.Length > this.keys.Length) {
            message := "Too many layers (" Layers.Length ") for this amount of buttons (" this.keys.Length ")."
            throw Error(message)
        }
        for i, layer in Layers {
            if (layer) {
                if (layer.macros.Length > this.keys.Length) {
                    message := "Too many macros (" layer.macros.Length ") for this amount of buttons (" this.keys.Length "). - " layer.title " Layer"
                    throw Error(message)
                }
            }
            this.layers.Push(layer)
        }
        return this
    }
    
    /**
     * @description Adds a new layer to the layout. If an index is provided, the layer is added at that index, otherwise it is added to the end of the layers array.
     * @param {(String)} Title
     * The title of the new layer.
     * @param {(Icon)} Icon
     * The icon of the new layer.
     * @param {(Macro[])} NewMacros
     * An array of macros to add to the new layer. The number of macros must not exceed the number of keys in the layout.
     * @param {(Number)} [Index=0]
     * The index at which to insert the new layer. If `0` or not provided, the layer is added to the end of the layers array.
     * @returns {Layout} The current layout object, allowing for method chaining.
     * @throws {Error}
     * - If adding the new layer would exceed the number of buttons in the layout.
     * - If the number of macros exceeds the number of buttons in the layout.
     */
    AddNewLayer(Title, Icon, NewMacros, Index := 0) {
        return this.AddLayer(Layer(Title, Icon, NewMacros), Index)
    }

    
    /**
     * @description Adds a new layer to the layout. If an index is provided, the layer is added at that index, otherwise it is added to the end of the layers array.
     * @param {(Layer)} Layer
     * The layer object to add.
     * @param {(Number)} [Index=0]
     * The index at which to insert the new layer. If `0` or not provided, the layer is added to the end of the layers array.
     * @returns {Layout} The current layout object, allowing for method chaining.
     * @throws {Error}
     * - If adding the new layer would exceed the number of buttons in the layout.
     * - If the number of macros exceeds the number of buttons in the layout.
     */
    AddLayer(Layer, Index := 0) {        
        if (Index) {
            if (Index < 1 || Index > this.keys.Length) {
                throw Error("Index out of bounds.")
            }
            if (this.layers.Length < Index) {
                Loop Index - this.layers.Length
                    this.AddBlankLayer()
            }
            this.layers[Index] := Layer(Layer.title, Layer.icon, Layer.newMacros)
        } else {
            if (this.layers.Length >= this.keys.Length) {
                message := "Too many layers (" (this.layers.Length + 1) ") for this amount of buttons (" this.keys.Length "). Cannot add layer: " Layer.title
                throw Error(message)
            }
            if (Layer.newMacros.Length > this.keys.Length) {
                message := "Too many macros (" Layer.newMacros.Length ") for this amount of buttons (" this.keys.Length "). - " Layer.title " Layer"
                throw Error(message)
            }
            this.layers.Push(Layer(Layer.title, Layer.icon, Layer.newMacros))
        }
        return this
    }

    /**
     * @description Adds a blank layer to the layout.
     * @param {(Number)} [Index=0]
     * The index at which to set to a blank layer. If `0` or not provided, the layer is added to the end of the layers array.
     * @returns {Layout} The current layout object, allowing for method chaining.
     * @throws {Error}
     * - If adding the new layer would exceed the number of buttons in the layout.
     */
    AddBlankLayer(Index := 0) {
        if (Index) {
            if (Index < 1 || Index > this.keys.Length) {
                throw Error("Index out of bounds.")
            }
            if (this.layers.Length < Index) {
                Loop Index - this.layers.Length
                    this.AddBlankLayer()
            }
            this.layers[Index] := ""
        } else {
            if (this.layers.Length >= this.keys.Length) {
                message := "Too many layers (" (this.layers.Length + 1) ") for this amount of buttons (" this.keys.Length "). Cannot add blank layer."
                throw Error(message)
            }
            this.layers.Push("")
        }
        return this
    }

    /**
     * @description Removes and returns the layer at the specified index, setting that index to a blank layer.
     * @param {(Number)} Index
     * The index of the layer to remove.
     * @returns {(Layer|String)} The removed layer, or an empty string if the layer was already blank.
     * @throws {Error} If the index is out of bounds.
     */
    RemoveLayer(Index) {
        if (Index < 1 || Index > this.layers.Length) {
            throw Error("Index out of bounds.")
        }
        val := this.layers[Index]
        this.layers[Index] := ""
        return val
    }

    /**
     * @description Shows the function key if label is provided, otherwise toggles its visibility.
     * @param {(Boolean)} Label Whether to show the function key label.
     * @param {(String)} [Text] Optional text to display instead of the function key name.
     * @returns {Layout} The current layout object, allowing for method chaining.
     */
    ShowFunctionKey(Label, Text := "") {
        this.showFn := " "
        if (Label) {
            if (Text) {
                this.showFn := Text
            } else {
                this.showFn := this.fn.key
            }
        }
        return this
    }

    /**
     * @description Enables the display of macro icons on the buttons.
     * @returns {Layout} The current layout object, allowing for method chaining.
     */
    ShowMacroMarker() {
        this.showMacroMarkers := true
        return this
    }
    
    /**
     * @description Enables the display of macro labels on the buttons.
     * @returns {Layout} The current layout object, allowing for method chaining.
     */
    ShowLabel() {
        this.showLabels := true
        this.__ApplyLabels()
        return this
    }

    /**
     * @description Enables the use of macro icons on the buttons instead of layer icons when a macro is assigned. If a macro has no icon, it will use the layer icon.
     * @returns {Layout} The current layout object, allowing for method chaining.
     */
    UseMacroIcons() {
        this.macroIcons := true
        return this
    }

    /**
     * @description Sets the action for icon clicks to either trigger the macro or switch layers. Default is to switch layers.
     * @param {(String)} action
     * The action to set for icon clicks. Must be either "Macro" to trigger the macro action or "Layer" to switch layers.
     * @returns {Layout} The current layout object, allowing for method chaining.
     * @throws {Error} If the provided action is not "Macro" or "Layer".
     */
    IconClickAction(action := "Layer") {
        if (action == "Macro") {
            this.iconAction := true
        } else if (action == "Layer") {
            this.iconAction := false
        } else {
            throw Error("Invalid action. Use 'Macro' or 'Layer'.")
        }
        return this
    }

    /**
     * @description Applies label positions to all keys in the layout.
     * This method calculates and sets the labelled position for each key based on its row, column, width, and height.
     * It should be called after all keys have been defined to ensure their label positions are correctly set.
     */
    __ApplyLabels() {
        if (this.showLabels) {
            for i, k in this.keys {
                k.CalculateLabelledPosition()
            }
        }
        else {
            for i, k in this.keys {
                k.CalculateUnlabelledPosition()
            }
        }
    }

    /**
     * @description
     * Initializes the icon for a button based on the corresponding layer.
     * If no layer is assigned, it sets a blank or empty icon depending on the showMacroMarkers setting.
     * @param {(Number)} Index
     * The index of the button to initialize.
     * @param {GuiControl} button
     * The GUI control (button) to set the icon for.
     */
    InitializeIcon(Index, Button) {
        ; if no layer assigned, set to blank icon
        if (Index > this.layers.Length || !this.layers[Index]) {
            if (this.showMacroMarkers) {
                icon := LayerSelectGui.GetEmptyIcon(this.keys[Index])
                CreateImageButton(Button, 0, [icon, , , 32], [icon, , , 32])
            } else {
                blank := LayerSelectGui.GetBlankIcon()
                CreateImageButton(Button, 0, [blank, , , 32], [blank, , , 32])
            }
            return
        }
        ; else set to layer icon
        CreateImageButton(Button, 0, [this.layers[Index].icon.layer, , , 32], [this.layers[Index].icon.layer, , , 32])
    }

    /**
     * @description
     * Sets the icon for a button based on the previous layer's icon and the next layer's macros.
     * If the previous layer has a macro assigned in the new layer, it sets the macro icon; otherwise, it sets the layer icon.
     * @param {(Number)} PreviousIndex
     * The index of the previously selected layer.
     * @param {(Number)} NextIndex
     * The index of the newly selected layer.
     * @param {GuiControl} Button
     * The GUI control (button) to set the icon for.
     */
    SetPreviousLayerIcon(PreviousIndex, NextIndex, Button) {
        if (this.macroIcons && PreviousIndex <= this.layers[NextIndex].macros.Length && this.layers[NextIndex].macros[PreviousIndex] && this.layers[NextIndex].macros[PreviousIndex].icon) {
            if (this.showMacroMarkers && !(PreviousIndex > this.layers[NextIndex].macros.Length || (PreviousIndex <= this.layers[NextIndex].macros.Length && !this.layers[NextIndex].macros[PreviousIndex]))) {
                CreateImageButton(Button, 0, [this.layers[NextIndex].macros[PreviousIndex].icon.macro, , , 32], [this.layers[NextIndex].macros[PreviousIndex].icon.macro, , , 32])
            } 
            ; else set to layer with macro icon
            else {
                CreateImageButton(Button, 0, [this.layers[NextIndex].macros[PreviousIndex].icon.layer, , , 32], [this.layers[NextIndex].macros[PreviousIndex].icon.layer, , , 32])
            }
            return
        }
        ; If previous layer Value has a no macro assigned in the new layer, set to layer icon
         if (this.showMacroMarkers && !(PreviousIndex > this.layers[NextIndex].macros.Length || (PreviousIndex <= this.layers[NextIndex].macros.Length && !this.layers[NextIndex].macros[PreviousIndex]))) {
            CreateImageButton(Button, 0, [this.layers[PreviousIndex].icon.macro, , , 32], [this.layers[PreviousIndex].icon.macro, , , 32])
         } 
         ; else set to layer with macro icon
         else {
            CreateImageButton(Button, 0, [this.layers[PreviousIndex].icon.layer, , , 32], [this.layers[PreviousIndex].icon.layer, , , 32])
         }
    }

    /**
     * @description
     * Sets the icon for a button based on the next layer's icon and macros.
     * If the next layer has a macro assigned for the button, it sets the selected macro icon; otherwise, it sets the selected layer icon.
     * @param {(Number)} Index
     * The index of the newly selected layer.
     * @param {GuiControl} Button
     * The GUI control (button) to set the icon for.
     */
    SetNextLayerIcon(Index, Button) {
        if (this.macroIcons && Index <= this.layers[Index].macros.Length && this.layers[Index].macros[Index] && this.layers[Index].macros[Index].icon) {
            ; If next layer Value has macro assigned,set to selected layer with macro icon
            if (this.showMacroMarkers && Index <= this.layers[Index].macros.Length && this.layers[Index].macros[Index]) {
                CreateImageButton(Button, 0, [this.layers[Index].macros[Index].icon.selectedMacro, , , 32], [this.layers[Index].macros[Index].icon.selectedMacro, , , 32])
            } 
            ; else, set to selected layer icon
            else {
                CreateImageButton(Button, 0, [this.layers[Index].macros[Index].icon.selected, , , 32], [this.layers[Index].macros[Index].icon.selected, , , 32])
            }
            return
        }
        ; If next layer Value has macro assigned,set to selected layer with macro icon
        if (this.showMacroMarkers && Index <= this.layers[Index].macros.Length && this.layers[Index].macros[Index]) {
            CreateImageButton(Button, 0, [this.layers[Index].icon.selectedMacro, , , 32], [this.layers[Index].icon.selectedMacro, , , 32])
        } 
        ; else, set to selected layer icon
        else {
            CreateImageButton(Button, 0, [this.layers[Index].icon.selected, , , 32], [this.layers[Index].icon.selected, , , 32])
        }
    }

    /**
     * @description
     * Sets the text labels for all buttons based on the macros in the specified layer.
     * If a button does not have a macro assigned in the layer, its label is set to an empty string.
     * @param {(Number)} Index
     * The index of the layer to set the labels from.
     * @param {GuiControl[]} Labels
     * An array of GUI controls (labels) to set the text for.
     */
    SetNextLayerLabels(Index, Labels) {
        for (i, label in Labels) {
            if (this.macroIcons) {
                if (i > this.layers.Length || !this.layers[i]) {
                    label.Text := ""
                } 
                else {
                    label.Text := this.layers[i].title
                }
                continue
            }
            ; If new layer has no macro assigned
            if (i > this.layers[Index].macros.Length || !this.layers[Index].macros[i]) {
                label.Text := ""
            } 
            else {
                label.Text := this.layers[Index].macros[i].name
            }
        }
    }

    /**
     * @description
     * Sets the icons for all buttons based on the previous and next layer indices.
     * It updates each button's icon according to whether the layer has macros assigned and the display settings.
     * @param {(Number)} PreviousIndex
     * The index of the previously selected layer.
     * @param {(Number)} NextIndex
     * The index of the newly selected layer.
     * @param {GuiControl[]} Buttons
     * An array of GUI controls (buttons) to set the icons for.
     */
    SetLayerIcons(PreviousIndex, NextIndex, Buttons) {
        for (i, button in Buttons) {
            ; if layer i is blank, skip
            if(this.macroIcons) {
                if (i != PreviousIndex && i != NextIndex && i <= this.layers[NextIndex].macros.Length && this.layers[NextIndex].macros[i] && this.layers[NextIndex].macros[i].icon) {
                    ; If next layer Value has macro assigned,set to selected layer with macro icon
                    if (this.showMacroMarkers && i <= this.layers[NextIndex].macros.Length && this.layers[NextIndex].macros[i]) {
                        CreateImageButton(Button, 0, [this.layers[NextIndex].macros[i].icon.macro, , , 32], [this.layers[NextIndex].macros[i].icon.macro, , , 32])
                    } 
                    ; else, set to selected layer icon
                    else {
                        CreateImageButton(Button, 0, [this.layers[NextIndex].macros[i].icon.layer, , , 32], [this.layers[NextIndex].macros[i].icon.layer, , , 32])
                    }
                    continue
                }
            }
            if (i > this.layers.Length || !this.layers[i]) {
                if (this.showMacroMarkers && i <= this.layers[NextIndex].macros.Length && this.layers[NextIndex].macros[i]) {
                    icon := LayerSelectGui.GetEmptyIcon(this.keys[i])
                    CreateImageButton(Button, 0, [icon, , , 32], [icon, , , 32])
                } else {
                    blank := LayerSelectGui.GetBlankIcon()
                    CreateImageButton(Button, 0, [blank, , , 32], [blank, , , 32])
                }
                continue
            }

            ; Skip the selected layer, it will be updated last
            if (i == NextIndex) {
                continue
            }

            ; Skip updating previous layer only..
            if(PreviousIndex) {            
                ; If both the previous layer and the new layer have no macros assigned to button i
                if((i > this.layers[NextIndex].macros.Length || !this.layers[NextIndex].macros[i]) && (PreviousIndex > this.layers.Length || i > this.layers[PreviousIndex].macros.Length || !this.layers[PreviousIndex].macros[i])) {
                    continue
                }

                ; If both the previous layer and the new layer have macros assigned to button i
                if((i <= this.layers[NextIndex].macros.Length && this.layers[NextIndex].macros[i]) && (PreviousIndex <= this.layers.Length && i <= this.layers[PreviousIndex].macros.Length && this.layers[PreviousIndex].macros[i])) {
                    continue
                }
            }
            
            ; If layer[value].macros[i] has no macro assigned in the new layer, set to layer with macro icon
            if (this.showMacroMarkers && i <= this.layers[NextIndex].macros.Length && this.layers[NextIndex].macros[i]) {
                CreateImageButton(button, 0, [this.layers[i].icon.macro, , , 32], [this.layers[i].icon.macro, , , 32])
            }
            ; else set to layer icon
            else {
                CreateImageButton(button, 0, [this.layers[i].icon.layer, , , 32], [this.layers[i].icon.layer, , , 32])
            }
      }
    }

    /**
     * @description Gets the index number of a Keyname.
     * @param {(String)} Keyname
     * The {@link https://www.autohotkey.com/docs/v2/KeyList.htm|name of a key} used for a macro button.  
     * Controller buttons can be used but none of the others controller inputs.  
     * A virtual code such as `vkFF` can be used for {@link https://www.autohotkey.com/docs/v2/KeyList.htm#SpecialKeys|special cases}.
     * @returns {(Number)}
     * - `0` if the key is the function key.
     * - `1` to `N` if the key is found in the keys array.
     * @throws {Error}
     * If the key is not found in the layout.
     */
    GetKeyIndex(Keyname) {
        if (this.fn.key == Keyname) {
            return 0
        }
        for i, k in this.keys {
            if (k.key == Keyname) {
                return i
            }
        }
        throw Error("Invalid key not found.")
    }

    /**
     * @description Checks if there are no layers or if all layers are blank.
     * @returns {Boolean} 
     * - `true` if there are no layers or all layers are blank.
     * - `false` if there is at least one non-blank layer.
     */
    IsNoLayers() {
        if (this.layers.Length == 0) {
            return true
        } else {
            for (i, layer in this.layers) {
                if (layer) {
                    return false
                }
            }
            return true
        }
    }
}

