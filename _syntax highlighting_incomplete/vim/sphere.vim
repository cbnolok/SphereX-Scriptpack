" Vim syntax file
" Language: Celestia Star Catalogs
" Maintainer: Kevin Lauder
" Latest Revision: 26 April 2008

if exists("b:current_syntax")
  finish
endif

syn case ignore

" Error
syn match error contained ".\+$"
syn match nl contained "\n"

" Keywords
syn keyword controlKeywords if else elseif endif
syn keyword controlKeywords for forInstances forcharlayer forcharmemorytype forchars forclients forplayers forcont forcontid forconttype foritems forobjs endfor
syn keyword controlKeywords while endwhile
syn keyword controlKeywords doswitch enddo begin end
syn keyword controlKeywords return
syn keyword evaluateKeywords eval hval
syn keyword referenceKeywords ref1 ref2 ref3 new src TopObj cont serv Targ Link
syn keyword variableNames category subsection description
syn keyword variableNames id name value weight color layer range
syn keyword variableNames skillmake resources
syn keyword variableNames Container ITEM
syn keyword variableNames type tdata3 flags
syn keyword variableNames manause Cast_Time Scroll_Item Rune_Item Runes Effect_ID
syn keyword variableNames anim sound icon can dam armor moverate foodtype desires
syn keyword variableNames more more1 more1h more1l more2 more2h more2l morem morex morey morez morep
syn keyword ssDefining contained DefName comment
syn keyword ssDefining contained nextgroup=ssName skipwhite function typedef itemdef chardef events
syn keyword ssDefining contained nextgroup=spellNumber skipwhite spell
syn match triggerKeywords "@Dclick"
syn match triggerKeywords "@ClientToolTip"
syn match triggerKeywords "@Create"
syn match triggerKeywords "@GetHit"
syn match triggerKeywords "@death"
syn match triggerKeywords "@TargOn_Char"
syn match trigger "^on=@[^ ]\+" nextgroup=nl,error

" Matches
syn match uid '\<0[0-9a-f]\+\>'
syn match number '\<[+-]\?[0-9]\+\>'
syn match ssName contained '[a-zA-Z][a-zA-Z_0-9]*'
syn match ssVariable contained '[a-zA-Z][a-zA-Z_0-9]*' nextgroup=dot
syn match dot contained '\.' nextgroup=ssVariable
syn match spellNumber contained '\<[0-9]\+\>'

" Regions
syn region ssHeader start='\[' end=']' transparent contains=ssDefining oneline
" syn region ssValue start='<' end='>' fold transparent contains=ssVariable oneline nextgroup=dot


" Comments
syn keyword ssTodo contained TODO FIXME WA
syn match ssComment "//.*$" contains=ssTodo


let b:current_syntax = "spherescript"

hi def link ssTodo        Todo
hi def link ssComment     Comment
hi def link controlKeywords Statement
hi def link uid           Constant
hi def link number        Constant
hi def link ssDefining    Statement
hi def link ssName        Identifier
hi def link spellNumber   Identifier
hi def link trigger       Identifier
hi def link variableNames PreProc
hi def link referenceKeywords Type
hi def link error         Error
" hi def link ssVariable    Type
