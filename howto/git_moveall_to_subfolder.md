# Move existing repositories into subfolders of one repo
  Wanted to reduce the number of axstream repos as it became hard to manage.
  git subtree exists for this purpose but there is one problem. It does it by 
  fetching and doing a git mv to the target sub-dir and the problem here is with
  how git records these moves. Its kind of like a link and git log doesnt play well
  with links now if you wanted get the commits of only one of the subfolder 
  `git log subfolderA/` wont work for some files but NOT folders the --follow option
  is able to find some commits. 

  *Solution:*
  modify the git history of the repo's master branch and move everything to the subfolder for
  each commit. git filter-branch helps with this allowing us to run a command on every commit.
  1. create a new empty repo `git init axstreamOne`
  2. add remotes to the repos we want to bring in as subfolders
     git remote add old_repoA git@github.com:/path/to/repoA.git
     git remote Bdd old_repoB git@github.com:/pBth/to/repoB.git
  3. create a new branch based on target repo
     git checkout -b setup-repoA old_repoA/master
  4. now we want to move all the fils to a subfolder by rewriting the history. Since we are not pushing 
     anything to the remotes they will be fine.
     ```
        git filter-branch --prune-empty --tree-filter '
            /bin/bash -c "if [[ ! -e repoA ]]; then
                mkdir -p ingest;
                git ls-tree --name-only $GIT_COMMIT |
                    grep -ve '^.gitignore$' |
                    xargs -i mv {} ingest;
                fi"'
    ```
    There are problems moving the gitignore so dont do the move for that file. 
  4. repeat 3 and 4 for repoB as well
  5. checkout the master branch
     git merge setup-repoA
     git merge setuo-repoB
     You should now have two folders repoA and repoB and 
     git log --repoA/
     will give you the history of all files in repoA as required.



