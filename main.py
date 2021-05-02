import os
import subprocess
import json
import sys
import getopt
import AppKit

APP_NAMES_MAP = {
    "Electron": "Code" # open 
}
# tell application "System Events" to tell process "Code"
#     tell window 1
#         set size to {1024, 768}
#         set position to {100, 100}
#     end tell
# end tell

UNSUPPORTED_APPS = ['Finder', 'Teams']

def execute(command: tuple[str]):
    try:
        bytecode = subprocess.check_output(command)
        return bytecode.decode('UTF-8').rstrip().split(', ')
    except:
        print(f'Error executing command: {command}')
        sys.exit(1)

def get_screen_dimensions() -> str:
    screens = AppKit.NSScreen.screens()
    width_sum = int(sum([screen.frame().size.width for screen in screens]))
    height_sum = int(sum([screen.frame().size.height for screen in screens]))
    return f"{width_sum}x{height_sum}"

def save_to_json(data, name: str) -> None:
    with open(f'{name}.json', 'w') as outfile:
        json.dump(data, outfile, indent=2)

def read_json(name: str) -> dict:
    with open(f'{name}.json') as f:
        data = json.load(f)
        return data

def create_config(config_name: str) -> None:
    result = execute(('osascript', './findApps.scpt'))
    applicationsCount = int(result.pop(0))
    window_count = int(result.pop(0))
    print(result)
    if window_count > applicationsCount:
        print("Multiple windows for the same application are not supported.")
        sys.exit(1)
    [applicationNames, bounds] = [result[:applicationsCount], result[applicationsCount:]]

    apps = {}
    for i, name in enumerate(applicationNames):
        if name in UNSUPPORTED_APPS:
            print(f"Unsupported app found: {name}.")
            continue

        sizeSlice = i * 2
        positionSlice = (i * 2) + 2 * applicationsCount
        
        width, height = bounds[sizeSlice:sizeSlice + 2]
        x, y = bounds[positionSlice:positionSlice + 2]

        apps[name] = {"x": x, "y": y, "width": width, "height": height}

    dimensions = get_screen_dimensions()
    save_to_json({"apps": apps, "dimensions": dimensions}, config_name)

    print(f'Configuration ./{config_name}.json for dimensions {dimensions} was created.')

def read_config(filename: str) -> None:
    def open_app(name: str, value) -> None:
        x, y, width, height = value['x'], value['y'], value['width'], value['height']
        execute(('osascript',  './openApp.scpt',  f"{name}", x, y, width, height))

    config = read_json(filename)['apps'].items()
    [open_app(key, value) for key, value in config if key not in UNSUPPORTED_APPS]

def main():
    options, remainder = getopt.getopt(sys.argv[1:], 'c:r:', ['create=', 'read='])
    for opt, arg in options:
        if opt in ('-c', '--create'):
            create_config(arg)
            break
        if opt in ('-r', '--read'):
            read_config(arg)
            break

if __name__ == '__main__':
    main()

#1. find all open applications and their positions and save them # create_config()
#2. Read from config and open applications