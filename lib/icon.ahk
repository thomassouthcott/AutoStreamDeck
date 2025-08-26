#Requires AutoHotkey v2.0

/**
 * @class
 * @description
 * Represents an icon with different states for a UI.
 */
class Icon {
    /**
     * @description
     * Creates an Icon object with paths to the icon images.
     * @param {(String)} name
     * The name of the icon folder inside img/ 
     */
    __New(name) {
        this.layer := "img/" name "/layer.png"
        this.macro := "img/" name "/macro.png"
        this.selected := "img/" name "/selected.png"
        this.selectedMacro := "img/" name "/selected_macro.png"
    }
}
