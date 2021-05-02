tell application "System Events"
    set processes_ref to a reference to (processes whose background only is false and visible is true and front window's class = window)
    set windows_ref to a reference to windows of processes_ref
    return [count of processes_ref's name, count of windows_ref, processes_ref's name, windows_ref's size, windows_ref's position]
end tell