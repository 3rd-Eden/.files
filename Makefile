PREFIX ?= /usr/local
HOME ?= ~/

# install the whole .files shizzle and set everything to the correct location
install:
	@git submodule init                                 # init submodules
	@git submodule update --recursive                   # download it's contents
	@cp ./git/git-masspull/git-masspull $(PREFIX)/bin   # install gitmass pull
	@ln -s -f $(CURDIR)/git/.gitconfig $(HOME)          # add the global gitignore
	@ln -s -f $(CURDIR)/vim/.vimrc $(HOME)              # add the .vimrc
	@ln -s -f $(CURDIR)/vim/.vim $(HOME)                # add the .vim directory

.PHONY: install
