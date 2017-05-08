return {
  name = 'voronianski/static',
  version = '1.0.4',
  description = 'Serve static files with luvit.io and Utopia',
  repository = {
    url = 'http://github.com/luvitrocks/luvit-static.git',
  },
  tags = {'utopia', 'express', 'connect', 'middleware', 'server', 'static', 'files'},
  author = {
    name = 'Dmitri Voronianski',
    email = 'dmitri.voronianski@gmail.com'
  },
  homepage = 'https://github.com/luvitrocks/luvit-static',
  licenses = {'MIT'},
  dependencies = {
    'voronianski/mimes'
  },
  files = {
    '**.lua',
    '!test*',
    '!example*'
  }
}
