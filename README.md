# dotfiles
Modified from https://github.com/jardon-u/dotfiles.git for my usage
## Content

Clone - Use `recursive` clone to get sky-color-clock (sample in screenshot below)

Sample screenshot in python mode: Once you wait on a function in the pop-up - help-info comes a few seconds later - ![Alt text](./screenshot.png?raw=true "Python")


* Some important features
  * auto install emacs and rtags (for cpp completion), including all packages when emacs loads first time.
  * Extensive usage of **use-package** commands. This helps me changing machines easily.
  * Automatically finds `indentation scheme` for python and c++
  * Comprehensive **C++** environment
    * Flycheck with clang.
    * Code navigation with rtags (based on on-the-fly compilation).
    * Improved gdb experience.
    * F8 compile, F9 recompile.
  * **Python** linting, code navigation and correct code completion.
    * Relies on Elpy mode - `M-.` and `M-*` for jumping into and jumping back.
    * Auto formatting using autopep8 package - Works really well: formats and indents to this standard format.
  * Comprehensive **latex** environment - `C-c C-a` for building - builds all - latex, pdflatex and bibtex in one shot
    * For adding to bib tex files - please refer to development/latex/_init.el file.
    * Post compilation - automatically opens up pdf in partitioned emacs-window with highlighting the changes using arrow.
  * Super comprehensive **IPython** mode using Ein.
  * Spellcheck everywhere (code comments, text).
  * Check content of .emacs for more details..
  * `which-key` package shows key bindings when you press a key. A super-important package if you forget bindings.
  * I also use `treemacs` when working on libraries. If you want to use enanle it inside navigation/_init.el.
  * **Dockerfile** mode - helps in building docker directly from emacs
  * Semantic grouping using expand-region - helpful in navigating foreign codebases with different formatting.
  * If `automatically` removing whitespace is not ON (Ipython mode) - use `F12`.
  * Kill a buffer by `pause/break` key.

## Install on Linux - tested on Ubuntu 16.04
   Run
   ./install.sh
   * Alternatively you can just use hyperlink ~/.emacs.d folder to the folder here.

## For Mac Users
  * On mac use `brew` to install cmake, rtags, cask.
  * Then just hyper link ~/.emacs.d to this repo's emacs.d.
  * You will still need to follow sections below for a few stuffs and notes.
  * For better colors on Mac terminals use color prefix before opening command `TERM=xterm-256color emacs`

## Bug
   * Rarely an error saying flycheck-mode failed will appear when opening a C++ buffer.
   * Very rarely emacs will hang when working in a C++ buffer (seems related to rtags).
   * If you experience display glitches or issue with indentation, make sure to upgrade to emacs 26.
   * IPython mode's EIN currently cannot have automatic whitespace removal.


## Usage Notes
   * For some reason cmake-ide install fails. Just install using emacs.
   * Follow `install` section above.
   * Make sure cask and Jedi and irony-server are installed.
   * I change themes frequently so I have a lot of themes pre-installed in display/_init.el

### Rtags for C/C++ code completion
   * For Cmake based project use cmake to compile with output of compile commands.json
   * For C: to create compile_commands.json (Makefile project) use Bear. If you do not want to use bear then follow - https://eklitzke.org/using-emacs-and-rtags-with-autotools-c++-projects (section - configuring gcc wrapper).
   * Checkout full keybindings in development/c/_init.el file.

### Python and IPython
   * For jupyter make sure right kernels are installed.
   * Please refer to EIN here for more info - on various ein functions - https://github.com/millejoh/emacs-ipython-notebook
   * For elpy, you can check M-x elpy-status - this will show all configuration info including virtualenv you're in.

### Latex
  * May need to do sudo apt-get install texlive-fonts-recommended and sudo apt-get install texlive-fonts-extra
  * Latex mode also displays pdf on side and for pdf viewing - uncomment (only for the first time using this configuration repo) -
  (`pdf-tools-install`) in  editing/_init.el . Else it will keep bothering with installation every time you run emacs.

### Sky color mode
  * Cloning recursively automatically installs `sky-color-clock`. In order to get weather info you need to replace
    variable `API-Key` in the display/_init.el file. Also include proper latitude and city id in the same place

### Org Mode
  * I started using org mode for tasks, and also starting on using it for writing source code and converting from org to latex and related.
  * I hope to update the org mode conf file as I use it more. 
