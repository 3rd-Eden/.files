PREFIX ?= /usr/local
HOME ?= ~/

# install all the shizzle
install:
	@git submodule init                                                                # init submodules
	@git submodule update --recursive                                                  # download it's contents
	@cp ./git/git-masspull/git-masspull $(PREFIX)/bin                                  # install gitmass pull
	@cd ./git/git-extras && make install                                               # install git-extras
	@cd ./zsh/ohmy/tools && sh install.sh                                              # install zsh

# update and all symlinks
symlink:
	@ln -s -f $(CURDIR)/zsh/.zshrc $(HOME)                                             # add the .zshrc
	@ln -s -f $(CURDIR)/zsh/.zsh $(HOME)                                               # add the .zsh custom plugins
	@ln -s -f $(CURDIR)/zsh/.zsh/themes/* $(HOME)/.oh-my-zsh/themes                    # add my custom zsh themes
	@ln -s -f $(CURDIR)/git/.gitconfig $(HOME)                                         # add the global gitignore
	@ln -s -f $(CURDIR)/vim/.vimrc $(HOME)                                             # add the .vimrc
	@ln -s -f $(CURDIR)/vim/.vim $(HOME)                                               # add the .vim directory

uninstall:
	@uninstall_oh_my_zsh                                                               # remove zsh again

.PHONY: symlink install uninstall
