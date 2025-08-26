#Requires AutoHotkey v2.0

/**
 * @class
 * @description
 * Represents a layer of macros on the macropad.
 */
class Layer {
    /**
     * @description
     * Creates a layer of macros.
     * @param {(String)} Title
     * Title of the layer.
     * @param {Icon} Icon 
     * Icon object for the layer.
     */
    __New(Title := "", Icon := "", Macros := []) {
        this.title := Title
        this.icon := Icon
        this.macros := Macros
    }
}