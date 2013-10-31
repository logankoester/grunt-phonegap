(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  module.exports.Build = (function() {
    Build.prototype.copy = require('directory-copy');

    Build.prototype.cp = require('cp');

    Build.prototype.path = require('path');

    Build.prototype.exec = require('child_process').exec;

    function Build(grunt, config) {
      this.grunt = grunt;
      this.config = config;
      this.buildPlatform = __bind(this.buildPlatform, this);
      this.addPlugin = __bind(this.addPlugin, this);
      this.compileConfig = __bind(this.compileConfig, this);
      this.cloneRoot = __bind(this.cloneRoot, this);
      this.cloneCordova = __bind(this.cloneCordova, this);
      this.file = this.grunt.file;
      this.log = this.grunt.log;
      this.warn = this.grunt.warn;
      this.fatal = this.grunt.fatal;
    }

    Build.prototype.clean = function(path) {
      if (path == null) {
        path = this.config.path;
      }
      if (this.file.exists(path)) {
        this.file["delete"](path);
      }
      return this;
    };

    Build.prototype.buildTree = function() {
      var path;
      path = this.config.path;
      this.file.mkdir(this.path.join(path, 'plugins'));
      this.file.mkdir(this.path.join(path, 'platforms'));
      this.file.mkdir(this.path.join(path, 'merges', 'android'));
      this.file.mkdir(this.path.join(path, 'www'));
      this.file.mkdir(this.path.join(path, '.cordova'));
      return this;
    };

    Build.prototype.cloneCordova = function(fn) {
      var _this = this;
      return this.copy({
        src: this.config.cordova,
        dest: this.path.join(this.config.path, '.cordova')
      }, function(err) {
        if (err) {
          _this.warn(err);
        }
        if (fn) {
          return fn(err);
        }
      });
    };

    Build.prototype.cloneRoot = function(fn) {
      var _this = this;
      return this.copy({
        src: this.config.root,
        dest: this.path.join(this.config.path, 'www')
      }, function(err) {
        if (err) {
          _this.warn(err);
        }
        if (fn) {
          return fn(err);
        }
      });
    };

    Build.prototype.compileConfig = function(fn) {
      var compiled, dest, template;
      dest = this.path.join(this.config.path, 'www', 'config.xml');
      if (this.grunt.util.kindOf(this.config.config) === 'string') {
        this.log.writeln("Copying static " + this.config.config);
        return this.cp(this.config.config, dest, function() {
          return fn();
        });
      } else {
        this.log.writeln("Compiling template " + this.config.config.template);
        template = this.grunt.file.read(this.config.config.template);
        compiled = this.grunt.template.process(template, {
          data: this.config.config.data
        });
        this.grunt.file.write(dest, compiled);
        return fn();
      }
    };

    Build.prototype.addPlugin = function(plugin, fn) {
      var cmd, proc,
        _this = this;
      cmd = "phonegap local plugin add " + plugin + " " + (this._setVerbosity());
      proc = this.exec(cmd, {
        cwd: this.config.path
      }, function(err, stdout, stderr) {
        if (err) {
          _this.fatal(err);
        }
        if (fn) {
          return fn(err);
        }
      });
      proc.stdout.on('data', function(out) {
        return _this.log.write(out);
      });
      return proc.stderr.on('data', function(err) {
        return _this.fatal(err);
      });
    };

    Build.prototype.buildPlatform = function(platform, fn) {
      var childProcess, cmd,
        _this = this;
      cmd = "phonegap local build " + platform + " " + (this._setVerbosity());
      childProcess = this.exec(cmd, {
        cwd: this.config.path
      }, function(err, stdout, stderr) {
        if (err) {
          _this.fatal(err);
        }
        if (fn) {
          return fn(err);
        }
      });
      childProcess.stdout.on('data', function(out) {
        return _this.log.write(out);
      });
      return childProcess.stderr.on('data', function(err) {
        return _this.fatal(err);
      });
    };

    Build.prototype._setVerbosity = function() {
      if (this.config.verbose) {
        return '-V';
      } else {
        return '';
      }
    };

    return Build;

  })();

}).call(this);
