" Vim syntax file example
" Put it to ~/.vim/after/syntax/ and tailor to your needs.

let glib_deprecated_errors = 1
let gobject_deprecated_errors = 1
let gdk_deprecated_errors = 1
let gdkpixbuf_deprecated_errors = 1
let gtk_deprecated_errors = 1
let gimp_deprecated_errors = 1

if version < 600
  so <sfile>:p:h/glib.vim
  so <sfile>:p:h/gobject.vim
  so <sfile>:p:h/gdk.vim
  so <sfile>:p:h/gdkpixbuf.vim
  so <sfile>:p:h/gtk.vim
  so <sfile>:p:h/gimp.vim
else
  " runtime! syntax/glib.vim
  " runtime! syntax/gobject.vim
  " runtime! syntax/gdk.vim
  " runtime! syntax/gdkpixbuf.vim
  " runtime! syntax/gtk.vim
  " runtime! syntax/gimp.vim
  " runtime! syntax/cairo.vim
  " runtime! syntax/gtk2.vim
  " runtime! syntax/gtk3.vim
  " runtime! syntax/pango.vim
  " runtime! syntax/libnotify.vim
  " runtime! syntax/gnomedesktop.vim
  " runtime! syntax/jsonlib.vim
  runtime! syntax/atk.vim
  runtime! syntax/gdkpixbuf.vim
  runtime! syntax/gtk3.vim
  runtime! syntax/libsoup.vim
  runtime! syntax/atspi.vim
  runtime! syntax/gimp.vim
  runtime! syntax/gtkglext.vim
  runtime! syntax/libunique.vim
  runtime! syntax/cairo.vim
  runtime! syntax/glib.vim
  runtime! syntax/gtksourceview.vim
  runtime! syntax/libwnck.vim
  runtime! syntax/clutter.vim
  runtime! syntax/gnomedesktop.vim
  runtime! syntax/jsonglib.vim
  runtime! syntax/pango.vim
  runtime! syntax/gobjectintrospection.vim
  runtime! syntax/libgsf.vim
  runtime! syntax/poppler.vim
  runtime! syntax/dbusglib.vim
  runtime! syntax/gstreamer.vim
  runtime! syntax/libnotify.vim
  runtime! syntax/vte.vim
  runtime! syntax/evince.vim
  runtime! syntax/gtk2.vim
  runtime! syntax/librsvg.vim
  runtime! syntax/xlib.vim
endif

" vim: set ft=vim :
