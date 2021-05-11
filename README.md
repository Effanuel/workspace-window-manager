# workspace-window-manager
Save and load application window layout
## macOS only
How to use this script:
* Open the applications, which state you want to load later (let's say you put Spotify on the left side of the desktop);
* Create config using the command below;
* Read the config using the command below when you want the layout to match the initial one (in this case, Spotify app would get opened and moved to the left side)

Create a config and save it to a json file *(saves to data.json file, only json files are supported)*
```zsh
python main.py --create=data
```

Read config *(reads data.json file)*
```zsh
python main.py --read=data
```


### Note:
* Some apps are not scriptable, so they can't generically be opened using applescript


### TODO:
* print application names when creating a config;
* add fix script which renames appkit lib folder;
* fix dimensions printing;
