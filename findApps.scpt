tell application "System Events"
    set processes_ref to a reference to (processes whose background only is false and visible is true and front window's class = window)
    set windows_ref to a reference to windows of processes_ref

    set theList to {}
    set theApplications to {}
    set ignoredApplications to false
    repeat with theItem in processes_ref
        if (count of window of theItem = 1) then
            set end of theList to size of window of theItem
            set end of theApplications to name of theItem
        else
            set ignoredApplications to true
        end if
    end repeat

    set sizes to {}
    set positions to {}
    repeat with theItem in processes_ref
        if (count of window of theItem = 1) then
            set end of sizes to size of window of theItem
            set end of positions to position of window of theItem
        end if
    end repeat
    return [ignoredApplications, count of theApplications, theApplications, sizes, positions]
end tell