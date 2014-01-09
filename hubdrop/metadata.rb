name             'hubdrop'
maintainer       'ThinkDrop Consulting, LLC'
maintainer_email 'cookbookbooks@thinkdrop.net'
license          'GPLv2'
description      'Creates hubdrop.io server.'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '1.0.0'

recipe 'default', 'Installs a fully working hubdrop.io server.'

depends 'jenkins'
depends 'magic_shell'

