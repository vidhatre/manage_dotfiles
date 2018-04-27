# Send email alert when any kind of (pam)login happens
Since the sshrc method doesn't work if the user has their own ~/.ssh/rc file, I'll explain how to do this with pam_exec as @adosaiguas suggested. The good thing is that this can also be easily adapted to login types other than ssh (such as local logins or even all logins) by hooking into a different file in /etc/pam.d/.

First you need to be able to send mail from the command line. There are other questions about this. On a mail server it's probably easiest to install mailx (which is probably already installed anyway).

Then you need an executable script file login-notify.sh (I put it in /etc/ssh/ for example) with the following content. You can change the variables to change the subject and content of the e-mail notification. Don't forget to execute chmod +x login-notify.sh to make it executable.

```bash
#!/bin/sh

# Change these two lines:
sender="sender-address@example.com"
recepient="notify-address@example.org"

if [ "$PAM_TYPE" != "close_session" ]; then
    host="`hostname`"
    subject="SSH Login: $PAM_USER from $PAM_RHOST on $host"
    # Message to send, e.g. the current environment variables.
    message="`env`"
    echo "$message" | mailx -r "$sender" -s "$subject" "$recepient"
fi
```

Once you have that, you can add the following line to /etc/pam.d/sshd:

```
session optional pam_exec.so seteuid </path/to/login-notify.sh>
```
Replace <> with the right path.

For testing purposes, the module is included as optional, so that you can still log in if the execution fails. After you made sure that it works, you can change optional to required. Then login won't be possible unless the execution of your hook script is successful (if that is what you want).


### Warning
As always when you change the login configuration, leave a backup ssh session open in the background and test the login from a new terminal.

# Debug
### on centos 
Look at /var/log/secure

# Source
https://askubuntu.com/questions/179889/how-do-i-set-up-an-email-alert-when-a-ssh-login-is-successful
