Fork the repo on Github and open a pull request. Note that the files in `tasks/` and `test/` are the output of
CoffeeScript files in `src/`, and will be overwritten if edited by hand.

Likewise, `README.md` is the output of the `grunt docs` task, and will be overwritten. README updates should be made in
the Markdown files under `docs/`.

Before running the included test suite, you must first run `git submodule update --init` on your local clone (see above).

Please run `grunt build` before submitting a pull request. The build output should be included with your changes.
