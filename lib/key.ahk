#Requires AutoHotkey v2.0

#Include label.ahk

/**
 * @class
 * @description
 * Represents a key on the macropad.
 */
class Key {
    /**
     * @description
     * Creates a Key object representing a key on the macropad.
     * @param {(String)} KeyName
     * The {@link https://www.autohotkey.com/docs/v2/KeyList.htm|name of a key} used for selection.  
     * Controller buttons can be used but none of the others controller inputs.  
     * A virtual code such as `vkFF` can be used for {@link https://www.autohotkey.com/docs/v2/KeyList.htm#SpecialKeys|special cases}.
     * @param {(Number)} Row 
     * Refers row number on the macropad (Rows are top to bottom).
     * @param {(Number)} Col
     * Refers column number on the macropad (Columns are left to right).
     * @param {(Number)} Width 
     * Refers to how many keys wide the key is (1 key = 1 unit).
     * @param {(Number)} Height 
     * Refers to how many keys tall the key is (1 key = 1 unit).
     */
    __New(Keyname, Row := 1, Col := 1, Width := 1, Height := 1) {
        this.width := Width
        this.height := Height
        this.row := Row
        this.col := Col
        this.key := Keyname
        this.CalculateUnlabelledPosition()
    }

    CalculateLabelledPosition() {
        this.label := Label((this.col - 1) * 64, (this.row - 1) * 83, 64 * this.width, 17)
        this.x := this.label.x
        this.y := this.label.y + 17
        this.w := this.label.w
        this.h := 64 * this.height + (this.height - 1) * 17
    }

    CalculateUnlabelledPosition() {
        this.label := Label(0, 0, 0, 0)
        this.x := (this.col - 1) * 64
        this.y := (this.row - 1) * 64
        this.w := 64 * this.width
        this.h := 64 * this.height
    }
}