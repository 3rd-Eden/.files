PREFIX ?= /usr/local
HOME ?= ~/

target: dependencies install symlink

# install dependencies for the installation
dependencies:
	@gem install rake                                                                  # required for dotjs

# install all the shizzle
install:
	@git submodule init                                                                # init submodules
	@git submodule update --recursive                                                  # download it's contents
	@cp ./tools/n/bin/n $(PREFIX)/bin                                                  # install n for node.js version management
	@n stable                                                                          # install the latest node.js stableA
	@curl http://npmjs.org/install.sh | sh                                             # install npm, node package management
	@cd ./git/git-extras && make install                                               # install git-extras
	@cd ./tools/spot && make install                                                   # install spot search util
	@cd ./tools/dotjs && rake install                                                  # install .js folder extenstion
	@cd ./zsh/ohmy/tools && sh install.sh                                              # install zsh

# update and all symlinks
symlink:
	@ln -s -f $(CURDIR)/zsh/.zshrc $(HOME)                                             # add the .zshrc
	@ln -s -f $(CURDIR)/zsh/.zsh $(HOME)                                               # add the .zsh custom plugins
	@ln -s -f $(CURDIR)/zsh/.zsh/themes/* $(HOME)/.oh-my-zsh/themes                    # add my custom zsh themes
	@ln -s -f $(CURDIR)/git/.gitconfig $(HOME)                                         # add the global gitignore
	@ln -s -f $(CURDIR)/vim/.vimrc $(HOME)                                             # add the .vimrc
	@ln -s -f $(CURDIR)/vim/.vim $(HOME)                                               # add the .vim directory
	@ln -s -f $(CURDIR)/.jshintrc $(HOME)                                              # add the .jshintrc
	@ln -s -f $(CURDIR)/.js $(HOME)                                                    # add the .js folder

uninstall:
	@uninstall_oh_my_zsh                                                               # remove zsh again
	@cd ./tools/dotjs && rake uninstall                                                # remove dotjs again
	@cd ./tools/n && make uninstall                                                    # remove n

.PHONY: symlink install uninstall
