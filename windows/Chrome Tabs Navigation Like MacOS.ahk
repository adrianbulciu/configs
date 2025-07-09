#Requires AutoHotkey v2.0

#SingleInstance Ignore ; Prevents duplicate script instances

#!Left:: SwitchBrowserTab("left")
#!Right:: SwitchBrowserTab("right")

SwitchBrowserTab(direction) {
    activeExe := WinGetProcessName("A")

    ; List of supported browsers
    for browser in ["chrome.exe", "msedge.exe", "firefox.exe"] {
        if (activeExe = browser) {
            if direction = "left"
                Send("^+{Tab}")  ; Ctrl+Shift+Tab = Previous tab
            else if direction = "right"
                Send("^{Tab}")   ; Ctrl+Tab = Next tab
            break
        }
    }
}
