" hicolors.vim:
"   Author:	Charles E. Campbell, Jr.
"   Date:	Sep 03, 2004
"   Version:	3
"  Usage:  :he hicolors
" =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
" GetLatestVimScripts: 1081 1 :AutoInstall: hicolors.vim

if &cp || exists("g:loaded_hicolors")
 finish
endif
let g:loaded_hicolors= "v3"

" ---------------------------------------------------------------------
"  HighlightColors: {{{1
fun! s:HighlightColors()
"  call Dfunc("HighlightColors()")
  setlocal updatetime=100
  2
  norm! $
  syn case match
  syn clear

  " set up common syntax highlighting
  syn clear
  syn cluster hiColorGroup add=hiModeLine
  syn region hiColorLine start='^' end='$' contains=@hiColorGroup
  syn region hiModeLine  start='^\s*vim:' end='$'
  hi link hiColorLine	Ignore
  hi link hiModeLine	Ignore

  " set up syntax highlighting for specific groups
  while search('\<[A-Z]','W')
   let color= expand("<cword>")
"   call Decho("color<".color.">")
   if s:HLTest(color)
    exe 'syn keyword hi'.color.' contained containedin=hiColorLine '.color
    exe 'hi link hi'.color.' '.color
    exe 'syn cluster hiColorGroup add=hi'.color
   endif
  endwhile
  nohlsearch
  3
  exe "norm! z\<cr>"
  if !exists("s:hlc_ctr")
   let s:hlc_ctr= 0
  endif
  let s:hlc_ctr= s:hlc_ctr + 1
"  call Dret("HighlightColors : ".s:hlc_ctr)
endfun

" ---------------------------------------------------------------------
"  HLTest: test if highlighting group is defined {{{1
fun! s:HLTest(hlname)
"  call Dfunc("HLTest(hlname<".a:hlname.">)")
  let id_hlname= hlID(a:hlname)
  if id_hlname == 0
"   call Dret("HLTest 0 : id_hlname==0")
   return 0
  endif
  let id_trans = synIDtrans(id_hlname)
  if id_trans == 0
"   call Dret("HLTest 0 : id_trans==0")
   return 0
  endif
  let fg_hlname= synIDattr(id_trans,"fg")
  let bg_hlname= synIDattr(id_trans,"bg")
  if fg_hlname == "" && bg_hlname == ""
"   call Dret("HLTest 0 : fg_hlname<".fg_hlname."> bg_hlname<".bg_hlname.">")
   return 0
  endif
"   call Dret("HLTest 1")
  return 1
endfun

" ---------------------------------------------------------------------
"  Autocmd: {{{1
au CursorHold hicolors.txt call <SID>HighlightColors()

" ---------------------------------------------------------------------
" Initialize: {{{1
call s:HighlightColors()

" ---------------------------------------------------------------------
" vim: fdm=marker
