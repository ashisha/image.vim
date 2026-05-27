if !has("python") && !has("python3")
    echo "image.vim requires python or python3 support"
    finish
endif

command! -nargs=0 Image call DisplayImage()

if !get(g:, 'image_vim_pil_missing', 0)
    au BufRead *.png,*.jpg,*.jpeg :call DisplayImage()
endif

if has("python3")
python3 << EOF
import vim
try:
    from PIL import Image
except ImportError:
    vim.command("echo 'image.vim requires Pillow: brew install pillow'")
    vim.command("let g:image_vim_pil_missing = 1")
else:
    vim.command("let g:image_vim_pil_missing = 0")

def _do_display_image():
    try:
        vim.command("let imagefile = expand('%:p')")
        imagefile = vim.eval("imagefile")
        width  = vim.current.window.width
        height = vim.current.window.height
        img = Image.open(imagefile)
    except Exception as e:
        print("image.vim: cannot open image: %s" % e)
        return

    img_w, img_h = img.size
    img_w = img_w * 2

    scale = width / img_w
    if (width / height) > (img_w / img_h):
        scale = scale * ((img_w / img_h) / (width / height))

    scaled_w = int(scale * img_w)
    scaled_h = int(scale * img_h)

    img = img.resize((scaled_w, scaled_h))
    pixels = img.load()

    palette = "@%#*+=-:. "
    palette_len = len(palette)

    vim.command("bd!")
    vim.command("enew")
    vim.current.buffer[:] = None

    for y in range(scaled_h):
        row = ""
        for x in range(scaled_w):
            rgb = pixels[x, y]
            if not isinstance(rgb, tuple):
                rgb = (rgb,)
            row += palette[int(sum(rgb) / len(rgb) / 255 * (palette_len - 1))]
        vim.current.buffer.append(row)
EOF
else
python << EOF
import vim
try:
    from PIL import Image
except ImportError:
    vim.command("echo 'image.vim requires Pillow: pip install Pillow'")
    vim.command("let g:image_vim_pil_missing = 1")
else:
    vim.command("let g:image_vim_pil_missing = 0")

def _do_display_image():
    try:
        vim.command("let imagefile = expand('%:p')")
        imagefile = vim.eval("imagefile")
        width  = vim.current.window.width
        height = vim.current.window.height
        img = Image.open(imagefile)
    except Exception as e:
        print("image.vim: cannot open image: %s" % e)
        return

    img_w, img_h = img.size
    img_w = img_w * 2

    scale = width / img_w
    if (width / height) > (img_w / img_h):
        scale = scale * ((img_w / img_h) / (width / height))

    scaled_w = int(scale * img_w)
    scaled_h = int(scale * img_h)

    img = img.resize((scaled_w, scaled_h))
    pixels = img.load()

    palette = "@%#*+=-:. "
    palette_len = len(palette)

    vim.command("bd!")
    vim.command("enew")
    vim.current.buffer[:] = None

    for y in range(scaled_h):
        row = ""
        for x in range(scaled_w):
            rgb = pixels[x, y]
            if not isinstance(rgb, tuple):
                rgb = (rgb,)
            row += palette[int(sum(rgb) / len(rgb) / 255 * (palette_len - 1))]
        vim.current.buffer.append(row)
EOF
endif

function! DisplayImage()
    if get(g:, 'image_vim_pil_missing', 0)
        echo "image.vim requires Pillow: brew install pillow"
        return
    endif
    set nowrap
    if has("python3")
        python3 << EOF
_do_display_image()
EOF
    else
        python << EOF
_do_display_image()
EOF
    endif
endfunction