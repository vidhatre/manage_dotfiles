## Issues faced while setting-up/dealing-with jenkins jobs
Put all Jenkins info here. 
Basically local jenkins on thebe is very delicate, I want to document all the ways we are keeping it running 

1. Had an issue where thinBackup plugin was trying to restart jenkins(not really wanted to go to quiet mode)
   we did not want that to happen. But werent able to kill the pluggin 
   Followed instructions from here,
   https://stackoverflow.com/questions/14456592/how-to-stop-an-unstoppable-zombie-job-on-jenkins-without-restarting-the-server

        I use the Monitoring Plugin for this task. 
             https://wiki.jenkins-ci.org/display/JENKINS/Monitoring     

        After the installation of the plugin

        Go to Manage Jenkins > Monitoring of Hudson/Jenkins master
        Expand the Details of Threads, the small blue link on the right side
        Search for the Job Name that is hung

        The Thread's name will start like this

        Executor #2 for master : executing <your-job-name> #<build-number>

        Click the red, round button on the very right in the table of the line your desired job has

   the first two comments are about using the script console but i dont know how to write groovey scripts.

2. When we seleted the option to delete the workspaces for only one job. The Workspace cleanup plugin 
   checked the workspace of all jobs. In the process it deleted files from a workspace where we were storing 
   logs of really old runs. Whose job did not use that plugin.
