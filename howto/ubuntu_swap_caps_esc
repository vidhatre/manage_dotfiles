# Swap capslock and esc keys on keyboard
We spend more time in programs like vi, that have a frequent use of 
the escape key but rarely use the capslock key.
So naturally it makes sense to swap them.

## Tools used here:
- dconf-editor (`sudo apt install dconf-tools`)

## Instructions:
#### Manually
- start dconf-editor, can do from system gui.
- navigate to: org >> gnome >> desktop >> input-sources
- modify xkb-options, add to list: 'caps:swapescape':W

#### Commandline
- `dconf write /org/gnome/desktop/input-sources/xkb-options "['caps:swapescape']"`
- Note: Don't use sudo. This will by default setup as user specific change

## Source
- https://askubuntu.com/questions/363346/how-to-permanently-switch-caps-lock-and-esc

## Aditional tweaks:
- you can learn about other options from man page: `man 7 xkeyboard-config`

