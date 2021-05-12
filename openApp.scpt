on isRunning(appName)
    tell application "System Events" to (name of processes whose background only is true) contains appName
end isRunning

on run argv
    set appName to (item 1 of argv)
    set positionX to (item 2 of argv)
    set positionY to (item 3 of argv)
    set sizeX to (item 4 of argv)
    set sizeY to (item 5 of argv)
    set delayInSeconds to (item 6 of argv)

    if not isRunning(appName) then
        log "Launching " & appName
        tell application appName to activate
        delay delayInSeconds -- some applications take a considerable amount of time to launch
    end if

    tell application "System Events" to tell process appName
        tell windows 1
            set position to {positionX, positionY}
            set size to {sizeX, sizeY}
            perform action "AXRaise"
        end tell
    end tell
end run