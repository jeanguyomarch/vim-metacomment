"
" vim-metacomment.vim
"
"
" The MIT License (MIT)
"
" Copyright (c) 2013-2016 Jean Guyomarc'h
"
" Permission is hereby granted, free of charge, to any person obtaining a copy
" of this software and associated documentation files (the "Software"), to deal
" in the Software without restriction, including without limitation the rights
" to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
" copies of the Software, and to permit persons to whom the Software is
" furnished to do so, subject to the following conditions:
"
" The above copyright notice and this permission notice shall be included in
" all copies or substantial portions of the Software.
"
" THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
" IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
" FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
" AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
" LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
" OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
" THE SOFTWARE.
"


" -------------------------------------------------------------------------- "
"                           Configuration Variables                          "
" -------------------------------------------------------------------------- "

" C and derivates (type /* */)
if !exists("g:MetaComment_header_c")
   let g:MetaComment_header_c = "============================================================================*"
endif

if !exists("g:MetaComment_right_c")
   let g:MetaComment_right_c = "*"
endif

if !exists("g:MetaComment_left_c")
   let g:MetaComment_left_c = "*"
endif

if !exists("g:MetaComment_footer_c")
   let g:MetaComment_footer_c = "*============================================================================"
endif

" C++ (type //)
if !exists("g:MetaComment_header_cpp")
   let g:MetaComment_header_cpp = "============================================================================//"
endif

if !exists("g:MetaComment_right_cpp")
   let g:MetaComment_right_cpp = "//"
endif

if !exists("g:MetaComment_left_cpp")
   let g:MetaComment_left_cpp = ""
endif

if !exists("g:MetaComment_footer_cpp")
   let g:MetaComment_footer_cpp = "============================================================================//"
endif

" Shell/Python/Ruby (type #)
if !exists("g:MetaComment_header_sh")
   let g:MetaComment_header_sh = "==============================================================================#"
endif

if !exists("g:MetaComment_right_sh")
   let g:MetaComment_right_sh = " #"
endif

if !exists("g:MetaComment_left_sh")
   let g:MetaComment_left_sh = " "
endif

if !exists("g:MetaComment_footer_sh")
   let g:MetaComment_footer_sh = "==============================================================================#"
endif

" Assembler (type ;)
if !exists("g:MetaComment_header_asm")
   let g:MetaComment_header_asm = " ---------------------------------------------------------------------------- ;"
endif

if !exists("g:MetaComment_right_asm")
   let g:MetaComment_right_asm = " ;"
endif

if !exists("g:MetaComment_left_asm")
   let g:MetaComment_left_asm = " "
endif

if !exists("g:MetaComment_footer_asm")
   let g:MetaComment_footer_asm = " ---------------------------------------------------------------------------- ;"
endif

" Vimscript (type ")
if !exists("g:MetaComment_header_vim")
   let g:MetaComment_header_vim = " ---------------------------------------------------------------------------- \""
endif

if !exists("g:MetaComment_right_vim")
   let g:MetaComment_right_vim = " \""
endif

if !exists("g:MetaComment_left_vim")
   let g:MetaComment_left_vim = " "
endif

if !exists("g:MetaComment_footer_vim")
   let g:MetaComment_footer_vim = " ---------------------------------------------------------------------------- \""
endif

" VHDL (type --)
if !exists("g:MetaComment_header_vhdl")
   let g:MetaComment_header_vhdl = " -------------------------------------------------------------------------- --"
endif

if !exists("g:MetaComment_right_vhdl")
   let g:MetaComment_right_vhdl = "--"
endif

if !exists("g:MetaComment_left_vhdl")
   let g:MetaComment_left_vhdl = ""
endif

if !exists("g:MetaComment_footer_vhdl")
   let g:MetaComment_footer_vhdl = " -------------------------------------------------------------------------- --"
endif

" Lua (type --)
if !exists("g:MetaComment_header_lua")
   let g:MetaComment_header_lua = g:MetaComment_header_vhdl
endif

if !exists("g:MetaComment_right_lua")
   let g:MetaComment_right_lua = g:MetaComment_right_vhdl
endif

if !exists("g:MetaComment_left_lua")
   let g:MetaComment_left_lua = g:MetaComment_left_vhdl
endif

if !exists("g:MetaComment_footer_lua")
   let g:MetaComment_footer_lua = g:MetaComment_footer_vhdl
endif

" LaTeX (type %)
if !exists("g:MetaComment_header_latex")
   let g:MetaComment_header_latex = " ---------------------------------------------------------------------------- %"
endif

if !exists("g:MetaComment_right_latex")
   let g:MetaComment_right_latex = " %"
endif

if !exists("g:MetaComment_left_latex")
   let g:MetaComment_left_latex = " "
endif

if !exists("g:MetaComment_footer_latex")
   let g:MetaComment_footer_latex = " ---------------------------------------------------------------------------- %"
endif

" HTML (type <!-- -->)
if !exists("g:MetaComment_header_html")
   let g:MetaComment_header_html = " ***************************************************************************"
endif

if !exists("g:MetaComment_right_html")
   let g:MetaComment_right_html = " *"
endif

if !exists("g:MetaComment_left_html")
   let g:MetaComment_left_html = "*"
endif

if !exists("g:MetaComment_footer_html")
   let g:MetaComment_footer_html = "*************************************************************************** "
endif

" Jinja (type {# #}
if !exists("g:MetaComment_header_jinja")
   let g:MetaComment_header_jinja = "#############################################################################"
endif

if !exists("g:MetaComment_right_jinja")
   let g:MetaComment_right_jinja = "#"
endif

if !exists("g:MetaComment_left_jinja")
   let g:MetaComment_left_jinja = "#"
endif

if !exists("g:MetaComment_footer_jinja")
   let g:MetaComment_footer_jinja = "#############################################################################"
endif

" -------------------------------------------------------------------------- "
"                                 Private API                                "
" -------------------------------------------------------------------------- "

function! StringWithWhiteSpaces(str)
   let right = ""
   let left = ""
   let space = 76
   let len = strlen(a:str)
   let leftspace = (space - len) / 2
   let rightspace = leftspace
   let c = 0

   if (len % 2 != 0)
      let leftspace += 1
   endif

   while c < rightspace
      let right = right . " "
      let c += 1
   endwhile
   let c = 0
   while c < leftspace
      let left = left . " "
      let c += 1
   endwhile

   return left . a:str . right
endfunction


" -------------------------------------------------------------------------- "
"                            MetaComment SubTypes                            "
" -------------------------------------------------------------------------- "

function! s:MetaCommentC(str)
      exec "normal i/*" . g:MetaComment_header_c
      exec "normal o"
      exec "normal 0d$i " . g:MetaComment_left_c . StringWithWhiteSpaces(a:str) . g:MetaComment_right_c
      exec "normal o"
      exec "normal 0d$i " . g:MetaComment_footer_c . "*/"
endfunction

function! s:MetaCommentCpp(str)
      exec "normal i//" . g:MetaComment_header_cpp
      exec "normal o"
      exec "normal 0d$i//" . g:MetaComment_left_cpp . StringWithWhiteSpaces(a:str) . g:MetaComment_right_cpp
      exec "normal o"
      exec "normal 0d$i//" . g:MetaComment_footer_cpp
endfunction

function! s:MetaCommentSh(str)
      exec "normal i#" . g:MetaComment_header_sh
      exec "normal o"
      exec "normal 0d$i#" . g:MetaComment_left_sh . StringWithWhiteSpaces(a:str) . g:MetaComment_right_sh
      exec "normal o"
      exec "normal 0d$i#" . g:MetaComment_footer_sh
endfunction

function! s:MetaCommentAsm(str)
      exec "normal i;" . g:MetaComment_header_asm
      exec "normal o"
      exec "normal 0d$i;" . g:MetaComment_left_asm . StringWithWhiteSpaces(a:str) . g:MetaComment_right_asm
      exec "normal o"
      exec "normal 0d$i;" . g:MetaComment_footer_asm
endfunction

function! s:MetaCommentVim(str)
      exec "normal i\"" . g:MetaComment_header_vim
      exec "normal o"
      exec "normal 0d$i\"" . g:MetaComment_left_vim . StringWithWhiteSpaces(a:str) . g:MetaComment_right_vim
      exec "normal o"
      exec "normal 0d$i\"" . g:MetaComment_footer_vim
endfunction

function! s:MetaCommentVhdl(str)
      exec "normal i--" . g:MetaComment_header_vhdl
      exec "normal o"
      exec "normal 0d$i--" . g:MetaComment_left_vhdl . StringWithWhiteSpaces(a:str) . g:MetaComment_right_vhdl
      exec "normal o"
      exec "normal 0d$i--" . g:MetaComment_footer_vhdl
endfunction

function! s:MetaCommentLua(str)
      exec "normal i--" . g:MetaComment_header_lua
      exec "normal o"
      exec "normal 0d$i--" . g:MetaComment_left_lua . StringWithWhiteSpaces(a:str) . g:MetaComment_right_lua
      exec "normal o"
      exec "normal 0d$i--" . g:MetaComment_footer_lua
endfunction

function! s:MetaCommentLaTeX(str)
      exec "normal i%" . g:MetaComment_header_latex
      exec "normal o"
      exec "normal 0d$i%" . g:MetaComment_left_latex . StringWithWhiteSpaces(a:str) . g:MetaComment_right_latex
      exec "normal o"
      exec "normal 0d$i%" . g:MetaComment_footer_latex
endfunction

function! s:MetaCommentHtml(str)
      exec "normal i<!--" . g:MetaComment_header_html
      exec "normal o"
      exec "normal 0d$i " . g:MetaComment_left_html . StringWithWhiteSpaces(a:str) . g:MetaComment_right_html
      exec "normal o"
      exec "normal 0d$i " . g:MetaComment_footer_html . "-->"
endfunction

function! s:MetaCommentJinja(str)
      exec "normal i{#" . g:MetaComment_header_jinja
      exec "normal o"
      exec "normal 0d$i " . g:MetaComment_left_jinja . StringWithWhiteSpaces(a:str) . g:MetaComment_right_jinja
      exec "normal o"
      exec "normal 0d$i " . g:MetaComment_footer_jinja . "#}"
endfunction



" -------------------------------------------------------------------------- "
"                              Main MetaComment                              "
" -------------------------------------------------------------------------- "

function! s:MetaComment(str)
   let ft = &filetype

   if ft == "c" || ft == "edc" || ft == "js" || ft == "php" || ft == "objc" || ft == "objcpp" || ft == "rust"
      call s:MetaCommentC(a:str)
   elseif ft == "cpp"
      call s:MetaCommentCpp(a:str)
   elseif ft == "sh" || ft == "bash" || ft == "zsh" || ft == "ruby" || ft == "python" || ft == "conf"
      call s:MetaCommentSh(a:str)
   elseif ft == "asm"
      call s:MetaCommentAsm(a:str)
   elseif ft == "vim"
      call s:MetaCommentVim(a:str)
   elseif ft == "vhdl"
      call s:MetaCommentVhdl(a:str)
   elseif ft == "lua"
      call s:MetaCommentLua(a:str)
   elseif ft == "tex" || ft == "mat"
      call s:MetaCommentLaTeX(a:str)
   elseif ft == "html"
      call s:MetaCommentHtml(a:str)
   elseif ft == "jinja"
      call s:MetaCommentJinja(a:str)
   else
      echoerr("Sorry... unimplemented filetype '" . ft . "'.")
   endif

endfunction


" -------------------------------------------------------------------------- "
"                                 Public API                                 "
" -------------------------------------------------------------------------- "

command! -nargs=1 MetaComment call s:MetaComment(<f-args>)
command! -nargs=1 MetaCommentC call s:MetaCommentC(<f-args>)
command! -nargs=1 MetaCommentCpp call s:MetaCommentCpp(<f-args>)
command! -nargs=1 MetaCommentSh call s:MetaCommentSh(<f-args>)
command! -nargs=1 MetaCommentAsm call s:MetaCommentAsm(<f-args>)
command! -nargs=1 MetaCommentVim call s:MetaCommentVim(<f-args>)
command! -nargs=1 MetaCommentVhdl call s:MetaCommentVhdl(<f-args>)
command! -nargs=1 MetaCommentLua call s:MetaCommentLua(<f-args>)
command! -nargs=1 MetaCommentLaTeX call s:MetaCommentLaTeX(<f-args>)
command! -nargs=1 MetaCommentHtml call s:MetaCommentHtml(<f-args>)

" EOF
