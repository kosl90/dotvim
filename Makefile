.PHONY: all update update-quiet install-base install-bundles install-ycm install-ycm-sys install install-conque install-with-conque clean

all: install-base update-quiet

update:
	vim -c 'BundleInstall!'

update-quiet:
	vim -c 'BundleInstall!' -c 'qa!'


install-base:
	ln -fs ~/.vim/vimrc ~/.vimrc
	ln -fs ~/.vim/vim.bundles ~/.vim.bundles
	ln -fs ~/.vim/vim.bundles.local ~/.vim.bundles.local
	ln -fs ~/.vim/vim.local ~/.vim.local

install-bundles:
	mkdir -p bundle
	cd bundle && git clone https://github.com/gmarik/vundle.git 2> /dev/null || :

install-ycm:
	./bundle/YouCompleteMe/install.sh --clang-completer

install-ycm-sys:
	./bundle/YouCompleteMe/install.sh --clang-completer --system-libclang

install-conque:
	cd ~/.vim/bundle && \
	    git svn clone http://conque.googlecode.com/svn/trunk/ conque

install: install-base install-bundles update

install-with-conque: install-base install-bundles install-conque update

clean:
	rm -rf *.orig .netrwhist *.sw[op] *~ *.bak \#*\#
