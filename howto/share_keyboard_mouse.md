# Switch machines but use same keyboard and mouse
  Lately, having to switch between my laptop and Ubuntu machine. The constant switching 
  became annoying and sought out a way to get my macbooks keyboard and mouse to be usable
  on the Desktop. This way I can work on the portable stuff on my laptop and still be able
  to do the minor checks for stuff on my desktop. 

  This was achievable through a software 'synergy' by some company called 'symless'. The
  softawre is paid if downloading from the website. But since its open source they said 
  its free to use if you compile it yourselves. Basically, manual compile is the difference
  between free and paid. (Maybe some advanced features i dont need them anyway.)

  The company in trying to make the free software more restrictive moved the gui components
  to their closed source version from version `2.0.0`. So just to be able to have the nicer
  gui I decided to install version `v1.9.1-stable`.

## 1. Clone the repo
  All my work is usually in a ~/projects directory. I prefer to move anything I run there.
  ```bash
  cd ~/projects
  git clone git@github.com:symless/synergy-core.git .
  cd synergy-core/
  git checkout v1.9.1-stable
  ```

## 2. Install requirements
  Follow instruction from: https://github.com/symless/synergy-core/wiki/Compiling
  Note: 
    I think its better to the compile from command line instead of the Qt tool.
    See if you can skip the install of the Qt related stuff. Just install the 
    other tool and follow instruction for CLI compile/build.

## 3. Compilation
  The wiki linked above has instruction for both IDE build and CLI build. I think CLI
  is faster and easier. 
  Install this on all sharing machines.

### Windows
  ```
  cd projects\synergy-core
  mkdir build
  cd build
  call "C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\vcvarsall.bat"
  cmake -G "Visual Studio 14 2015 Win64" -DCMAKE_BUILD_TYPE=%CMAKE_BUILD_TYPE% ..
  msbuild synergy-core.sln /p:Platform="x64" /p:Configuration=%CMAKE_BUILD_TYPE% /m
  ```

### macOS
  ```
  cd projects/synergy-core
  mkdir build
  cd build
  QT_PATH=$HOME/Qt/5.9.3/clang_64
  export PATH=$PATH:/usr/local/bin:$QT_PATH/bin
  #cmake -DCMAKE_OSX_SYSROOT=/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.12.sdk -DOSX_TARGET_MAJOR=10 -DOSX_TARGET_MINOR=12 -DCMAKE_OSX_ARCHITECTURES=x86_64 ..
  cmake  -DCMAKE_OSX_DEPLOYMENT_TARGET=10.10 -DCMAKE_OSX_ARCHITECTURES=x86_64 -DCMAKE_BUILD_TYPE=$CMAKE_BUILD_TYPE -DCMAKE_CONFIGURATION_TYPES=$CMAKE_BUILD_TYPE ..
  make
  ```

### Linux
  ```
  cd projects/synergy-core
  mkdir build
  cd build
  cmake ..
  make
  ```

## 4. Running
  - execute the `synergy-core/build/bin/synergy` binary
  - The select cancel on activation.
  - In the gui for the client set the name of the client machine, and also the server ip.
  - in the gui for the server set, go to the server config and add the screen of the new machine, make sure you name it same as above.
  - Start both the client and server. you should be good to go. 

## 5. Improvements/Work to polish this setup
  - Figure out how to use configuration files. That way can use the latest version.
    https://github.com/symless/synergy-core/wiki/Text-Config

  - The macbook will need a static ip or some name that can be resolved, otherwise will need to keep changing client's config


# Sources:
  - https://github.com/symless/synergy-core/wiki
