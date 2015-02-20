'use strict';

var npm = require('npm-shizzle')
  , git = require('git-shizzle')
  , shelly = require('shelljs')
  , kuler = require('kuler')
  , path = require('path')
  , fs = require('fs');

/**
 * Small output helper to give the user some feedback about the current
 * phase of the installation process.
 *
 * @param {String} msg Message that needs to be outputted.
 * @api private
 */
function debug(msg) {
  msg = '\r'+ kuler('∴ ', 'lime') + kuler(msg, 'white');
  process.stdout.write(msg);
}

//
// Make sure that if we're from git, that update all the things.
//
try {
  git(__dirname).submodule('init');
  git(__dirname).submodule('update --recursive');
} catch (e) { }

//
// Ensure that certain packages are installed on the system using brew.
//
[
  'git-extras',
  'redis',
  'vim'
].forEach(function install(name) {
  debug('Running brew install '+ name);
  shelly.exec('brew install '+ name, { silent: true });
});

//
// Install the global npm modules that we want to have available on this host
// system.
//
[
  'json',
  'police',
  'jshint',
  'jslint',
  'csslint',
  'uni',
  'spot',
  'tj/watch'
].forEach(function install(name) {
  debug('Running npm install --global '+ name);
  npm(process.cwd()).install('--global '+ name);
});

//
// Symlink things! The array is structured as [ <from>, <to> ]
//
[
 ['{root}/zsh/.zshrc', '~/.zshrc'],
 ['{root}/zsh/.zsh', '~/.zsh'],
 ['{root}/zsh/.zsh/themes/3rdEden.zsh-theme', '~/.oh-my-zsh/themes/3rdEden.zsh-theme'],
 ['{root}/vim/.vimrc', '~/.vimrc'],
 ['{root}/vim/.vim', '~/.vim'],
 ['{root}/git/.gitconfig', '~/.gitconfig'],
 ['{root}/.jshintrc', '~/.jshintrc'],
].forEach(function each(link) {
  var source = link[0].replace('{root}', __dirname)
    , destination = link[1].replace('~', process.env.HOME);

  debug('symlinking '+ source);
  shelly.ln('-sf', source, destination, { silent: true });
});

debug('Installation completed');
