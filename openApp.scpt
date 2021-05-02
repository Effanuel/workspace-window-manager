on isRunning(appName)
    tell application "System Events" to (name of processes whose background only is true) contains appName
end isRunning

on run argv
    set appName to (item 1 of argv)
    set appRunning to isRunning(appName)
    if not appRunning then
        log "Launching " & appName
        tell application appName to activate
    end if

    
    if (appName = "iTerm2") then
        tell application "iTerm2"
            create window with default profile
        end tell
    end if


    tell application "System Events" to tell process appName
        tell windows 1
            set position to {item 2 of argv, item 3 of argv}
            set size to {item 4 of argv, item 5 of argv}
            perform action "AXRaise"
        end tell
    end tell
end run