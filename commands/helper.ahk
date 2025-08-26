#Requires AutoHotkey v2.0

; ************************* Helper Functions *********************
/**
 * Activates an existing Window or opens a Program if the Window does not exist.
 * @param {String} Window - The Window title or class to check for.
 * @param {String} Program - The Program to run if the Window does not exist.
 * @param {String} [Args=""] - Optional arguments to pass to the Program.
 */
ActivateOrOpen(Window, Program, Args := "")
{
   ; check if Window exists
   if WinExist(Window)
	{
		if WinActive(Window) {
            WinActivateBottom Window ; Uses the last found Window.
        }
        else {
            WinActivate  ; Uses the last found Window.
        }
	}
	else
	{   ; else start requested Program
        if (Args) {
            Run('cmd /c "start ^"^" ^"' Program '^" ^"' Args '^""',,"Hide") ;use cmd in hidden mode to launch requested Program
        }
        else {
            Run('cmd /c "start ^"^" ^"' Program '^""',,"Hide") ;use cmd in hidden mode to launch requested Program
        }
        WinWait(Window,,5)		; wait up to 5 seconds for Window to exist
		
		if WinActive(Window) {
            WinActivateBottom Window ; Uses the last found Window.
        }
        else {
            WinActivate  ; Uses the last found Window.
        }
	}
	return
}

/**
 * Opens a Program and activates its Window.
 * @param {String} Window - The Window title or class to wait for.
 * @param {String} Program - The Program to run.
 * @param {String} [Args=""] - Optional arguments to pass to the Program.
 */
Open(Window, Program, Args := "")
{
    if (Args) {
        Run('cmd /c "start ^"^" ^"' Program '^" ^"' Args '^""',,"Hide") ;use cmd in hidden mode to launch requested Program
    }
    else {
        Run('cmd /c "start ^"^" ^"' Program '^""',,"Hide") ;use cmd in hidden mode to launch requested Program
    }
    WinWait(Window,,5)		; wait up to 5 seconds for Window to exist
    
    WinActivate  ; Uses the last found Window.
}

/**
 * Ensures a Program is running and its Window is active.
 * @param {String} Window - The Window title or class to check for.
 * @param {String} Program - The Program to run if the Window does not exist.
 * @param {String} [Args=""] - Optional arguments to pass to the Program.
 */
EnsureActiveOrOpen(Window, Program, Args)
{
   ; check if Window exists
   if WinExist(Window)
	{
		if !WinActive(Window) {
            WinActivate  ; Uses the last found Window.
        }
	}
	else
	{   ; else start requested Program
        if (Args) {
            Run('cmd /c "start ^"^" ^"' Program '^" ^"' Args '^""',,"Hide") ;use cmd in hidden mode to launch requested Program
        }
        else {
            Run('cmd /c "start ^"^" ^"' Program '^""',,"Hide") ;use cmd in hidden mode to launch requested Program
        }
		WinWait(Window,,5)		; wait up to 5 seconds for Window to exist
		
		if !WinActive(Window) {
            WinActivate  ; Uses the last found Window.
        }
	}
	return
}

/**
 * Runs a Python script with optional arguments.
 * @param {String} ScriptPath - The path to the Python script.
 * @param {String} [Args=""] - Optional arguments to pass to the script.
 */
RunPythonScript(ScriptPath, Args := "")
{
    if (Args) {
        Run('cmd /c "start python ^"^" ^"' ScriptPath '^" ^"' Args '^""',,"Hide") ;use cmd in hidden mode to launch requested Program
    }
    else {
        Run('cmd /c "start python ^"^" ^"' ScriptPath '^""',,"Hide") ;use cmd in hidden mode to launch requested Program
    }
    return
}

/**
 * Runs a PowerShell script with optional arguments.
 * @param {String} ScriptPath - The path to the PowerShell script.
 * @param {String} [Args=""] - Optional arguments to pass to the script.
 */
RunPowerShellScript(ScriptPath, Args := "")
{
    if (Args) {
        Run('cmd /c "start powershell -NoProfile -ExecutionPolicy Bypass -File ^"^" ^"' ScriptPath '^" ^"' Args '^""',,"Hide") ;use cmd in hidden mode to launch requested Program
    }
    else {
        Run('cmd /c "start powershell -NoProfile -ExecutionPolicy Bypass -File ^"^" ^"' ScriptPath '^""',,"Hide") ;use cmd in hidden mode to launch requested Program
    }
    return
}

/**
 * Runs a batch script with optional arguments.
 * @param {String} ScriptPath - The path to the batch script.
 * @param {String} [Args=""] - Optional arguments to pass to the script.
 */
RunBatchScript(ScriptPath, Args := "")
{
    if (Args) {
        Run('cmd /c "start ^"^" ^"' ScriptPath '^" ^"' Args '^""',,"Hide") ;use cmd in hidden mode to launch requested Program
    }
    else {
        Run('cmd /c "start ^"^" ^"' ScriptPath '^""',,"Hide") ;use cmd in hidden mode to launch requested Program
    }
    return
}

/**
 * Displays a message box with the macro's name and description.
 * @param {Macro} Macro - The macro object containing name and description properties.
 */
Message(Macro)
{
   MsgBox(Macro.description, Macro.name)
}

/**
 * Function to let the user know this is still default from the template.
 * @param {Macro} Macro - The macro object (not used in this function).
 */
ReplaceMe(Macro)
{
   MsgBox("Replace " Macro.name " with your own!", Macro.name)
}

/**
 * Encodes an integer value into a memory location.
 * @param {Uint} Ref - The reference to the memory location.
 * @param {Uint} Val - The integer value to encode.
 * @returns {Uint} The result of the DllCall operation.
 */
EncodeInteger(Ref, Val)
{
	return DllCall("ntdll\RtlFillMemoryUlong", "Uint", ref, "Uint", 4, "Uint", val)
}