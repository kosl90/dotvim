.PHONY: all update update-quiet install-base install-bundles ycm ycm-sys install install-conque install-with-conque clean

YCM_INSTALLER=./bundle/YouCompleteMe/install.py
VIMPROC=./bundle/vimproc.vim

all: install

update:
	vim -c 'PlugUpdate'
	@echo 'vimproc, tern and ycm may need some extra operation'

update-quiet:
	vim -c 'PlugUpdate' -c 'qa!'
	@echo 'vimproc, tern and ycm may need some extra operation'


install-base:
	ln -fs ~/.vim/vimrc ~/.vimrc

install-bundles:
	mkdir -p bundle
	mkdir -p autoload
	curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
		    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

ycm:
	$(YCM_INSTALLER) --clang-completer

ycm-sys:
	$(YCM_INSTALLER) --clang-completer --system-libclang

install-vimproc:
	make -C $(VIMPROC)

install-conque:
	cd ~/.vim/bundle && \
	    git svn clone http://conque.googlecode.com/svn/trunk/ conque

install: install-base install-bundles update
	@echo 'vimproc, tern and ycm need some extra operation'

install-with-conque: install-base install-bundles install-conque update

clean:
	rm -rf *.orig .netrwhist *.sw[op] *~ *.bak \#*\#

# TODO: learn something from haskell-vim-now
install-haskell:
	(cabal update 2> /dev/null || (echo "[Error]: please install cabal-install" && false)) && cabal install happy devtools ghc-mod || :

install-tern:
	cd ~/.vim/bundle/tern_for_vim && npm install
