.PHONY: all update update-quiet install-base install install-conque install-with-conque clean

all: install-base update-quiet

update:
	vim -c 'BundleInstall!'

update-quiet:
	vim -c 'BundleInstall!' -c 'qa!'


install-base:
	ln -s ~/.vim/vimrc ~/.vimrc
	mkdir -p bundle
	cd bundle && git clone https://github.com/gmarik/vundle.git

install-conque:
	cd ~/.vim/bundle && \
	    git svn clone http://conque.googlecode.com/svn/trunk/ conque


install: install-base update

install-with-conque: install-base install-conque update

clean:
	rm -rf *.orig .netrwhist *.sw[op] *~ *.bak \#*\#
