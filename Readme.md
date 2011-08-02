#.files

## Configuring git

There are some global configuration options that needs to be set, we cannot
include the `~/.gitconfig` in our repository as it contains our github username
and private token.

```
git config --global core.editor /opt/local/bin/vim
git config --global user.name = 'Arnout Kazemier'
git config --global user.email = 'info@3rd-Eden.com'
```
