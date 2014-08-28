.PHONY: all update update-quiet install-base install install-conque install-with-conque clean

all: install-base update-quiet

update:
	vim -c 'BundleInstall!'

update-quiet:
	vim -c 'BundleInstall!' -c 'qa!'


install-base:
	ln -fs ~/.vim/vimrc ~/.vimrc
	ln -fs ~/.vim/vimrc.bundles ~/.vimrc.bundles
	ln -fs ~/.vim/vimrc.bundles.local ~/.vimrc.bundles.local
	ln -fs ~/.vim/vimrc.local ~/.vimrc.local
	mkdir -p bundle
	cd bundle && git clone https://github.com/gmarik/vundle.git 2> /dev/null || :

install-conque:
	cd ~/.vim/bundle && \
	    git svn clone http://conque.googlecode.com/svn/trunk/ conque


install: install-base update

install-with-conque: install-base install-conque update

clean:
	rm -rf *.orig .netrwhist *.sw[op] *~ *.bak \#*\#
