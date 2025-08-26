#Requires AutoHotkey v2.0

; *********************** Power & Sleep *********************
/**
 * Send the Turn Monitors Off command
 * @param {Macro} Macro - The macro object (not used in this function).
 */
TurnMonitorsOff(Macro)
{
   Sleep 1000
   SendMessage(0x112,0xF170,2,,"Program Manager")
}

/**
 * Send the Lock command
 * @param {Macro} Macro - The macro object (not used in this function).
 */
Lock(Macro)
{
   DllCall("LockWorkStation")
}

/**
 * Send the Sleep command
 * @param {Macro} Macro - The macro object (not used in this function).
 */
WinSleep(Macro)
{
    DllCall("PowrProf\SetSuspendState", "Int", 0, "Int", 0, "Int", 0)
}

/**
 * Send the Hibernate command
 * @param {Macro} Macro - The macro object (not used in this function).
 */
Hibernate(Macro)
{
    DllCall("PowrProf\SetSuspendState", "Int", 1, "Int", 0, "Int", 0)
}

/**
 * Send the Restart command
 * @param {Macro} Macro - The macro object (not used in this function).
 */
Restart(Macro)
{
   DllCall("ExitWindowsEx", "UInt", 2, "UInt", 0)
}

/**
 * Send the Shutdown command
 * @param {Macro} Macro - The macro object (not used in this function).
 */
Shutdown(Macro)
{
   Run("shutdown /s /t 1")
}