# Commands and sources for manual installations on axdev-metis
## 0. Misc packages:
      used ansible to setup nstream framework on the machine
      #TODO: Put this in the ansbile nstream framework configs.
      sudo apt install jq 
      sudo apt install vim

## 1. Docker setup via docker's ubuntu repository
  Eventually we will want to have jenkins master inside a docker container. we will want to use docker compose 
  for updating our custom docker image. Base should ideally be a lts version of the cloudbees jenkins lts image.

  source: https://docs.docker.com/install/linux/docker-ce/ubuntu/#install-docker-ce
  ### SET UP THE REPOSITORY
    1. Update the apt package index:
    
    ```
    $ sudo apt-get update
    ```
    2. Install packages to allow apt to use a repository over HTTPS:
    
    ```
    $ sudo apt-get install \
        apt-transport-https \
        ca-certificates \
        curl \
        software-properties-common
    ```
    3. Add Docker’s official GPG key:
    
    ```
    $ curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    ```
    4. Verify that you now have the key with the fingerprint 9DC8 5822 9FC7 DD38 854A E2D8 8D81 803C 0EBF CD88, by searching for the last 8 characters of the fingerprint.
    
    ```
    $ sudo apt-key fingerprint 0EBFCD88
    
    pub   4096R/0EBFCD88 2017-02-22
          Key fingerprint = 9DC8 5822 9FC7 DD38 854A  E2D8 8D81 803C 0EBF CD88
    uid                  Docker Release (CE deb) <docker@docker.com>
    sub   4096R/F273FCD8 2017-02-22
    ```
    5. Use the following command to set up the stable repository. You always need the stable repository, even if you want to install builds from the edge or test repositories as well. To add the edge or test repository, add the word edge or test (or both) after the word stable in the commands below.
    
    ```
    sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
   ```

## 2. ngrok install and auto start config
### Download , unzip, and move to system location
    1. Download link source: https://ngrok.com/download 
       wget https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip 
       unzip ngrok-stable-linux-amd64.zip
       ls -l ngrok
       #-rwxr-xr-x 1 jenkins jenkins 16117632 Jul 15  2017 ngrok
       # it has the right permissions 
    2. To make our lives easier we would like that the ngrok binary be on path
       the location for non-system managed binaries is /opt/ngrok
       sudo mv ngrok /opt/ngrok/ngrok
       ls -l /opt/ngrok/ngrok
       #-rwxr-xr-x 1 root root 16117632 Oct 17 16:41 /opt/ngrok/ngrok
    3. systemd service config for ngrok
       ```
       jenkins@axdev-metis:~$ cat /etc/systemd/system/ngrokjenkins.service
        [Unit]
        Description=start jenkins tunnel
        After=syslog.target network.target
        Before=jenkins.service

        [Service]
        ExecReload=/bin/kill -HUP $MAINPID
        KillMode=process
        Restart=on-failure
        RestartSec=10s
        Type=simple
        #StandardOutput=null
        #StandardError=null
        ExecStart=/opt/ngrok/ngrok start -config /opt/ngrok/ngrok.yml  jenkins
        ExecStartPost=/bin/bash -c "sleep 30; /usr/bin/curl -s http://localhost:4040/api/tunnels | /usr/bin/jq -r '.tunnels[] | select(.name==\"jenkins\") | .public_url' > /opt/ngrok/jenkins.active"
        ExecStartPost=/bin/cat /opt/ngrok/jenkins.active
        ExecStartPost=/bin/bash -c "url=$(cat /opt/ngrok/jenkins.active); sed -i \"s|\(<jenkinsUrl>\).*\(</jenkinsUrl>\)|\1$url\2|\" /var/lib/jenkins/jenkins.model.JenkinsLocationConfiguration.xml" 
        ExecStopPost=-/bin/rm /opt/ngrok/jenkins.active


        [Install]
        WantedBy=multi-user.target
       ```
       This starts only the tunnel named jenkins you can add specific tunnel names that
       are in the config file here. (look at ngrok documentation)
       Or if you want to start all tunnels that are in the config file then modify
       command to something like: `ngrok start -all -config /path/to/file`

       Notes:
        - ExecStartPost 1: wait enough time for the tunnel to start (30s random pick). using ngrok api get the https jenkins url and save to file
        - ExecStartPost 2: cat the jenkins url. So when you do sudo service ngrokjenkins status you see it in the mesages :)
        - ExecStartPost 3: change the jenkins url in the jenkins config file. Do this before jenkins start so that jenkins updates with it correctly.
        - ExecStartPost 4: (Pending) Send out an email with the new url
        - ExecStopPost 1: remove the jenkins.active file, quick way to know if this process is running. 

    4. config file for ngrok.
       ```
       jenkins@axdev-metis:~$ cat /opt/ngrok/ngrok.yml
       
       tunnels:
         jenkins:
           proto: http
           addr: 8080
           host_header: rewrite

       ```
    5. Command to add it to start process:
       ```
       sudo systemctl enable ngrokjenkins
       ```
       to remove from startup do `disable` instead of enable

    6. Manual start/stop/restart:
       sudo service ngrokjenkins [start|stop|restart|status]
       if you change the service file you need to do this first:
       sudo systemctl daemon-reload
       
    7. When active this puts the jenkins url in /opt/ngrok/jenkins.active
       cat'ng this should give the active url
       ```
       jenkins@axdev-metis:~$ cat /opt/ngrok/jenkins.active
       https://c02d8463.ngrok.io
       ```

## 3. Jenkins installation
  For now doing a standalone installation so its easier to play around with things. Ideally we would want to use a docker image with the home
  directory binded. with standalone was able to have the ngrokjenkins.service start before the jenkins init.d script. This will need to be taken
  care of in another way when using the container option. As we would want the containered jenkins to start as part of boot as well.
  
### Jenkins in a Docker container run as a service.
  Will do this change once the local testing is done. just need to use this systemd script. 
  https://github.com/sekka1/jenkins-docker
  
Note:
  - After need to add ngrokJenkins.service
  - update the ports to map 8080->8080
  - update bind volume to /var/lib/jenkins->/var/jenkins_home

### Standalone setup
  Source: Ubuntu installation of Jenkins LTS: https://pkg.jenkins.io/debian-stable/
  1. This is the Debian package repository of Jenkins to automate installation and upgrade. To use this repository, first add the key to your system:
  ```
  wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -
  ```

  2. Then add the following entry in your /etc/apt/sources.list:
  ` deb https://pkg.jenkins.io/debian-stable binary/ `
  ```
  sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
  ```

  3. sudo apt-get update
  4. sudo apt-get install jenkins

## 4. Configuring jenkins with new featured plugins.
  This step will want to play around with the jenkins plugin that provide infrastructure as code. Jobs as code, and config as code. 
  The idea is that everything needed to develop/configure/maintain jenkins should be possible from pushing a commit to a git repo.
  With this flow we can then also for the critical jobs have jenkins unittests to run the feature branches to help make sure that
  the master doesn't break. 

  Once we have minimum set of plugins we want a clean docker jenkins master to have set the docker file using the link:
    https://github.com/jenkinsci/docker#preinstalling-plugins

  - Setup a git repo locally to use as a remote repo. can move to github or something later. 
  - Install the plugins:
    - pipeline
    - jenkins as code
    - infrastructure as code
    - config as code
    - slack
    - Artifacory 
    - file fingerprinting

  Notes:
    - when we transfer old jobs to the new way we would want to have a jenkinsfile with the pipeline sytanx to:
      - get inputs
      - assign to node or labels
      - env variables
      - stage name division
      - execute a the whole or part of the original jobs bash script. (allows us to have the common used functions in a library script
        we source first and then do jobs. Idea is to seperate the buissness end of things in the pipeline syntax and the bash sources. So
        only importand things related to the job be in the main bash script.)


### configuration-as-code
path: /home/jenkins/vidhatre/configuration-as-code/configs
