.PHONY: all update update-quiet install-base install-bundles install-ycm install-ycm-sys install install-conque install-with-conque clean

YCM_INSTALLER=./bundle/YouCompleteMe/install.py
VIMPROC=./bundle/vimproc.vim

all: install

update:
	vim -c 'BundleInstall!'

update-quiet:
	vim -c 'BundleInstall!' -c 'qa!'


install-base:
	ln -fs ~/.vim/vimrc ~/.vimrc

install-bundles:
	mkdir -p bundle
	cd bundle && git clone https://github.com/gmarik/vundle.git 2> /dev/null || :

install-ycm:
	$(YCM_INSTALLER) --clang-completer

install-ycm-sys:
	$(YCM_INSTALLER) --clang-completer --system-libclang

install-vimproc:
	make -C $(VIMPROC)

install-conque:
	cd ~/.vim/bundle && \
	    git svn clone http://conque.googlecode.com/svn/trunk/ conque

install: install-base install-bundles update

install-with-conque: install-base install-bundles install-conque update

clean:
	rm -rf *.orig .netrwhist *.sw[op] *~ *.bak \#*\#

# pass CMD from outside.
install-haskell:
	sudo $(CMD) cabal-install
	cabal update
	cabal install happy devtools ghc-mod

install-tern:
	cd ~/.vim/bundle/tern_for_vim && npm install
