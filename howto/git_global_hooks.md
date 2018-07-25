#Create git hooks to be used by all local repos
-----------------------------------------------

  - The template directory will be used as reference when doing a git init.
  - Existing repos you will need to do git init again after you update the template directory.
  - The template files wont overwrite files manually edited in the .git folder, so you'll need 
      delete changes if needed.
  - ```git config --global init.templatedir '~/.git.d/git-templates'```
  - ```mkdir ~/.git.d/git-templates/hooks```
  - Create a hook. ``` vi git-templates/hooks/post-merge```
  - Make it executable. ```chmod a+x ~/.git-templates/hooks/post-commit```
  - Update the repos. Do ```git init``` in each repo.

## Sources
- https://git-scm.com/book/en/v2/Customizing-Git-Git-Hooks
- https://git-template.readthedocs.io/en/latest/
- https://gist.github.com/sepehr/71347d757ee67afc4166
