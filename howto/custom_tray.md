# Use a tiny indicator that automatically adds your scripts to a menu
Instead of creating multiple watch- procedures for each and every possible event that could take place, I'd suggest using a "one for all" solution like below.

The indicator script automatically adds your scripts to the indicator menu, if you place them in the same directory as the indicator. This way your setup scripts will be easily available from the GUI.

enter image description here

The indicator
#!/usr/bin/env python3
import subprocess
import os
import signal
import gi
gi.require_version('Gtk', '3.0')
gi.require_version('AppIndicator3', '0.1')
from gi.repository import Gtk, AppIndicator3

currpath = os.path.dirname(os.path.realpath(__file__))

class Indicator():
    def __init__(self):
        self.app = 'update_setting'
        iconpath = currpath+"/icon.png"
        self.indicator = AppIndicator3.Indicator.new(
            self.app, iconpath,
            AppIndicator3.IndicatorCategory.SYSTEM_SERVICES)
        self.indicator.set_status(AppIndicator3.IndicatorStatus.ACTIVE)       
        self.indicator.set_menu(self.create_menu())

    def getscripts(self):
        files = [f for f in os.listdir(currpath) if f.endswith(".sh")]
        for f in files:
            fpath = os.path.join(currpath, f)
            subprocess.Popen(["chmod", "+x", fpath])
            menuitem = Gtk.MenuItem(f.split(".")[0])
            menuitem.connect("activate", self.run_script, fpath)
            self.menu.append(menuitem)

    def create_menu(self):
        self.menu = Gtk.Menu()
        self.getscripts()
        # quit
        item_quit = Gtk.MenuItem('Quit')
        sep = Gtk.SeparatorMenuItem()
        self.menu.append(sep)
        item_quit.connect('activate', self.stop)
        self.menu.append(item_quit)
        self.menu.show_all()
        return self.menu

    def run_script(self, widget, script):
        print(script)
        subprocess.Popen(["/bin/bash", "-c", script])

    def stop(self, source):
        Gtk.main_quit()

Indicator()
signal.signal(signal.SIGINT, signal.SIG_DFL)
Gtk.main()
How to use
Copy the script into an empty file, save it as showscripts.py
Copy the icon below (right- click -> save), save it as (exactly) icon.png in one and the same directory as the script

enter image description here

For each of your settings commands, create a small script:

/bin/bash
command_to_run
Name them (no spaces), but make sure to use the .sh extension. Copy or move the scripts into the same folder as where you keep the indicator script.

Now you can make as many menu items (scripts) as you like,

Test- run the indicator by the command:

python3 /path/to/showscripts.py
If all works fine, add to Startup Applications: Dash > Startup Applications > Add. Add the command:

/bin/bash -c "sleep 10 && python3 /path/to/showscripts.py"
Explanation
When the script is launched, it lists all files in its own directory, looking for files with .sh extension. These files are made executable automatically.
For each of these files, the indicator creates a menu item to run it from the menu.
Other options?
The most advanced: writing udev rules for actions, to be taken on specific events. This is however also the most complicated option. Also not the most flexible option in case you want or need to change anything.
Run a background script to check for changes in connected hardware. As far as it is about screen setup, a ready to use example is in this answer.
Combine your commands into one script and run it by a keyboard shortcut. Add shortut key: Choose: System Settings > "Keyboard" > "Shortcuts" > "Custom Shortcuts". Click the "+" and add the command to run the script.
I would however go for the indicator menu. Once setup, you can easily add, remove or edit functionality by simply moving around small scripts.

## Source 
https://askubuntu.com/questions/853028/run-specific-scripts-settings-on-several-occassions-connect-mouse-connect-scre
