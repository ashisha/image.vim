# Image.viDaniel1404d from: [Image.vim](https://github.com/Daniel1404/image.vim)
Original project is Unmainteined.

View images in Vim, because Vim is awesome!

![](https://github.com/Daniel1404/image.vim/blob/master/screenshot/image.vim.jpg)



Features
=========
* Let's you open (preview) images in Vim!:
  Image supported:
    * Png
    * jpg - jpeg
    * webp
* It's safe, never modifies the original image (unless you force write)
* Adapted to work with python3 instead of python2

Requirements
============
* Vim with *python* support. You can verify if your Vim is compiled with python using:
  
  `vim --version | grep python`

  If you see `+python`, your Vim has python support. If not, compile or install yourself
  a vim with python support.

  In arch:
  ```
  sudo pacman -S gvim
  ```
  In Debian based:

  ```
  sudo apt install vim-gtk
  ```
  
  It will install gvim which include vim with python support and a GTK application of vim.  
  You will be asked to remove Vim, but relax, you will keep the option of use vim in terminal.
  
* Also needs the Python library PIL. You can install PIL using `pip install Pillow`

Installation
============
* [Pathogen](https://github.com/tpope/vim-pathogen)
  *  `git clone https://github.com/Daniel1404/image.vim ~/.vim/bundle/image.vim`
* [Vundle](https://github.com/gmarik/vundle)
  * `Plugin 'Daniel1404/image.vim'`
* [NeoBundle](https://github.com/Shougo/neobundle.vim)
  * `NeoBundle 'Daniel1404/image.vim'`
* Manual
  * Copy image.vim into your `~/.vim/plugin/` directory

Errors
============
Not an error but a deficit, it doesn't work well with image that are 
full colored like Screenshots, because the plugin uses Ascii characters.


Thank you!
