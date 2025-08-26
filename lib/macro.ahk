#Requires AutoHotkey v2.0

/**
 * @class
 * @description
 * Represents a macro action.
 */
class Macro {
    /**
     * @description
     * Creates a macro object.
     * @param {(String)} Action 
     * The action to be performed when the macro is triggered.
     * @param {(String)} Name 
     * The name of the macro.
     * @param {(String)} Description
     * A brief description of the macro. Defaults to the name if not provided.
     */
    __New(Action, Name, Description := "", Icon := "") {
        this.action := Action
        this.name := Name
        this.description := Description
        this.icon := Icon
    }
}