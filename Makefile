.PHONY: update update-quite install install-conque install-with-conque

update:
	vim -c 'BundleInstall!'

update-quiet:
	vim -c 'BundleInstall!' -c 'qa!'

install:
	mkdir -p bundle
	cd bundle && git clone https://github.com/gmarik/vundle.git
	ln -s ~/.vim/vimrc ~/.vimrc
	vim -c 'BundleInstall!'

install-conque:
	cd ~/.vim/bundle && \
	    git svn clone http://conque.googlecode.com/svn/trunk/ conque

install-with-conque: install install-conque
