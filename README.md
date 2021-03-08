# Test-Hugo-2-Gopher-and-Gemini
Testbed for the [Hugo-2-Gopher-and-Gemini](https://github.com/mkamarin/Hugo-2-Gopher-and-Gemini) repository. The test  consist of few hugo theme's examples that will be modified to test the `Hugo-2-Gopher-and-Gemini` project.

This is a companion repository to the [Hugo-2-Gopher-and-Gemini](https://github.com/mkamarin/Hugo-2-Gopher-and-Gemini) with the purpose of testing it.

## Introduction
The tests will consist of examples from hugo themes. Each one will be named **test-**<theme name>. Each test will be enhanced to test parts of the `hugo2gg.py` program capabilities.

To execute the tests, open a command line window at the base of this repository and execute `./test.sh`. That will generate a log in the logs directory.

## List of tests
Entries in this list of Hugo themes have been selected almost randomly. The only two criteria used were a single language (as `hugo2gg.py` does not support multilingual) and the ability to run hugo to the sampleSite with minimal changes to the `config.toml`. The `exampleSite` has been modified to test multiple generation strategies. However, original content has not been removed. Only either modified (mainly front matter) or new content added.
* Test-[hugo-theme-console](https://themes.gohugo.io/hugo-theme-console/) in [github repository](https://github.com/mrmierzejewski/hugo-theme-console) by [Marcin Mierzejewski](https://mrmierzejewski.com/).  
* Test-[hugo-researcher](https://themes.gohugo.io/hugo-researcher/) in [github repository](https://github.com/ojroques/hugo-researcher) by [Olivier Roques](https://oroques.dev/).
* Test-[hugo-blog-jeffprod](https://themes.gohugo.io/hugo-blog-jeffprod/) in [github repository](https://github.com/Tazeg/hugo-blog-jeffprod) by [JeffProd](https://jeffprod.com).

### Process to add a new test
For each test, the following basic process has been followed:
1. Executed `hugo new site test-hugo-<theme>`
2. From the new site executed `git submodule add https://github.com/<user>/<theme> themes/test-hugo-<theme>` (as indicated on the installation instructions.
3. Copied `test-hugo-<theme>/themes/<theme/exampleSite/*` to `test-hugo-<theme>` merging directories and overwriting files.
4. Minimal editing of the `config.toml` file.
5. Executed `hugo`
6. If necessary changed the `config.toml` file and executed `hugo` again. If the failed or required settings accounts, etc. then removed `test-hugo-<theme>` and tried a new theme.
7. Create an empty folder called `layouts-gg`.
8. Copy and modify the `config-gg.toml` files. To test multiple options, we will create several configs called `config-gga.toml`, `config-ggb.toml`, `config-ggc.toml`, etc.
9. Create a test script (`test.sh`) for this test.

