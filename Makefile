PREFIX ?= /usr/local
HOME ?= ~/

# install the whole .files shizzle and set everything to the correct location
install:
	@git submodule init                                 # init submodules
	@git submodule update --recursive                   # download it's contents
	@cp ./git/git-masspull/git-masspull $(PREFIX)/bin   # install gitmass pull
	@cd ./git/git-extras && make install                # install git-extras
	@cd ./zsh/ohmy/tools && sh install.sh               # install zsh
	@ln -s -f $(CURDIR)/zsh/.zshrc $(HOME)              # add the .zshrc
	@ln -s -f $(CURDIR)/zsh/.zsh $(HOME)                # add the .zsh custom plugins
	@ln -s -f $(CURDIR)/git/.gitconfig $(HOME)          # add the global gitignore
	@ln -s -f $(CURDIR)/vim/.vimrc $(HOME)              # add the .vimrc
	@ln -s -f $(CURDIR)/vim/.vim $(HOME)                # add the .vim directory

uninstall:
	@uninstall_oh_my_zsh                                # remove zsh again

.PHONY: install
