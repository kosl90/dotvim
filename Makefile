.PHONY: update update-quite install

update:
	vim -c 'BundleInstall!'

update-quiet:
	vim -c 'BundleInstall!' -c 'qa!'

install:
	mkdir -p bundle
	cd bundle && git clone https://github.com/gmarik/vundle.git \
	    && git svn clone http://conque.googlecode.com/svn/trunk/ conque
	vim -c 'BundleInstall!'

