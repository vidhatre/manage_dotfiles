# Install Hub
 1. Download Hub from Github

https://github.com/github/hub/releases

 2. Extract it. I've extracted it to Apps/ directory in my home and renamed it to hub-linux. So, in my setup, the complete path to the bin folder is /home/anwar/Apps/hub-linux/bin

 3. Now open the ~/.bashrc file and add the hub binary path to the $PATH environment variable. Adding a line like below will work.
    ```bash
    ### Adds Hub-linux
    export PATH="$PATH:$HOME/Apps/hub-linux/bin/"
    ```
    Don't forget to to use actual path in your setup

# Add the Bash Completion
To add bash completion, we need to tell bash to source the completion file came with hub-archive. The completion file is in the etc folder of the extracted hub folder. To do so,

Open the .bashrc and write there these lines

		```bash
		### Load Hub Linux bash completion
		if [ -f $HOME/Apps/hub-linux/etc/hub.bash_completion.sh ] ; then
		     . $HOME/Apps/hub-linux/etc/hub.bash_completion.sh
		fi
		```
Don't forget to replace the exact path of hub.bash_completion.sh file according to your setup

Now, You should be able to use hub bash completion

# Add Hub's manpage to man database
Hub's man page actually came with the archive. It's in the share folder. To add the manpage, we need to put it in the man page directory.

To do so, Open a terminal and cd to the extracted hub archive. Assuming your current directory is in the same directory where hub's bin, share, README.md reside, use this command to copy the manpage
    ```bash
    sudo cp -r share/ /usr/
    sudo chmod 644 /usr/share/man/man1/hub.1
    ```
Now you can use hub's manual page using man hub command.

If you can't immediately use man hub, use sudo updatedb to refresh man db of the system.

# Source
- https://askubuntu.com/a/816580/814053
