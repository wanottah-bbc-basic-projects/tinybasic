    1 
    2 REM
    3 REM Tiny Basic BBC Edition
    4 REM
    5 REM Adapted for BBC Basic
    6 REM
    7 REM v2023.01.28
    8 REM
    9 
   10 REM ---------------------------------
   11 REM tinyBasic.iBas
   12 REM
   13 REM tinyBasic v1.2
   14 REM   Copyleft 2005-2007
   15 REM     by Laurent DUVEAU
   16 REM   http://www.aldweb.com/
   17 REM
   18 REM This file is an iziBasic for
   19 REM Palm sample Tiny Basic
   20 REM interpreter, loosely adapted
   21 REM from the original Tiny Basic
   22 REM version by Li Chen Wang.
   23 REM ---------------------------------
   24 
   25 
   26 REM A          temp
   27 REM B          temp
   28 REM C          character index in line
   29 REM E          line number for error msg
   30 REM I          temp (loops)
   31 REM K          temp
   32 REM L          number of lines
   33 REM N          number
   34 REM S          expression stack index
   35 REM T          temp
   36 REM V          variable index
   37 
   38 REM A$         temp
   39 REM B$         temp
   40 REM C$         character
   41 REM D$         single statement
   42 REM E$         error message
   43 REM G$         string code (")
   44 REM H$         HALT code (Line Feed)
   45 REM I$-R$      Help
   46 REM Z$=A$(26)  statement input
   47 
   48 
   49 REM set screen mode
   50 MODE 7
   51 
   52 
   53 REM print formatting characters
   54 _CHR_SPACE$ = " "
   55 _CHR_COLON$ = ":"
   56 _CHR_COMMA$ = ","
   57 _CHR_SEMI_COLON$ = ";"
   58 _CHR_NEWLINE$ = CHR$(10)
   59 _CHR_DOUBLE_QUOTE$ = CHR$(34)
   60 _CHR_CR_LF$ = CHR$(10) + CHR$(13)
   61 
   62 _EMPTY_STRING$ = ""
   63 
   64 
   65 REM math / conditional operators
   66 _OP_EQUALS$ = "="
   67 _OP_ADD$ = "+"
   68 _OP_SUBTRACT$ = "-"
   69 _OP_MINUS$ = "-"
   70 _OP_LESS_THAN$ = "<"
   71 _OP_GREATER_THAN$ = ">"
   72 _OP_MULTIPLY$ = "*"
   73 _OP_DIVIDE$ = "/"
   74 _OP_MODULUS$ = "%"
   75 _OP_LEFT_PARENTHESIS$ = "("
   76 _OP_RIGHT_PARENTHESIS$ = ")"
   77 
   78 
   79 REM character ascii codes
   80 _ASC_SPACE = 32
   81 _ASC_DOUBLE_QUOTE = 34
   82 _ASC_PERCENT = 37
   83 _ASC_ASTERISK = 42
   84 _ASC_PLUS = 43
   85 _ASC_MINUS = 45
   86 _ASC_DECIMAL_POINT = 46
   87 _ASC_FORWARD_SLASH = 47
   88 _ASC_ZERO = 48
   89 _ASC_NINE = 57
   90 _ASC_SEMI_COLON = 59
   91 _ASC_LESS_THAN = 60
   92 _ASC_GREATER_THAN = 62
   93 _ASC_UPPERCASE_A = 65
   94 _ASC_UPPERCASE_Z = 90
   95 _ASC_BACK_SLASH = 92
   96 _ASC_LOWERCASE_A = 97
   97 _ASC_LOWERCASE_Z = 122
   98 
   99 
  100 REM error codes
  101 _ERROR_CODE_STOP = -1
  102 _ERROR_CODE_PROGRAM_OVERFLOW = 8
  103 _ERROR_CODE_GOSUB_STACK_OVERFLOW = 188
  104 _ERROR_CODE_RETURN_WITHOUT_GOSUB = 133
  105 _ERROR_CODE_LINE_NOT_FOUND = 32
  106 _ERROR_CODE_UNTERMINATED_STRING = 62
  107 _ERROR_CODE_END_OF_STATEMENT_EXPECTED = 0
  108 _ERROR_CODE_INVALID_FACTOR = 0
  109 _ERROR_CODE_INVALID_NUMBER = 0
  110 _ERROR_CODE_INVALID_LABEL = 0
  111 _ERROR_CODE_INVALID_LINE_NUMBER = 9
  112 _ERROR_CODE_FUNCTION_EXPECTED = 0
  113 _ERROR_CODE_VARIABLE_EXPECTED = 0
  114 _ERROR_CODE_EQUALS_EXPECTED = 20
  115 _ERROR_CODE_THEN_EXPECTED = 0
  116 _ERROR_CODE_SYNTAX_ERROR = 0
  117 _ERROR_CODE_MISTAKE = 0
  118 _ERROR_CODE_NO_SUCH_VARIABLE = 0
  119 _ERROR_CODE_DIVISION_BY_ZERO = 224
  120 _ERROR_CODE_MISSING_RIGHT_PARENTHESIS = 296
  121 _ERROR_CODE_FILE_NOT_FOUND = 0
  122 
  123 
  124 REM error messages
  125 _ERROR_MESSAGE_STOP$ = "STOP"
  126 _ERROR_MESSAGE_PROGRAM_OVERFLOW$ = "Program overflow" : REM 8
  127 _ERROR_MESSAGE_GOSUB_STACK_OVERFLOW$ = "GOSUB stack overflow" : REM 188
  128 _ERROR_MESSAGE_RETURN_WITHOUT_GOSUB$ = "RETURN without GOSUB" : REM 133
  129 _ERROR_MESSAGE_LINE_NOT_FOUND$ = "Line not found" : REM 32
  130 _ERROR_MESSAGE_UNTERMINATED_STRING$ = "Missing """ : REM 62
  131 _ERROR_MESSAGE_END_OF_STATEMENT_EXPECTED$ = "End of statement expected"
  132 _ERROR_MESSAGE_INVALID_FACTOR$ = "Invalid factor"
  133 _ERROR_MESSAGE_INVALID_NUMBER$ = "Invalid number"
  134 _ERROR_MESSAGE_INVALID_LABEL$ = "Invalid label"
  135 _ERROR_MESSAGE_INVALID_LINE_NUMBER$ = "Invalid line number" : REM 9
  136 _ERROR_MESSAGE_FUNCTION_EXPECTED$ = "Function expected"
  137 _ERROR_MESSAGE_VARIABLE_EXPECTED$ = "Variable expected"
  138 _ERROR_MESSAGE_EQUALS_EXPECTED$ = "= expected" : REM 20
  139 _ERROR_MESSAGE_THEN_EXPECTED$ = "THEN expected"
  140 _ERROR_MESSAGE_SYNTAX_ERROR$ = "Syntax error"
  141 _ERROR_MESSAGE_MISTAKE$ = "Mistake"
  142 _ERROR_MESSAGE_NO_SUCH_VARIABLE$ = "No such variable"
  143 _ERROR_MESSAGE_DIVISION_BY_ZERO$ = "Division by zero" : REM 224
  144 _ERROR_MESSAGE_MISSING_RIGHT_PARENTHESIS$ = "Missing )" : REM 296
  145 _ERROR_MESSAGE_FILE_NOT_FOUND$ = "File not found"
  146 
  147 
  148 REM used to calculate/estimate available memory
  149 _STRING_OBJECT_DATA_LENGTH = 20
  150 _BYTES_PER_CHARACTER_BUFFER = 2
      _MAXIMUM_LINE_LENGTH = 80
  151 
  152 REM [1 - 100] = 100 program lines
  153 _PROGRAM_CODE_MEMORY = 125
  154 _PROGRAM_CODE_MEMORY_START = 27
  155 _PROGRAM_CODE_MEMORY_WORKSPACE = 26
  156 
  157 REM [27-53] = 26 variables
  158 REM [54-84] = 30 items math stack
  159 _PROCESSOR_STACK_MEMORY = 82
  160 _PROCESSOR_STACK_MEMORY_START = 53
  161 
  162 REM _MATH_STACK_MEMORY = 30 : REM _TOP = 84
  163 
  164 REM gosub stack
  165 _GOSUB_STACK_MEMORY = 26
  166 
  167 REM help
  168 _COMMAND_HELP_MEMORY = 10
  169 
  170 
  171 
  172 _FILE_NOT_FOUND = 0
  173 
  174 _FILE_EXTENSION$ = ".txt"
  175 
  176 _TRUE = -1
  177 _FALSE = 0
  178 
  179 
  180 programRunning = TRUE
  181 
  182 
  183 
  184 REM Start()
  185 CLS
  186 
  187 PROC_Initialise
  188 
  189 PROC_PowerOn
      
      PROC_Update
      
      END
  190 
  191 
  192 REM Update()
      DEF PROC_Update
      
  193 WHILE programRunning
  194   
  195   PROC_ControlLoop
  196   
  197 ENDWHILE
  198 
  199 ENDPROC
  200 
  201 
  202 
  203 DEF PROC_ControlLoop
  204 
  205 IF subroutine$ = "Ready" THEN PROC_Ready : ENDIF
  206 
  207 IF subroutine$ = "GetInput" THEN PROC_GetInput : ENDIF
  208 
  209 IF subroutine$ = "AutoRun" THEN PROC_AutoRun : ENDIF
  210 
  211 IF subroutine$ = "Exec" THEN PROC_Exec : ENDIF
  212 
  213 IF subroutine$ = "NextStatement" THEN PROC_NextStatement : ENDIF
  214 
  215 IF subroutine$ = "FinishStatement" THEN PROC_FinishStatement : ENDIF
  216 
  217 IF subroutine$ = "FinishStatement2" THEN PROC_FinishStatement2 : ENDIF
  218 
  219 IF subroutine$ = "NextChar" THEN PROC_NextChar : ENDIF
  220 
  221 IF subroutine$ = "EndPrint" THEN PROC_EndPrint : ENDIF
  222 
  223 ENDPROC
  224 
  225 
  226 DEF PROC_Initialise
  227 
  228 DIM programCode$(_PROGRAM_CODE_MEMORY)
  229 
  230 DIM A_processorStack(_PROCESSOR_STACK_MEMORY)
  231 
  232 DIM gosubLineNumberPointer(_GOSUB_STACK_MEMORY)
  233 
  234 DIM returnLineNumberPointer(_GOSUB_STACK_MEMORY)
  235 
  236 DIM commandHelp$(_COMMAND_HELP_MEMORY)
  237 
  238 ENDPROC
  239 
  240 
  241 DEF PROC_PowerOn
  242 
  243 PROC_ColdStart
  244 
  245 PROC_WarmStart
  246 
  247 PROC_InitialiseCommandHelp
  248 
  249 PROC_WriteTextToConsole(_EMPTY_STRING$, TRUE)
  250 
  251 PROC_WriteTextToConsole(welcomeMessage$, TRUE)
  252 
  253 PROC_WriteTextToConsole(_EMPTY_STRING$, TRUE)
  254 
  255 PROC_GetTotalMemory
  256 
  257 PROC_GetFreeMemory
  258 
  259 PROC_WriteTextToConsole(totalMemoryMessage$ + freeMemoryMessage$, TRUE)
  260 
  261 PROC_WriteTextToConsole(_EMPTY_STRING$, TRUE)
  262 
  263 PROC_WriteTextToConsole(promptMessage$, TRUE)
  264 
  265 REM goto Ready
  266 subroutine$ = "Ready"
  267 
  268 ENDPROC
  269 
  270 
  271 DEF PROC_ColdStart
  272 
  273 welcomeMessage$ = _CHR_SPACE$ + "**** Tiny Basic BBC Edition ****"
  274 
  275 promptMessage$ = "Ready"
  276 
  277 ENDPROC
  278 
  279 
  280 DEF PROC_WarmStart
  281 
  282 FOR programCodePointer = 0 TO _PROGRAM_CODE_MEMORY
  283   
  284   programCode$(programCodePointer) = _EMPTY_STRING$
  285   
  286 NEXT
  287 
  288 FOR processorStackPointer = 0 TO _PROCESSOR_STACK_MEMORY
  289   
  290   A_processorStack(processorStackPointer) = 0
  291   
  292 NEXT
  293 
  294 FOR gosubStackPointer = 0 TO _GOSUB_STACK_MEMORY
  295   
  296   gosubLineNumberPointer(gosubStackPointer) = 0
  297   
  298   returnLineNumberPointer(gosubStackPointer) = 0
  299   
  300 NEXT
  301 
  302 tempA = 0
  303 tempB = 0
  304 
  305 C_characterPointer = 0
  306 
  307 errorCode = 0
  308 E_errorLineNumber = 0
  309 
  310 L_programCodeMemoryPointer = 0
  311 
  312 lineNumber = 0
  313 
  314 N_numericData = 0
  315 
  316 S_processorStackPointer = 0
  317 
  318 tempT = 0
  319 
  320 V_variableStackPointer = 0
  321 
  322 gosubStackPointer = 0
  323 
  324 asciiCode = 0
  325 
  326 A$ = _EMPTY_STRING$
  327 
  328 B$ = _EMPTY_STRING$
  329 
  330 character$ = _EMPTY_STRING$
  331 
  332 D$ = _EMPTY_STRING$
  333 
  334 errorMessage$ = _EMPTY_STRING$
  335 
  336 fileName$ = _EMPTY_STRING$
  337 
  338 savingFile = FALSE
  339 
  340 loadingFile = FALSE
  341 
  342 fileNameOkay = FALSE
  343 
  344 ENDPROC
  345 
  346 
  347 DEF PROC_InitialiseCommandHelp
  348 
  349 commandHelp$(0) = "CLS, CLEAR, END"
  350 
  351 commandHelp$(1) = "HELP, MEM, NEW, RUN"
  352 
  353 commandHelp$(2) = "GOTO | GOSUB | RETURN"
  354 
  355 commandHelp$(3) = "LOAD | SAVE <exp>"
  356 
  357 commandHelp$(4) = "IF <exp> THEN <statement>"
  358 
  359 commandHelp$(5) = "INPUT <var>"
  360 
  361 commandHelp$(6) = "[LET] <var>=<exp>"
  362 
  363 commandHelp$(7) = "LIST [<exp>|PAUSE]"
  364 
  365 commandHelp$(8) = "PRINT <exp|str>[,<exp|str>][;]"
  366 
  367 commandHelp$(9) = "REM <any>"
  368 
  369 ENDPROC
  370 
  371 
  372 DEF PROC_GetTotalMemory
  373 
  374 totalMemory = (_STRING_OBJECT_DATA_LENGTH + _MAXIMUM_LINE_LENGTH * _BYTES_PER_CHARACTER_BUFFER) * _PROGRAM_CODE_MEMORY : REM _TOP
  375 
  376 totalMemory = INT(totalMemory / 1024)
  377 
  378 totalMemoryMessage$ = _CHR_SPACE$ + _CHR_SPACE$ + _CHR_SPACE$ + STR$(totalMemory) + "K Memory"
  379 
  380 ENDPROC
  381 
  382 
  383 DEF PROC_GetFreeMemory
  384 
  385 freeMemoryStart = _PROGRAM_CODE_MEMORY_START
  386 
  387 FOR memoryPointer = _PROGRAM_CODE_MEMORY TO _PROGRAM_CODE_MEMORY_START STEP -1
  388   
  389   B$ = programCode$(memoryPointer)
  390   
  391   IF B$ = _EMPTY_STRING$ THEN
  392     
  393     freeMemoryStart = memoryPointer
  394     
  395   ENDIF
  396   
  397 NEXT
  398 
  399 memoryTopBytes = (_STRING_OBJECT_DATA_LENGTH + _MAXIMUM_LINE_LENGTH * _BYTES_PER_CHARACTER_BUFFER) * _PROGRAM_CODE_MEMORY : REM _TOP
  400 
  401 memoryBottomBytes = (_STRING_OBJECT_DATA_LENGTH + _MAXIMUM_LINE_LENGTH * _BYTES_PER_CHARACTER_BUFFER) * freeMemoryStart
  402 
  403 freeMemory = memoryTopBytes - memoryBottomBytes
  404 
  405 freeMemoryMessage$ = _CHR_SPACE$ + _CHR_SPACE$ + STR$(freeMemory) + " Bytes Free"
  406 
  407 ENDPROC
  408 
  409 
  410 DEF PROC_Ready
  411 
  412 PROC_ErrorHandler
  413 
  414 REM goto GetInput
  415 subroutine$ = "GetInput"
  416 
  417 ENDPROC
  418 
  419 
  420 DEF PROC_GetInput
  421 
  422 INPUT LINE ">" Z$
  423 
  424 IF Z$ = _EMPTY_STRING$ THEN
  425   
  426   subroutine$ = "Ready"
  427   
  428 ELSE
  429   
  430   REM Z$ = FN_ConvertToUppercase(Z$)
  431   
  432   REM Z$ = Z$ + _CHR_NEWLINE$
  433   
  434   subroutine$ = "AutoRun"
  435   
  436 ENDIF
  437 
  438 ENDPROC
  439 
  440 
  441 DEF PROC_AutoRun
  442 
  443 L_programCodeMemoryPointer = _PROGRAM_CODE_MEMORY_WORKSPACE
  444 
  445 C_characterPointer = 1
  446 
  447 programCode$(L_programCodeMemoryPointer) = Z$
  448 
  449 PROC_GetNumber
  450 
  451 lineNumber = N_numericData
  452 
  453 E_errorLineNumber = N_numericData
  454 
  455 REM IF N_numericData = 0 THEN
  456 IF lineNumber = 0 THEN
  457   
        REM  "" THEN
  458   IF character$ = _EMPTY_STRING$ THEN
  459     
  460     subroutine$ = "Ready"
  461     
  462     ENDPROC
  463     
  464   ENDIF
  465   
  466   subroutine$ = "NextStatement"
  467   
  468   ENDPROC
  469   
  470 ENDIF
  471 
  472 REM ELSE
  473 
  474 REM B = (N_numericData > 0) AND (N_numericData = INT(N_numericData))
  475 
  476 REM IF B = TRUE THEN
  477 IF lineNumber > 0 THEN
  478   
  479   PROC_EnterLine
  480   
  481   IF errorMessage$ <> _EMPTY_STRING$ THEN
  482     
  483     subroutine$ = "Ready"
  484     
  485     ENDPROC
  486     
  487   ENDIF
  488   
  489   subroutine$ = "GetInput"
  490   
  491   ENDPROC
  492   
  493 ENDIF
  494 
  495 REM ELSE
  496 IF lineNumber < 0 THEN
  497   
  498   E_errorLineNumber = 0
  499   
  500   PROC_ErrorMessage(_ERROR_CODE_INVALID_LINE_NUMBER, _ERROR_MESSAGE_INVALID_LINE_NUMBER$)
  501   
  502   subroutine$ = "Ready"
  503   
  504   ENDPROC
  505   
  506 ENDIF
  507 
  508 REM ENDIF
  509 
  510 subroutine$ = "Exec"
  511 
  512 ENDPROC
  513 
  514 
  515 DEF PROC_Exec
  516 
  517 PROC_GetNumber
  518 
  519 E_errorLineNumber = N_numericData
  520 
  521 subroutine$ = "NextStatement"
  522 
  523 ENDPROC
  524 
  525 
  526 DEF PROC_NextStatement
  527 
  528 PROC_GetLabel
  529 
  530 IF errorMessage$ <> _EMPTY_STRING$ THEN
  531   
  532   subroutine$ = "Ready"
  533   
  534   ENDPROC
  535   
  536 ENDIF
  537 
  538 
  539 IF D$ = "IF" OR D$ = "if" THEN PROC_TinyBasic_If : ENDPROC : ENDIF
  540 
  541 IF D$ = "REM" OR D$ = "rem" THEN PROC_TinyBasic_Rem : ENDPROC : ENDIF
  542 
  543 IF D$ = "INPUT" OR D$ = "input" THEN PROC_TinyBasic_Input : ENDPROC : ENDIF
  544 
  545 IF D$ = "PRINT" OR D$ = "print" THEN PROC_TinyBasic_Print : ENDPROC : ENDIF
  546 
  547 IF D$ = "CLEAR" OR D$ = "clear" THEN PROC_TinyBasic_Clear : ENDPROC : ENDIF
  548 
  549 IF D$ = "RUN" OR D$ = "run" THEN PROC_TinyBasic_Run : ENDPROC : ENDIF
  550 
  551 IF D$ = "GOTO" OR D$ = "goto" THEN PROC_TinyBasic_Goto : ENDPROC : ENDIF
  552 
  553 IF D$ = "GOSUB" OR D$ = "gosub" THEN PROC_TinyBasic_Gosub : ENDPROC : ENDIF
  554 
  555 IF D$ = "RETURN" OR D$ = "return" THEN PROC_TinyBasic_Return : ENDPROC : ENDIF
  556 
  557 IF D$ = "NEW" OR D$ = "new" THEN PROC_TinyBasic_New : ENDPROC : ENDIF
  558 
  559 IF D$ = "CLS" OR D$ = "cls" THEN PROC_TinyBasic_Cls : ENDPROC : ENDIF
  560 
  561 IF D$ = "HELP" OR D$ = "help" THEN PROC_TinyBasic_Help : ENDPROC : ENDIF
  562 
  563 IF D$ = "MEM" OR D$ = "mem" THEN PROC_TinyBasic_Mem : ENDPROC : ENDIF
  564 
  565 IF D$ = "END" OR D$ = "end" THEN PROC_TinyBasic_End : ENDPROC : ENDIF
  566 
  567 IF D$ = "STOP" OR D$ = "stop" THEN PROC_TinyBasic_Stop : ENDPROC : ENDIF
  568 
  569 IF D$ = "LIST" OR D$ = "list" THEN PROC_TinyBasic_List : ENDPROC : ENDIF
  570 
  571 IF D$ = "SAVE" OR D$ = "save" THEN PROC_TinyBasic_Save : ENDPROC : ENDIF
  572 
  573 IF D$ = "LOAD" OR D$ = "load" THEN PROC_TinyBasic_Load : ENDPROC : ENDIF
  574 
  575 IF D$ = "LET" OR D$ = "let" THEN PROC_TinyBasic_Let
  576 
  577 
  578 PROC_ReturnVar
  579 
  580 IF errorMessage$ <> _EMPTY_STRING$ THEN
  581   
  582   subroutine$ = "Ready"
  583   
  584   ENDPROC
  585   
  586 ENDIF
  587 
  588 PROC_SkipSpace
  589 
  590 PROC_GetChar
  591 
  592 IF character$ <> _OP_EQUALS$ THEN
  593   
  594   PROC_ErrorMessage(_ERROR_CODE_EQUALS_EXPECTED, _ERROR_MESSAGE_EQUALS_EXPECTED$)
  595   
  596   subroutine$ = "Ready"
  597   
  598   ENDPROC
  599   
  600 ENDIF
  601 
  602 C_characterPointer = C_characterPointer + 1
  603 
  604 REM T = V_variableStackPointer
  605 stackPointer = V_variableStackPointer
  606 
  607 PROC_GetExpression
  608 
  609 IF errorMessage$ <> _EMPTY_STRING$ THEN
  610   
  611   subroutine$ = "Ready"
  612   
  613   ENDPROC
  614   
  615 ENDIF
  616 
  617 REM A_processorStack(T) = N_numericData
  618 A_processorStack(stackPointer) = N_numericData
  619 
  620 subroutine$ = "FinishStatement"
  621 
  622 ENDPROC
  623 
  624 
  625 DEF PROC_FinishStatement
  626 
  627 PROC_SkipSpace
  628 
  629 PROC_GetChar
  630 
  631 IF character$ = _CHR_COLON$ THEN
  632   
  633   C_characterPointer = C_characterPointer + 1
  634   
  635   subroutine$ = "NextStatement"
  636   
  637   ENDPROC
  638   
  639 ELSE
  640   REM "" THEN
  641   IF character$ <> _EMPTY_STRING$ THEN
  642     
  643     PROC_ErrorMessage(_ERROR_CODE_END_OF_STATEMENT_EXPECTED, _ERROR_MESSAGE_END_OF_STATEMENT_EXPECTED$)
  644     
  645     subroutine$ = "Ready"
  646     
  647     ENDPROC
  648     
  649   ENDIF
  650   
  651 ENDIF
  652 
  653 IF L_programCodeMemoryPointer = _PROGRAM_CODE_MEMORY_WORKSPACE THEN
  654   
  655   subroutine$ = "Ready"
  656   
  657   ENDPROC
  658   
  659 ENDIF
  660 
  661 L_programCodeMemoryPointer = L_programCodeMemoryPointer + 1
  662 
  663 C_characterPointer = 1
  664 
  665 IF L_programCodeMemoryPointer = _PROGRAM_CODE_MEMORY + 1 THEN
  666   
  667   PROC_ErrorMessage(_ERROR_CODE_PROGRAM_OVERFLOW, _ERROR_MESSAGE_PROGRAM_OVERFLOW$)
  668   
  669   subroutine$ = "Ready"
  670   
  671   ENDPROC
  672   
  673 ENDIF
  674 
  675 subroutine$ = "FinishStatement2"
  676 
  677 ENDPROC
  678 
  679 
  680 DEF PROC_FinishStatement2
  681 
  682 B$ = programCode$(L_programCodeMemoryPointer)
  683 
  684 IF B$ = _EMPTY_STRING$ THEN
  685   
  686   subroutine$ = "Ready"
  687   
  688   ENDPROC
  689   
  690 ENDIF
  691 
  692 subroutine$ = "Exec"
  693 
  694 ENDPROC
  695 
  696 
  697 DEF PROC_EnterLine
  698 
  699 L_programCodeMemoryPointer = _PROGRAM_CODE_MEMORY_START
  700 
  701 C_characterPointer = 1
  702 
  703 tempT = N_numericData
  704 
  705 PROC_NextLine
  706 
  707 ENDPROC
  708 
  709 
  710 DEF PROC_NextLine
  711 
  712 nextLine = TRUE
  713 
  714 WHILE nextLine
  715   
  716   PROC_GetNumber
  717   
  718   tempB = (N_numericData < tempT) AND (N_numericData <> 0) AND (L_programCodeMemoryPointer < _PROGRAM_CODE_MEMORY + 1) : REM _TOP + 1)
  719   
  720   IF tempB = TRUE THEN
  721     
  722     L_programCodeMemoryPointer = L_programCodeMemoryPointer + 1
  723     
  724     C_characterPointer = 1
  725     
  726     REM GOTO (NextLine)
  727     nextLine = TRUE
  728     
  729   ELSE
  730     
  731     nextLine = FALSE
  732     
  733   ENDIF
  734   
  735 ENDWHILE
  736 
  737 REM _TOP + 1 THEN
  738 IF L_programCodeMemoryPointer = _PROGRAM_CODE_MEMORY + 1 THEN
  739   
  740   PROC_ErrorMessage(_ERROR_CODE_PROGRAM_OVERFLOW, _ERROR_MESSAGE_PROGRAM_OVERFLOW$)
  741   
  742   ENDPROC
  743   
  744 ENDIF
  745 
  746 IF tempT <> N_numericData THEN
  747   
  748   REM FOR I = _PROGRAM_CODE_MEMORY_TOP TO L_programCodeMemoryPointer STEP -1
  749   FOR tempI = _PROGRAM_CODE_MEMORY TO L_programCodeMemoryPointer STEP -1
  750     
  751     REM tempB = tempI - 1
  752     
  753     programCode$(tempI) = programCode$(tempI - 1)
  754     
  755   NEXT
  756   
  757 ENDIF
  758 
  759 programCode$(L_programCodeMemoryPointer) = Z$
  760 
  761 PROC_SkipSpace
  762 REM "" THEN
  763 IF character$ = _EMPTY_STRING$ THEN
  764   
  765   FOR tempI = L_programCodeMemoryPointer TO _PROGRAM_CODE_MEMORY
  766     
  767     REM tempB = tempI + 1
  768     
  769     programCode$(tempI) = programCode$(tempI + 1)
  770     
  771   NEXT
  772   
  773 ENDIF
  774 
  775 ENDPROC
  776 
  777 
  778 DEF PROC_GetExpression
  779 
  780 S_processorStackPointer = _PROCESSOR_STACK_MEMORY_START
  781 
  782 A_processorStack(S_processorStackPointer) = 0
  783 
  784 PROC_BoolExpression
  785 
  786 N_numericData = A_processorStack(S_processorStackPointer)
  787 
  788 ENDPROC
  789 
  790 
  791 DEF PROC_BoolExpression
  792 
  793 PROC_AddExpression
  794 
  795 PROC_SkipSpace
  796 
  797 PROC_GetChar
  798 
  799 PROC_NextBool
  800 
  801 ENDPROC
  802 
  803 
  804 DEF PROC_NextBool
  805 
  806 nextBool = TRUE
  807 
  808 WHILE nextBool
  809   
  810   IF character$ = _OP_EQUALS$ THEN PROC_TinyBasic_Equals : ENDIF
  811   
  812   IF character$ = _OP_GREATER_THAN$ THEN PROC_TinyBasic_Greater_Than : ENDIF
  813   
  814   IF character$ = _OP_LESS_THAN$ THEN PROC_TinyBasic_Less_Than : ENDIF
  815   
  816   PROC_SkipSpace
  817   
  818   PROC_GetChar
  819   
  820   asciiCode = ASC(character$)
  821   
  822   nextBool = (asciiCode >= _ASC_LESS_THAN) AND (asciiCode <= _ASC_GREATER_THAN)
  823   
  824 ENDWHILE
  825 
  826 ENDPROC
  827 
  828 
  829 DEF PROC_AddExpression
  830 
  831 PROC_MulExpression
  832 
  833 PROC_SkipSpace
  834 
  835 PROC_GetChar
  836 
  837 PROC_NextAdd
  838 
  839 ENDPROC
  840 
  841 
  842 DEF PROC_NextAdd
  843 
  844 nextAdd = TRUE
  845 
  846 WHILE nextAdd
  847   
  848   IF character$ = _OP_ADD$ THEN PROC_TinyBasic_Add : ENDIF
  849   
  850   IF character$ = _OP_SUBTRACT$ THEN PROC_TinyBasic_Subtract : ENDIF
  851   
  852   PROC_SkipSpace
  853   
  854   PROC_GetChar
  855   
  856   asciiCode = ASC(character$)
  857   
  858   nextAdd = (asciiCode = _ASC_PLUS) OR (asciiCode = _ASC_MINUS)
  859   
  860 ENDWHILE
  861 
  862 ENDPROC
  863 
  864 
  865 DEF PROC_MulExpression
  866 
  867 PROC_GroupExpression
  868 
  869 PROC_SkipSpace
  870 
  871 PROC_GetChar
  872 
  873 PROC_NextMul
  874 
  875 ENDPROC
  876 
  877 
  878 DEF PROC_NextMul
  879 
  880 canLoop = TRUE
  881 
  882 WHILE canLoop
  883   
  884   IF character$ = _OP_MULTIPLY$ THEN PROC_TinyBasic_Multiply : ENDIF
  885   
  886   IF character$ = _OP_DIVIDE$ THEN PROC_TinyBasic_Divide : ENDIF
  887   
  888   IF character$ = _OP_MODULUS$ THEN PROC_TinyBasic_Modulus : ENDIF
  889   
  890   PROC_SkipSpace
  891   
  892   PROC_GetChar
  893   
  894   asciiCode = ASC(character$)
  895   
  896   canLoop = (asciiCode = _ASC_ASTERISK) OR (asciiCode = _ASC_FORWARD_SLASH)  OR (asciiCode = _ASC_BACK_SLASH)
  897   
  898 ENDWHILE
  899 
  900 ENDPROC
  901 
  902 
  903 DEF PROC_GroupExpression
  904 
  905 PROC_SkipSpace
  906 
  907 PROC_GetChar
  908 
  909 REM CASE character$ OF
  910 
  911 REM  "("
  912 REM WHEN _OP_LEFT_PARENTHESIS$
      IF character$ = _OP_LEFT_PARENTHESIS$ THEN
  913   
  914   C_characterPointer = C_characterPointer + 1
  915   
  916   PROC_BoolExpression
  917   
  918   PROC_SkipSpace
  919   
  920   PROC_GetChar
  921   
  922   REM ")"
  923   IF character$ <> _OP_RIGHT_PARENTHESIS$ THEN
  924     
  925     IF errorMessage$ = _EMPTY_STRING$ THEN
  926       
  927       PROC_ErrorMessage(_ERROR_CODE_MISSING_RIGHT_PARENTHESIS, _ERROR_MESSAGE_MISSING_RIGHT_PARENTHESIS$)
  928       
  929     ENDIF
  930     
  931     ENDPROC
  932     
  933   ENDIF
  934   
  935   C_characterPointer = C_characterPointer + 1
        
        ENDPROC
        
      ENDIF
  936 
  938 REM WHEN ""
      IF character$ = _EMPTY_STRING$ THEN
  939   
  940   IF errorMessage$ = _EMPTY_STRING$ THEN
  941     
  942     PROC_ErrorMessage(_ERROR_CODE_INVALID_FACTOR, _ERROR_MESSAGE_INVALID_FACTOR$)
  943     
  944   ENDIF
        
        ENDPROC
        
      ENDIF
  945 
  946 REM OTHERWISE
  947 
  948 asciiCode = ASC(character$)
  949 
  950 tempB = ((asciiCode < _ASC_ZERO) OR (asciiCode > _ASC_NINE)) AND (asciiCode <> _ASC_MINUS) AND (asciiCode <> _ASC_DECIMAL_POINT)
  951 
  952 IF tempB = FALSE THEN
  953   
  954   PROC_GetNumber
  955   
  956   IF errorMessage$ <> _EMPTY_STRING$ THEN
  957     
  958     ENDPROC
  959     
  960   ENDIF
  961   
  962   S_processorStackPointer = S_processorStackPointer + 1
  963   
  964   A_processorStack(S_processorStackPointer) = N_numericData
  965   
  966   
  967 ELSE
  968   
  969   PROC_GetLabel
  970   
  971   IF errorMessage$ <> _EMPTY_STRING$ THEN
  972     
  973     ENDPROC
  974     
  975   ENDIF
  976   
  977   tempB = LEN(D$)
  978   
  979   IF tempB = 1 THEN
  980     
  981     PROC_ReturnVar
  982     
  983     S_processorStackPointer = S_processorStackPointer + 1
  984     
  985     A_processorStack(S_processorStackPointer) = A_processorStack(V_variableStackPointer)
  986     
  987   ELSE
  988     
  989     REM CASE D$ OF
  990     
  991     REM WHEN "ticks"
  992     IF D$ = "ticks" THEN
            
  993       S_processorStackPointer = S_processorStackPointer + 1
  994       
  995       A_processorStack(S_processorStackPointer) = TICKS
            
            ENDPROC
            
          ENDIF
  996     
  998     REM WHEN "tickspersec"
          IF D$ = "tickspersec" THEN
  999       
 1000       S_processorStackPointer = S_processorStackPointer + 1
 1001       
 1002       A_processorStack(S_processorStackPointer) = TICKSPERSEC
            
            ENDPROC
            
          ENDIF
 1003     
 1005     REM OTHERWISE
 1006     
 1007     IF errorMessage$ = _EMPTY_STRING$ THEN
 1008       
 1009       PROC_ErrorMessage(_ERROR_CODE_FUNCTION_EXPECTED, _ERROR_MESSAGE_FUNCTION_EXPECTED$)
 1010       
 1011     ENDIF
 1012     
 1013     REM ENDCASE
 1014     
 1015   ENDIF
 1016   
 1017 ENDIF
 1018 
 1019 REM ENDCASE
 1020 
 1021 ENDPROC
 1022 
 1023 
 1024 DEF PROC_GetNumber
 1025 
 1026 PROC_SkipSpace
 1027 
 1028 PROC_GetChar
 1029 
 1030 tempA = 0
 1031 
 1032 IF character$ = _OP_MINUS$ THEN
 1033   
 1034   B$ = _OP_MINUS$
 1035   
 1036   C_characterPointer = C_characterPointer + 1
 1037   
 1038   PROC_GetChar
 1039   
 1040   asciiCode = ASC(character$)
 1041   
 1042   tempB = ((asciiCode < _ASC_ZERO) OR (asciiCode > _ASC_NINE)) AND (asciiCode <> _ASC_DECIMAL_POINT)
 1043   
 1044   IF tempB = TRUE THEN
 1045     
 1046     IF errorMessage$ = _EMPTY_STRING$ THEN
 1047       
 1048       PROC_ErrorMessage(_ERROR_CODE_INVALID_NUMBER, _ERROR_MESSAGE_INVALID_NUMBER$)
 1049       
 1050     ENDIF
 1051     
 1052     ENDPROC
 1053     
 1054   ENDIF
 1055   
 1056 ELSE
 1057   
 1058   B$ = _EMPTY_STRING$
 1059   
 1060 ENDIF
 1061 
 1062 PROC_NextNumber
 1063 
 1064 ENDPROC
 1065 
 1066 
 1067 DEF PROC_NextNumber
 1068 
 1069 nextNumber = TRUE
 1070 
 1071 WHILE nextNumber
 1072   REM "" THEN
 1073   IF character$ = _EMPTY_STRING$ THEN
 1074     
 1075     N_numericData = VAL(B$)
 1076     
 1077     nextNumber = FALSE
 1078     
 1079   ENDIF
 1080   
 1081   IF nextNumber = TRUE THEN
 1082     
 1083     asciiCode = ASC(character$)
 1084     
 1085     IF asciiCode = _ASC_DECIMAL_POINT THEN
 1086       
 1087       tempA = tempA + 1
 1088       
 1089       IF tempA > 1 THEN
 1090         
 1091         IF errorMessage$ = _EMPTY_STRING$ THEN
 1092           
 1093           PROC_ErrorMessage(_ERROR_CODE_INVALID_NUMBER, _ERROR_MESSAGE_INVALID_NUMBER$)
 1094           
 1095         ENDIF
 1096         
 1097         nextNumber = FALSE
 1098         
 1099       ENDIF
 1100       
 1101     ENDIF
 1102     
 1103   ENDIF
 1104   
 1105   IF nextNumber = TRUE THEN
 1106     
 1107     tempB = ((asciiCode < _ASC_ZERO) OR (asciiCode > _ASC_NINE)) AND (asciiCode <> _ASC_DECIMAL_POINT)
 1108     
 1109     IF tempB = TRUE THEN
 1110       
 1111       N_numericData = VAL(B$)
 1112       
 1113       nextNumber = FALSE
 1114       
 1115     ENDIF
 1116     
 1117   ENDIF
 1118   
 1119   IF nextNumber = TRUE THEN
 1120     
 1121     B$ = B$ + character$
 1122     
 1123     C_characterPointer = C_characterPointer + 1
 1124     
 1125     PROC_GetChar
 1126     
 1127   ENDIF
 1128   
 1129 ENDWHILE
 1130 
 1131 ENDPROC
 1132 
 1133 
 1134 DEF PROC_GetVar
 1135 
 1136 PROC_GetLabel
 1137 
 1138 IF errorMessage$ <> _EMPTY_STRING$ THEN
 1139   
 1140   ENDPROC
 1141   
 1142 ENDIF
 1143 
 1144 PROC_ReturnVar
 1145 
 1146 ENDPROC
 1147 
 1148 
 1149 DEF PROC_ReturnVar
 1150 
 1151 asciiCode = ASC(D$)
 1152 
 1153 tempA = LEN(D$)
 1154 
 1155 tempA = (tempA <> 1) OR (asciiCode < _ASC_LOWERCASE_A) OR (asciiCode > _ASC_LOWERCASE_Z)
 1156 
 1157 IF tempA = FALSE THEN
 1158   
 1159   V_variableStackPointer = asciiCode - 70
 1160   
 1161 ELSE
 1162   
 1163   IF errorMessage$ = _EMPTY_STRING$ THEN
 1164     
 1165     PROC_ErrorMessage(_ERROR_CODE_VARIABLE_EXPECTED, _ERROR_MESSAGE_VARIABLE_EXPECTED$)
 1166     
 1167   ENDIF
 1168   
 1169 ENDIF
 1170 
 1171 ENDPROC
 1172 
 1173 
 1174 DEF PROC_GetLabel
 1175 
 1176 PROC_SkipSpace
 1177 
 1178 PROC_GetChar
 1179 
 1180 D$ = _EMPTY_STRING$
 1181 REM "" THEN
 1182 IF character$ = _EMPTY_STRING$ THEN
 1183   
 1184   IF errorMessage$ = _EMPTY_STRING$ THEN
 1185     
 1186     PROC_ErrorMessage(_ERROR_CODE_INVALID_LABEL, _ERROR_MESSAGE_INVALID_LABEL$)
 1187     
 1188   ENDIF
 1189   
 1190   ENDPROC
 1191   
 1192 ENDIF
 1193 
 1194 asciiCode = ASC(character$)
 1195 
 1196 tempB = (asciiCode < _ASC_LOWERCASE_A) OR (asciiCode > _ASC_LOWERCASE_Z)
 1197 
 1198 IF tempB = TRUE THEN
 1199   
 1200   IF errorMessage$ = _EMPTY_STRING$ THEN
 1201     
 1202     PROC_ErrorMessage(_ERROR_CODE_INVALID_LABEL, _ERROR_MESSAGE_INVALID_LABEL$)
 1203     
 1204   ENDIF
 1205   
 1206   ENDPROC
 1207   
 1208 ENDIF
 1209 
 1210 PROC_GetNextLabel
 1211 
 1212 ENDPROC
 1213 
 1214 
 1215 DEF PROC_GetNextLabel
 1216 
 1217 getNextLabel = TRUE
 1218 
 1219 WHILE getNextLabel
 1220   
 1221   D$ = D$ + character$
 1222   
 1223   C_characterPointer = C_characterPointer + 1
 1224   
 1225   PROC_GetChar
 1226   REM "" THEN
 1227   IF character$ = _EMPTY_STRING$ THEN
 1228     
 1229     ENDPROC
 1230     
 1231   ENDIF
 1232   
 1233   asciiCode = ASC(character$)
 1234   
 1235   getNextLabel = (asciiCode >= _ASC_LOWERCASE_A) AND (asciiCode <= _ASC_LOWERCASE_Z)
 1236   
 1237 ENDWHILE
 1238 
 1239 ENDPROC
 1240 
 1241 
 1242 DEF PROC_SkipSpace
 1243 
 1244 PROC_GetChar
 1245 
 1246 WHILE character$ = _CHR_SPACE$
 1247   
 1248   C_characterPointer = C_characterPointer + 1
 1249   
 1250   PROC_GetChar
 1251   
 1252 ENDWHILE
 1253 
 1254 ENDPROC
 1255 
 1256 
 1257 DEF PROC_GetChar
 1258 
 1259 A$ = programCode$(L_programCodeMemoryPointer)
 1260 
 1261 character$ = MID$(A$, C_characterPointer, 1)
 1262 
 1263 ENDPROC
 1264 
 1265 
 1266 REM **** support routines ****
 1267 DEF PROC_NextChar
 1268 
 1269 C_characterPointer = C_characterPointer + 1
 1270 
 1271 character$ = MID$(A$, C_characterPointer, 1)
 1272 REM "" THEN
 1273 IF character$ = _EMPTY_STRING$ THEN
 1274   
 1275   PROC_ErrorMessage(_ERROR_CODE_UNTERMINATED_STRING, _ERROR_MESSAGE_UNTERMINATED_STRING$)
 1276   
 1277   REM GOTO Ready
 1278   subroutine$ = "Ready"
 1279   
 1280   ENDPROC
 1281   
 1282 ELSE
 1283   
 1284   IF character$ <> _CHR_DOUBLE_QUOTE$ THEN
 1285     
 1286     B$ = B$ + character$
 1287     
 1288     REM GOTO NextChar
 1289     subroutine$ = "NextChar"
 1290     
 1291     ENDPROC
 1292     
 1293   ENDIF
 1294   
 1295 ENDIF
 1296 
 1297 C_characterPointer = C_characterPointer + 1
 1298 
 1299 character$ = MID$(A$, C_characterPointer, 1)
 1300 
 1301 IF character$ = _CHR_DOUBLE_QUOTE$ THEN
 1302   
 1303   B$ = B$ + character$
 1304   
 1305   REM GOTO NextChar
 1306   subroutine$ = "NextChar"
 1307   
 1308   ENDPROC
 1309   
 1310 ENDIF
 1311 
 1312 REM PRINT B$;
 1313 PROC_WriteTextToConsole(B$, FALSE)
 1314 
 1315 subroutine$ = "EndPrint"
 1316 
 1317 ENDPROC
 1318 
 1319 
 1320 DEF PROC_EndPrint
 1321 
 1322 PROC_SkipSpace
 1323 
 1324 PROC_GetChar
 1325 
 1326 IF character$ = _CHR_COMMA$ THEN
 1327   
 1328   C_characterPointer = C_characterPointer + 1
 1329   
 1330   PROC_TinyBasic_Print
 1331   
 1332   ENDPROC
 1333   
 1334 ENDIF
 1335 
 1336 PROC_SkipSpace
 1337 
 1338 PROC_GetChar
 1339 
 1340 IF character$ <> _CHR_SEMI_COLON$ THEN
 1341   
 1342   PROC_WriteTextToConsole(_CHR_NEWLINE$, TRUE)
 1343   
 1344 ELSE
 1345   
 1346   C_characterPointer = C_characterPointer + 1
 1347   
 1348 ENDIF
 1349 
 1350 subroutine$ = "FinishStatement"
 1351 
 1352 ENDPROC
 1353 
 1354 
 1355 DEF PROC_WriteTextToConsole(text$, CRLF)
 1356 
 1357 text$ = FN_ConvertToUppercase(text$)
 1358 
 1359 PRINT text$;
 1360 
 1361 IF CRLF THEN
 1362   
 1363   PRINT _CHR_CR_LF$;
        
        CRLF = FALSE
 1364   
 1365 ENDIF
 1366 
 1367 ENDPROC
 1368 
 1369 
 1370 DEF FN_ConvertToUppercase(textStringToConvert$)
 1371 
 1372 FOR tempI = 1 TO LEN(textStringToConvert$)
 1373   
 1374   REM get character to convert
 1375   character$ = MID$(textStringToConvert$, tempI, 1)
 1376   
 1377   REM check if character is lowercase
 1378   IF character$ >= "a" AND character$ <= "z" THEN
 1379     
 1380     REM it is, so convert it
 1381     REM get code for character - offset 'A'
 1382     asciiCode = ASC(character$) - ASC("a")
 1383     
 1384     REM add value to offset for 'A'
 1385     MID$(textStringToConvert$, tempI, 1) = CHR$(ASC("A") + asciiCode)
 1386     
 1387   ENDIF
 1388   
 1389 NEXT
 1390 
 1391 = textStringToConvert$
 1392 
 1393 
 1394 REM **** error handler ****
 1395 DEF PROC_ErrorMessage(code, message$)
 1396 
 1397 IF errorMessage$ = _EMPTY_STRING$ THEN
 1398   
 1399   errorCode = code
 1400   
 1401   errorMessage$ = message$
 1402   
 1403 ENDIF
 1404 
 1405 ENDPROC
 1406 
 1407 
 1408 DEF PROC_ErrorHandler
 1409 
 1410 IF errorMessage$ <> _EMPTY_STRING$ THEN
 1411   
 1412   IF E_errorLineNumber > 0 AND errorCode = _ERROR_CODE_STOP THEN
 1413     
 1414     errorMessage$ = errorMessage$ + " at line " + STR$(E_errorLineNumber)
 1415     
 1416     PROC_DisplayErrorMessage
 1417     
 1418     ENDPROC
 1419     
 1420   ENDIF
 1421   
 1422   IF E_errorLineNumber > 0 THEN
 1423     
 1424     errorMessage$ = "Error in line " + STR$(E_errorLineNumber) + ": " + errorMessage$
 1425     
 1426   ELSE
 1427     
 1428     errorMessage$ = "Error: " + errorMessage$
 1429     
 1430   ENDIF
 1431   
 1432   PROC_DisplayErrorMessage
 1433   
 1434 ENDIF
 1435 
 1436 ENDPROC
 1437 
 1438 
 1439 DEF PROC_DisplayErrorMessage
 1440 
 1441 PROC_WriteTextToConsole(_EMPTY_STRING$, TRUE)
 1442 
 1443 PROC_WriteTextToConsole(errorMessage$, TRUE)
 1444 
 1445 errorMessage$ = _EMPTY_STRING$
 1446 
 1447 ENDPROC
 1448 
 1449 
 1450 
 1451 REM **** tiny basic commands ****
 1452 DEF PROC_TinyBasic_If
 1453 
 1454 PROC_GetExpression
 1455 
 1456 IF errorMessage$ <> _EMPTY_STRING$ THEN
 1457   
 1458   subroutine$ = "Ready"
 1459   
 1460   ENDPROC
 1461   
 1462 ENDIF
 1463 
 1464 REM N<1 THEN
 1465 IF N_numericData = FALSE THEN
 1466   
 1467   B$ = programCode$(L_programCodeMemoryPointer)
 1468   
 1469   C_characterPointer = LEN(B$) + 1
 1470   
 1471   subroutine$ = "FinishStatement"
 1472   
 1473   ENDPROC
 1474   
 1475 ENDIF
 1476 
 1477 PROC_GetLabel
 1478 
 1479 IF errorMessage$ <> _EMPTY_STRING$ THEN
 1480   
 1481   subroutine$ = "Ready"
 1482   
 1483   ENDPROC
 1484   
 1485 ENDIF
 1486 
 1487 IF D$ <> "THEN" AND D$ <> "then" THEN
 1488   
 1489   PROC_ErrorMessage(_ERROR_CODE_THEN_EXPECTED, _ERROR_MESSAGE_THEN_EXPECTED$)
 1490   
 1491   subroutine$ = "Ready"
 1492   
 1493   ENDPROC
 1494   
 1495 ENDIF
 1496 
 1497 subroutine$ = "NextStatement"
 1498 
 1499 ENDPROC
 1500 
 1501 
 1502 DEF PROC_TinyBasic_Rem
 1503 
 1504 B$ = programCode$(L_programCodeMemoryPointer)
 1505 
 1506 C_characterPointer = LEN(B$) + 1
 1507 
 1508 subroutine$ = "FinishStatement"
 1509 
 1510 ENDPROC
 1511 
 1512 
 1513 DEF PROC_TinyBasic_Clear
 1514 
 1515 FOR tempI = 0 TO _PROCESSOR_STACK_MEMORY
 1516   
 1517   A_processorStack(tempI) = 0
 1518   
 1519 NEXT
 1520 
 1521 subroutine$ = "FinishStatement"
 1522 
 1523 ENDPROC
 1524 
 1525 
 1526 DEF PROC_TinyBasic_Input
 1527 
 1528 PROC_GetVar
 1529 
 1530 IF errorMessage$ <> _EMPTY_STRING$ THEN
 1531   
 1532   subroutine$ = "Ready"
 1533   
 1534   ENDPROC
 1535   
 1536 ENDIF
 1537 
 1538 INPUT N_numericData
 1539 
 1540 A_processorStack(V_variableStackPointer) = N_numericData
 1541 
 1542 subroutine$ = "FinishStatement"
 1543 
 1544 ENDPROC
 1545 
 1546 
 1547 DEF PROC_TinyBasic_Print
 1548 
 1549 IF character$ = "" THEN
 1550   
 1551   PROC_WriteTextToConsole(_EMPTY_STRING$)
 1552   
 1553   subroutine$ = "FinishStatement"
 1554   
 1555   ENDPROC
 1556   
 1557 ENDIF
 1558 
 1559 PROC_SkipSpace
 1560 
 1561 PROC_GetChar
 1562 
 1563 IF character$ = _CHR_DOUBLE_QUOTE$ THEN
 1564   
 1565   B$ = _EMPTY_STRING$
 1566   
 1567   subroutine$ = "NextChar"
 1568   
 1569   ENDPROC
 1570   
 1571 ELSE
 1572   
 1573   PROC_GetExpression
 1574   
 1575   IF errorMessage$ <> _EMPTY_STRING$ THEN
 1576     
 1577     subroutine$ = "Ready"
 1578     
 1579     ENDPROC
 1580     
 1581   ENDIF
 1582   
 1583   REM PRINT N_numericData;
 1584   PROC_WriteTextToConsole(STR$(N_numericData), CRLF)
 1585   
 1586 ENDIF
 1587 
 1588 subroutine$ = "EndPrint"
 1589 
 1590 ENDPROC
 1591 
 1592 
 1593 DEF PROC_TinyBasic_Run
 1594 
 1595 PROC_TinyBasic_Clear
 1596 
 1597 L_programCodeMemoryPointer = _PROGRAM_CODE_MEMORY_START
 1598 
 1599 gosubStackPointer = -1
 1600 
 1601 C_characterPointer = 1
 1602 
 1603 subroutine$ = "FinishStatement2"
 1604 
 1605 ENDPROC
 1606 
 1607 
 1608 DEF PROC_TinyBasic_Goto
 1609 
 1610 PROC_GetExpression
 1611 
 1612 IF errorMessage$ <> _EMPTY_STRING$ THEN
 1613   
 1614   subroutine$ = "Ready"
 1615   
 1616   ENDPROC
 1617   
 1618 ENDIF
 1619 
 1620 IF E_errorLineNumber >= N_numericData THEN
 1621   
 1622   L_programCodeMemoryPointer = _PROGRAM_CODE_MEMORY_START
 1623   
 1624 ENDIF
 1625 
 1626 C_characterPointer = 1
 1627 
 1628 tempT = N_numericData
 1629 
 1630 PROC_NextGoto
 1631 
 1632 ENDPROC
 1633 
 1634 
 1635 DEF PROC_NextGoto
 1636 
 1637 nextGoto = TRUE
 1638 
 1639 WHILE nextGoto
 1640   
 1641   PROC_GetNumber
 1642   
 1643   IF N_numericData = tempT THEN
 1644     
 1645     E_errorLineNumber = N_numericData
 1646     
 1647     nextGoto = FALSE
 1648     
 1649     subroutine$ = "NextStatement"
 1650     
 1651   ELSE
 1652     
 1653     L_programCodeMemoryPointer = L_programCodeMemoryPointer + 1
 1654     
 1655     C_characterPointer = 1
 1656     
 1657     REM _TOP + 1 THEN
 1658     IF L_programCodeMemoryPointer = _PROGRAM_CODE_MEMORY THEN
 1659       
 1660       nextGoto = FALSE
 1661       
 1662       PROC_ErrorMessage(_ERROR_CODE_LINE_NOT_FOUND, _ERROR_MESSAGE_LINE_NOT_FOUND$)
 1663       
 1664       subroutine$ = "Ready"
 1665       
 1666     ENDIF
 1667     
 1668   ENDIF
 1669   
 1670 ENDWHILE
 1671 
 1672 ENDPROC
 1673 
 1674 
 1675 DEF PROC_TinyBasic_Gosub
 1676 
 1677 REM _TOP THEN
 1678 IF gosubStackPointer < _GOSUB_STACK_MEMORY THEN
 1679   
 1680   gosubStackPointer = gosubStackPointer + 1
 1681   
 1682   gosubLineNumberPointer(gosubStackPointer) = L_programCodeMemoryPointer
 1683   
 1684   returnLineNumberPointer(gosubStackPointer) = L_programCodeMemoryPointer + 1
 1685   
 1686   PROC_TinyBasic_Goto
 1687   
 1688 ELSE
 1689   
 1690   PROC_ErrorMessage(_ERROR_CODE_GOSUB_STACK_OVERFLOW, _ERROR_MESSAGE_GOSUB_STACK_OVERFLOW$)
 1691   
 1692   subroutine$ = "Ready"
 1693   
 1694 ENDIF
 1695 
 1696 ENDPROC
 1697 
 1698 
 1699 DEF PROC_TinyBasic_Return
 1700 
 1701 IF gosubStackPointer < 0 THEN
 1702   
 1703   PROC_ErrorMessage(_ERROR_CODE_RETURN_WITHOUT_GOSUB, _ERROR_MESSAGE_RETURN_WITHOUT_GOSUB$)
 1704   
 1705   subroutine$ = "Ready"
 1706   
 1707   ENDPROC
 1708   
 1709 ENDIF
 1710 
 1711 FOR tempI = 0 TO gosubStackPointer
 1712   
 1713   L_programCodeMemoryPointer = gosubLineNumberPointer(tempI)
 1714   
 1715   canReturn = TRUE
 1716   
 1717   WHILE canReturn
 1718     
 1719     PROC_GetNumber
 1720     
 1721     IF L_programCodeMemoryPointer = returnLineNumberPointer(tempI) THEN
 1722       
 1723       E_errorLineNumber = N_numericData
 1724       
 1725       subroutine$ = "NextStatement"
 1726       
 1727       canReturn = FALSE
 1728       
 1729       tempI = gosubStackPointer
 1730       
 1731     ELSE
 1732       
 1733       L_programCodeMemoryPointer = L_programCodeMemoryPointer + 1
 1734       
 1735       C_characterPointer = 1
 1736       
 1737     ENDIF
 1738     
 1739   ENDWHILE
 1740   
 1741 NEXT
 1742 
 1743 ENDPROC
 1744 
 1745 
 1746 DEF PROC_TinyBasic_New
 1747 
 1748 PROC_WarmStart
 1749 
 1750 IF E_errorLineNumber = 0 THEN
 1751   
 1752   subroutine$ = "FinishStatement"
 1753   
 1754 ELSE
 1755   
 1756   subroutine$ = "Ready"
 1757   
 1758 ENDIF
 1759 
 1760 ENDPROC
 1761 
 1762 
 1763 DEF PROC_TinyBasic_Cls
 1764 
 1765 CLS
 1766 
 1767 subroutine$ = "FinishStatement"
 1768 
 1769 ENDPROC
 1770 
 1771 
 1772 DEF PROC_TinyBasic_Help
 1773 
 1774 FOR commands = 0 TO _COMMAND_HELP_MEMORY
 1775   
 1776   PROC_WriteTextToConsole(commandHelp$(commands))
 1777   
 1778 NEXT
 1779 
 1780 subroutine$ = "FinishStatement"
 1781 
 1782 ENDPROC
 1783 
 1784 
 1785 DEF PROC_TinyBasic_Mem
 1786 
 1787 PROC_GetFreeMemory
 1788 
 1789 PROC_WriteTextToConsole(freeMemoryMessage$)
 1790 
 1791 subroutine$ = "FinishStatement"
 1792 
 1793 ENDPROC
 1794 
 1795 
 1796 DEF PROC_TinyBasic_End
 1797 
 1798 subroutine$ = "Ready"
 1799 
 1800 ENDPROC
 1801 
 1802 
 1803 DEF PROC_TinyBasic_Stop
 1804 
 1805 PROC_ErrorMessage(_ERROR_CODE_STOP, _ERROR_MESSAGE_STOP$)
 1806 
 1807 subroutine$ = "Ready"
 1808 
 1809 ENDPROC
 1810 
 1811 
 1812 DEF PROC_TinyBasic_List
 1813 
 1814 PROC_GetNumber
 1815 
 1816 tempT = N_numericData
 1817 
 1818 tempK = L_programCodeMemoryPointer
 1819 
 1820 tempI = C_characterPointer
 1821 
 1822 IF tempT = 0 THEN
 1823   
 1824   PROC_GetLabel
 1825   
 1826   IF errorMessage$ = _EMPTY_STRING$ THEN
 1827     
 1828     IF D$ = "pause" THEN
 1829       
 1830       tempI = C_characterPointer
 1831       
 1832     ENDIF
 1833     
 1834   ENDIF
 1835   
 1836   errorMessage$ = _EMPTY_STRING$
 1837   
 1838 ENDIF
 1839 
 1840 FOR L_programCodeMemoryPointer = _PROGRAM_CODE_MEMORY_START TO _PROGRAM_CODE_MEMORY : REM _TOP
 1841   
 1842   C_characterPointer = 1
 1843   
 1844   PROC_GetNumber
 1845   
 1846   tempB = (tempT = 0) OR (N_numericData = tempT)
 1847   
 1848   IF tempB = TRUE THEN
 1849     
 1850     IF A$ <> "" THEN
 1851       
 1852       PROC_WriteTextToConsole(A$, TRUE)
 1853       
 1854       IF D$ = "pause" THEN
 1855         
 1856         tempB = (L_programCodeMemoryPointer - _PROGRAM_CODE_MEMORY_WORKSPACE) MOD 10
 1857         
 1858         IF tempB = 0 THEN
 1859           
 1860           PROC_WriteTextToConsole("Pause...")
 1861           
 1862           WAIT
 1863           
 1864         ENDIF
 1865         
 1866       ENDIF
 1867       
 1868     ENDIF
 1869     
 1870   ENDIF
 1871   
 1872 NEXT
 1873 
 1874 L_programCodeMemoryPointer = tempK
 1875 
 1876 C_characterPointer = tempI
 1877 
 1878 subroutine$ = "FinishStatement"
 1879 
 1880 ENDPROC
 1881 
 1882 
 1883 DEF PROC_TinyBasic_Save
 1884 
 1885 REM GOSUB GetExpression
 1886 
 1887 IF errorMessage$ <> _EMPTY_STRING$ THEN
 1888   
 1889   subroutine$ = "Ready"
 1890   
 1891   ENDPROC
 1892   
 1893 ENDIF
 1894 
 1895 REM A$ = "tinyBas" + STR$(N)
 1896 INPUT "Filename: " fileName$
 1897 
 1898 fileName$ = fileName$ + _FILE_EXTENSION$
 1899 
 1900 file = OPENOUT(fileName$)
 1901 
 1902 FOR tempI = _PROGRAM_CODE_MEMORY_START TO _PROGRAM_CODE_MEMORY
 1903   
 1904   B$ = programCode$(tempI)
 1905   
 1906   IF B$ <> "" THEN
 1907     
 1908     PRINT #file, B$
 1909     
 1910     REM A = TRUE
 1911     
 1912   ENDIF
 1913   
 1914 NEXT
 1915 
 1916 CLOSE #file
 1917 
 1918 subroutine$ = "FinishStatement"
 1919 
 1920 ENDPROC
 1921 
 1922 
 1923 DEF PROC_TinyBasic_Load
 1924 
 1925 REM GOSUB GetExpression
 1926 
 1927 IF errorMessage$ <> _EMPTY_STRING$ THEN
 1928   
 1929   subroutine$ = "Ready"
 1930   
 1931   ENDPROC
 1932   
 1933 ENDIF
 1934 
 1935 REM A$ = "tinyBas" + STR$(N)
 1936 INPUT "Filename: " fileName$
 1937 
 1938 fileName$ = fileName$ + _FILE_EXTENSION$
 1939 
 1940 file = OPENIN(fileName$)
 1941 
 1942 IF file = _FILE_NOT_FOUND THEN
 1943   
 1944   PROC_ErrorMessage(_ERROR_CODE_FILE_NOT_FOUND, _ERROR_MESSAGE_FILE_NOT_FOUND$)
 1945   
 1946   subroutine$ = "Ready"
 1947   
 1948   ENDPROC
 1949   
 1950 ENDIF
 1951 
 1952 tempI = _PROGRAM_CODE_MEMORY_START
 1953 
 1954 endOfFile = FALSE
 1955 
 1956 WHILE NOT endOfFile
 1957   
 1958   endOfFile = EOF#(file)
 1959   
 1960   INPUT #file, B$
 1961   
 1962   programCode$(tempI) = B$
 1963   
 1964   tempI = tempI + 1
 1965   
 1966 ENDWHILE
 1967 
 1968 CLOSE #file
 1969 
 1970 WHILE tempI <= _PROGRAM_CODE_MEMORY
 1971   
 1972   programCode$(tempI) = _EMPTY_STRING$
 1973   
 1974   tempI = tempI + 1
 1975   
 1976 ENDWHILE
 1977 
 1978 IF E_errorLineNumber = 0 THEN
 1979   
 1980   subroutine$ = "FinishStatement"
 1981   
 1982   ENDPROC
 1983   
 1984 ENDIF
 1985 
 1986 subroutine$ = "Ready"
 1987 
 1988 ENDPROC
 1989 
 1990 
 1991 DEF PROC_TinyBasic_Let
 1992 
 1993 PROC_GetLabel
 1994 
 1995 IF errorMessage$ <> _EMPTY_STRING$ THEN
 1996   
 1997   subroutine$ = "Ready"
 1998   
 1999 ENDIF
 2000 
 2001 ENDPROC
 2002 
 2003 
 2004 REM **** tiny basic conditional operators ****
 2005 DEF PROC_TinyBasic_Equals
 2006 
 2007 C_characterPointer = C_characterPointer + 1
 2008 
 2009 PROC_AddExpression
 2010 
 2011 IF A_processorStack(S_processorStackPointer - 1) = A_processorStack(S_processorStackPointer) THEN
 2012   
 2013   A_processorStack(S_processorStackPointer - 1) = _TRUE
 2014   
 2015 ELSE
 2016   
 2017   A_processorStack(S_processorStackPointer - 1) = _FALSE
 2018   
 2019 ENDIF
 2020 
 2021 S_processorStackPointer = S_processorStackPointer - 1
 2022 
 2023 ENDPROC
 2024 
 2025 
 2026 DEF PROC_TinyBasic_Greater_Than
 2027 
 2028 C_characterPointer = C_characterPointer + 1
 2029 
 2030 PROC_GetChar
 2031 
 2032 REM >=
 2033 IF character$ = _OP_EQUALS$ THEN
 2034   
 2035   PROC_TinyBasic_Greater_Than_Equal_To
 2036   
 2037 ELSE
 2038   
 2039   PROC_AddExpression
 2040   
 2041   IF A_processorStack(S_processorStackPointer - 1) > A_processorStack(S_processorStackPointer) THEN
 2042     
 2043     A_processorStack(S_processorStackPointer - 1) = _TRUE
 2044     
 2045   ELSE
 2046     
 2047     A_processorStack(S_processorStackPointer - 1) = _FALSE
 2048     
 2049   ENDIF
 2050   
 2051   S_processorStackPointer = S_processorStackPointer - 1
 2052   
 2053 ENDIF
 2054 
 2055 ENDPROC
 2056 
 2057 
 2058 DEF PROC_TinyBasic_Greater_Than_Equal_To
 2059 
 2060 C_characterPointer = C_characterPointer + 1
 2061 
 2062 PROC_AddExpression
 2063 
 2064 IF A_processorStack(S_processorStackPointer - 1) >= A_processorStack(S_processorStackPointer) THEN
 2065   
 2066   A_processorStack(S_processorStackPointer - 1) = _TRUE
 2067   
 2068 ELSE
 2069   
 2070   A_processorStack(S_processorStackPointer - 1) = _FALSE
 2071   
 2072 ENDIF
 2073 
 2074 S_processorStackPointer = S_processorStackPointer - 1
 2075 
 2076 ENDPROC
 2077 
 2078 
 2079 DEF PROC_TinyBasic_Less_Than
 2080 
 2081 C_characterPointer = C_characterPointer + 1
 2082 
 2083 PROC_GetChar
 2084 
 2085 REM CASE character$ OF
 2086 
 2087 REM <=
 2088 IF character$ = _OP_EQUALS$ THEN PROC_TinyBasic_Less_Than_Equal_To : ENDIF : ENDPROC
 2089 
 2090 REM <>
 2091 IF character$ = _OP_GREATER_THAN$ THEN PROC_TinyBasic_Not_Equal_To : ENDIF : ENDPROC
 2092 
 2093 REM OTHERWISE
 2094 
 2095 PROC_AddExpression
 2096 
 2097 IF A_processorStack(S_processorStackPointer - 1) < A_processorStack(S_processorStackPointer) THEN
 2098   
 2099   A_processorStack(S_processorStackPointer - 1) = _TRUE
 2100   
 2101 ELSE
 2102   
 2103   A_processorStack(S_processorStackPointer - 1) = _FALSE
 2104   
 2105 ENDIF
 2106 
 2107 S_processorStackPointer = S_processorStackPointer - 1
 2108 
 2109 REM ENDCASE
 2110 
 2111 ENDPROC
 2112 
 2113 
 2114 DEF PROC_TinyBasic_Less_Than_Equal_To
 2115 
 2116 C_characterPointer = C_characterPointer + 1
 2117 
 2118 PROC_AddExpression
 2119 
 2120 IF A_processorStack(S_processorStackPointer - 1) <= A_processorStack(S_processorStackPointer) THEN
 2121   
 2122   A_processorStack(S_processorStackPointer - 1) = _TRUE
 2123   
 2124 ELSE
 2125   
 2126   A_processorStack(S_processorStackPointer - 1) = _FALSE
 2127   
 2128 ENDIF
 2129 
 2130 S_processorStackPointer = S_processorStackPointer - 1
 2131 
 2132 ENDPROC
 2133 
 2134 
 2135 DEF PROC_TinyBasic_Not_Equal_To
 2136 
 2137 C_characterPointer = C_characterPointer + 1
 2138 
 2139 PROC_AddExpression
 2140 
 2141 IF A_processorStack(S_processorStackPointer - 1) <> A_processorStack(S_processorStackPointer) THEN
 2142   
 2143   A_processorStack(S_processorStackPointer - 1) = _TRUE
 2144   
 2145 ELSE
 2146   
 2147   A_processorStack(S_processorStackPointer - 1) = _FALSE
 2148   
 2149 ENDIF
 2150 
 2151 S_processorStackPointer = S_processorStackPointer - 1
 2152 
 2153 ENDPROC
 2154 
 2155 
 2156 REM **** tiny basic math operators ****
 2157 DEF PROC_TinyBasic_Add
 2158 
 2159 C_characterPointer = C_characterPointer + 1
 2160 
 2161 PROC_MulExpression
 2162 
 2163 A_processorStack(S_processorStackPointer - 1) = A_processorStack(S_processorStackPointer - 1) + A_processorStack(S_processorStackPointer)
 2164 
 2165 S_processorStackPointer = S_processorStackPointer - 1
 2166 
 2167 ENDPROC
 2168 
 2169 
 2170 DEF PROC_TinyBasic_Subtract
 2171 
 2172 C_characterPointer = C_characterPointer + 1
 2173 
 2174 PROC_MulExpression
 2175 
 2176 A_processorStack(S_processorStackPointer - 1) = A_processorStack(S_processorStackPointer - 1) - A_processorStack(S_processorStackPointer)
 2177 
 2178 S_processorStackPointer = S_processorStackPointer - 1
 2179 
 2180 ENDPROC
 2181 
 2182 
 2183 DEF PROC_TinyBasic_Multiply
 2184 
 2185 C_characterPointer = C_characterPointer + 1
 2186 
 2187 PROC_GroupExpression
 2188 
 2189 A_processorStack(S_processorStackPointer - 1) = A_processorStack(S_processorStackPointer - 1) * A_processorStack(S_processorStackPointer)
 2190 
 2191 S_processorStackPointer = S_processorStackPointer - 1
 2192 
 2193 ENDPROC
 2194 
 2195 
 2196 DEF PROC_TinyBasic_Divide
 2197 
 2198 C_characterPointer = C_characterPointer + 1
 2199 
 2200 PROC_GroupExpression
 2201 
 2202 IF A_processorStack(S_processorStackPointer) = 0 THEN
 2203   
 2204   PROC_ErrorMessage(_ERROR_CODE_DIVISION_BY_ZERO, _ERROR_MESSAGE_DIVISION_BY_ZERO$)
 2205   
 2206   S_processorStackPointer = S_processorStackPointer - 1
 2207   
 2208   ENDPROC
 2209   
 2210 ELSE
 2211   
 2212   A_processorStack(S_processorStackPointer - 1) = A_processorStack(S_processorStackPointer - 1) / A_processorStack(S_processorStackPointer)
 2213   
 2214   S_processorStackPointer = S_processorStackPointer - 1
 2215   
 2216 ENDIF
 2217 
 2218 ENDPROC
 2219 
 2220 
 2221 DEF PROC_TinyBasic_Modulus
 2222 
 2223 C_characterPointer = C_characterPointer + 1
 2224 
 2225 PROC_GroupExpression
 2226 
 2227 IF A_processorStack(S_processorStackPointer) = 0 THEN
 2228   
 2229   PROC_ErrorMessage(_ERROR_CODE_DIVISION_BY_ZERO, _ERROR_MESSAGE_DIVISION_BY_ZERO$)
 2230   
 2231   S_processorStackPointer = S_processorStackPointer - 1
 2232   
 2233   ENDPROC
 2234   
 2235 ELSE
 2236   
 2237   A_processorStack(S_processorStackPointer - 1) = INT(A_processorStack(S_processorStackPointer - 1) MOD A_processorStack(S_processorStackPointer))
 2238   
 2239   S_processorStackPointer = S_processorStackPointer - 1
 2240   
 2241 ENDIF
 2242 
 2243 ENDPROC
 2244 
