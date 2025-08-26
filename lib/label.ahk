#Requires AutoHotkey v2.0

/**
 * @class
 * @description
 * Represents a key label on the macropad.
 */
class Label {
    /**
     * @description
     * A rectangular label area
     * @param {(Number)} X 
     * Refers to the x coordinate of the top-left corner
     * @param {(Number)} Y 
     * Refers to the y coordinate of the top-left corner
     * @param {(Number)} W 
     * Refers to the width of the label
     * @param {(Number)} H 
     * Refers to the height of the label
     */
    __New(X, Y, W, H) {
        this.x := X
        this.y := Y
        this.w := W
        this.h := H
    }
}
