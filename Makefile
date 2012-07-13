PREFIX ?= /usr/local
HOME ?= ~/
MACPORTS ?= $(shell which port)

target: symlink

# Dependencies:
# These pieces of software are required for the full installation of all the
# required code.
#
# @TODO automatically install mac ports
# @TODO automatically install and configure VIM with clipboard support
dependencies:
# rake is required for the .dotjs chrome extension, and might be commonly used
# by other software as it's an alternate to Make
ifeq ($(shell which rake), )
	@echo "  - Installing rake"
	@sudo gem install rake
endif

# Exuberant Ctags is required for the vim tag list plugin, it's an updated
# version of ctags that is shipped on unix by default.
ifneq ($(shell which port), )
	@echo "  - Installing Exuberant ctags"
	@sudo port install ctags
endif

# Make sure we have curl installed
ifeq ($(shell which curl), )
	@echo "  - Installing curl"
	@sudo port install curl
endif

# Installation:
# Install all the .sh files and git submodules so our env. will be a bit easier
# to work with, and it will look pretty as well <3.
#
# @TODO install jshint for syntasic (npm install jshint -g)
# @TODO install csslint for syntastic (npm install csshint -g)
install:
	@$(MAKE) dependencies                                                              # install the dependencies
	@git submodule init                                                                # init submodules
	@git submodule update --recursive                                                  # download it's contents
	@sudo cp ./tools/n/bin/n $(PREFIX)/bin                                             # install n for node.js version management
	@sudo n stable                                                                     # install the latest node.js stableA
	@curl http://npmjs.org/install.sh | sudo sh                                        # install npm, node package management
	@cd ./git/git-extras && sudo make install                                          # install git-extras
	@cd ./tools/spot && sudo make install                                              # install spot search util
ifeq ($(shell which rake), )
	@cd ./tools/dotjs && rake install                                                  # install .js folder extenstion
endif
	@rm -rf $(HOME)/.oh-my-zsh && cd ./zsh/ohmy/tools && sh install.sh                 # install zsh
	@$(MAKE) symlink                                                                   # install all the symlinks

# Symlinking:
# Update the symlinks to all the possible .dot files so they are used from this
# directory and not an other one.
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

.PHONY: symlink install uninstall dependencies
