#Requires AutoHotkey v2.0

; ************************* Media Functions *********************
/***
 * @description Sends the Media Previous Track command.
 * @param {Macro} Macro - The macro object (not used in this function).
 */
PreviousTrack(Macro) {
    Send("{Media_Prev}")
}

/***
 * @description Sends the Media Play/Pause command.
 * @param {Macro} Macro - The macro object (not used in this function).
 */
PlayPause(Macro) {
    
    Send("{Media_Play_Pause}")
}

/***
 * @description Sends the Media Next Track command.
 * @param {Macro} Macro - The macro object (not used in this function).
 */
NextTrack(Macro) {
    Send("{Media_Next}")
}

/***
 * @description Sends the Volume Down command.
 * @param {Macro} Macro - The macro object (not used in this function).
 */
VolumeDown(Macro) {
    Send("{Volume_Down}")
}

/***
 * @description Sends the Volume Up command.
 * @param {Macro} Macro - The macro object (not used in this function).
 */
VolumeUp(Macro) {
    Send("{Volume_Up}")
}