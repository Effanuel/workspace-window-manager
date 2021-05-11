# workspace-window-manager

Save and load application window layout

## macOS only

How to use this script:

- Open the applications, which state you want to load later (let's say you put Spotify on the left side of the desktop);
- Create config using the command below;
- Read the config using the command below when you want the layout to match the initial one (in this case, Spotify app would get opened and moved to the left side)

Create a config and save it to a json file _(saves to data.json file, only json files are supported)_

```zsh
python main.py --create=data
```

Read config _(reads data.json file)_

```zsh
python main.py --read=data
```

### Note:

- Some apps are not scriptable, so they can't generically be opened using applescript

### TODO:

- Test it
