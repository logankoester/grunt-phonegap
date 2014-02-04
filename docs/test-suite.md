    git clone https://github.com/logankoester/grunt-phonegap.git
    cd grunt-phonegap
    npm install
    git submodule init
    git submodule update
    grunt

Note that not all tests can be run on all platforms. For example, tests depending on the Windows Phone SDK
will be skipped if your OS is detected to be non-Windows.

