tell application "System Events"
    set processes_ref to a reference to (processes whose background only is false and visible is true and front window's class = window)

    set theApplications to {}
    set sizes to {}
    set positions to {}
    set ignoredApplications to false
    repeat with theItem in processes_ref
        if (count of window of theItem = 1) then -- ignore applications if there is more than 1 window
            set end of theApplications to name of theItem
            set end of sizes to size of window of theItem
            set end of positions to position of window of theItem
        else
            set ignoredApplications to true
        end if
    end repeat
    return [ignoredApplications, count of theApplications, theApplications, sizes, positions]
end tell