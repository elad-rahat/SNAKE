IDEAL
MODEL small
STACK 100h
DATASEG
; --------------------------
BOARD db 1400 dup (?)
SNAKE dw 10 dup (?)
apple dw ?
appley db ?
applex db ?
clock equ es:6Ch
; --------------------------
CODESEG
;יוצר מיקום של תפוח
proc create_apple
	push ax
	push es
	push dx
	
	xor dx, dx
chose_diffrent_num:			;שורה
	xor ax, ax
	mov ax, 40h
	mov es, ax
	mov ax, [es:6Ch]
	and al, 00011111b		;יצירת המספר
	cmp al, 19				;מספר שורה(בדיקה אם המספר בתווך הרצוי (0-19
	ja chose_diffrent_num
	mov dl , al
	
	mov [appley], dl	;;;
	

	
	xor ax, ax
	mov al, 70
	mul dl					;הכפלה ב 70 לקבלת השורה
	mov [apple], ax			
	
chose_diffrent_num2:	;טור
	xor ax, ax
	mov ax, 40h
	mov es, ax
	mov ax, [es:6Ch]
	and al, 00111111b		;יצירת מספר 0-63
	mov dl, al

chose_again:
	xor ax, ax
	mov ax, 40h
	mov es, ax
	mov ax, [es:6Ch]
	and al, 00000111b		;יצרית המספר
	cmp al, 6				;check if the num in the range(0-6)
	ja chose_again
	
	add dl, al				;להפוך ל 0-69

	mov [applex], dl		;;;

	add [apple], dx
	
	pop dx
	pop es
	pop ax
	ret
endp create_apple


;מארגן את הלוח-ודברים התחלתיים בפעם הראשונה
proc START_GAME
	push bx
	push cx
	push si
	push di
	push dx
	mov cx, 1400
	lea bx, [BOARD]
Loopb:				;create the board
	mov si, cx
	neg si
	mov [byte ptr bx+si+1400], '.'
	loop Loopb
	
	mov cx, 5		;create the snake
	lea bx, [SNAKE]
	mov [word ptr bx+0], 733    ;10*70+33
	mov [byte ptr bx+2], 'A'	; גרפיקה
	
	mov [word ptr bx+4], 803    ;11*70+33
	mov [byte ptr bx+6], 'A'
	
	mov [word ptr bx+8], 873    ;12*70+33
	mov [byte ptr bx+10], 'A'	; גרפיקה
	
	mov [word ptr bx+12], 943    ;13*70+32
	mov [byte ptr bx+14], 'A'	; גרפיקה
	
	mov [word ptr bx+16], 1013   ;14*70+33
	mov [byte ptr bx+18], 'A'	; גרפיקה
	;הגדרת הלוח בפעם הראשונה
	mov cx, 5
	xor di, di
	xor dx, dx
LoopChangeBoard1:
	lea bx, [SNAKE]
	mov si, [bx+di]
	mov dl, [bx+di+2]
	lea bx, [BOARD]
	mov [byte ptr bx+si], dl
	add di, 4
	loop LoopChangeBoard1
	
	call create_apple
	lea bx, [board]
	mov di, [apple]
	mov [byte ptr bx+di], '@'
	
	pop dx
	pop di
	pop si
	pop cx
	pop bx
	ret
endp START_GAME


; משנה את הלוח עפ תזוזת הנחש
proc CHANGEBOARD
	push bx
	push di
	push si
	push dx
	xor di, di
	xor dx, dx
	lea bx, [SNAKE]
	mov si, [bx]		;שינוי הראשון לאיבר שמופיע במערך סנייק
	mov dl, [bx+2]
	mov di, [bx+16]		;שינוי האחרון לנקודה
	lea bx, [BOARD]
	mov [byte ptr bx+si], dl
	mov [byte ptr bx+di], '.'

	pop dx
	pop si
	pop di
	pop bx
	ret
endp CHANGEBOARD




;מדפיסה את הלוח
proc PRINT
	push cx
	push ax
	push dx
	push bx
	push si
	push di
	;Clear screen
	mov ax, 3
	int 10h
	
	;new line			;בפעם השניה שאנו מדפסים, זה מתחבר עם הפעם הראשונה
	mov dl, 10
	mov ah, 2
	int 21h
	;carriage return
	mov dl, 13
	mov ah, 2
	int 21h
	
	lea bx, [BOARD]
	mov dh, 0
	mov cx, 20
L2:
	mov si, 70
	xor ax,ax
	mov al, 70
	mul dh
L3:
	mov di, ax
	push ax			; בגלל שבשביל להדפיס, אנו צריכים את al 
	mov dl, [bx+di]
	mov ah, 2
	int 21h
	pop ax
	inc ax
	dec si
	cmp si, 0
	jne L3
	
	push ax			; בגלל שבשביל לעבור שורה, אנו צריכים את al
	;new line
	mov dl, 10
	mov ah, 2
	int 21h
	;carriage return
	mov dl, 13
	mov ah, 2
	int 21h
	inc dh
	pop ax
	loop L2
	pop di
	pop si
	pop bx
	pop dx
	pop ax
	pop cx
	ret
endp PRINT
	



; משנה את המיקום של הנחש
proc ChangeSnake
	push ax
	push cx
	push bx
	push di
	push bp
	push dx
	mov bp, sp
	mov ax, [bp+14]			;הערך שהתקבל: 1-4
	mov cx, 4
	mov di, 12    ; בגלל שהערך בגודל מילה+יש גרפיקה
	lea bx, [SNAKE]
LoopChSnake:
	mov dx, [word bx+di]				;נחליף את ה5 ב4 ואז את ה 4 ב 3 וכו... 
	mov [word ptr bx+di+4], dx			;גרפיקה
	sub di, 4
	loop LoopChSnake
	
	xor dx, dx				;בגלל שאנו נשתמש ברגיסטר בלופ הבא
	mov cx, 4
	mov di, 14
	
LoopChangeGraffic:
	mov dl, [byte ptr bx+di]
	mov [byte ptr bx+di+4], dl
	sub di, 4
	loop LoopChangeGraffic
	
right:
	cmp ax, 1    ;ימינה
	jne left
	add [word ptr bx], 1
	mov [byte ptr bx+2], '>'		;גרפיקה
	jmp ExitChangeSnake
	
left:
	cmp ax, 2  ;שמאל
	jne down
	sub [word ptr bx], 1
	mov [byte ptr bx+2], '<'
	jmp ExitChangeSnake
	
down:
	cmp ax, 3   ;למטה
	jne up
	add [word ptr bx], 70
	mov [byte ptr bx+2], 'v'
	jmp ExitChangeSnake
	
up:
	cmp ax, 4
	sub [word ptr bx], 70
	mov [byte ptr bx+2], 'A'
	
ExitChangeSnake:
	
	pop dx
	pop bp
	pop di
	pop bx
	pop cx
	pop ax
	ret 2
endp ChangeSnake

;בודק אם הנחש נגע בתפוח
proc check_apple
	push bx
	push di
	
	lea bx, [snake]
	mov di, [apple]
	cmp [word ptr bx], di		;בדיקה האם הנחש נגע התפוח
	jne exit_check_apple
	call create_apple	;יצירת תפוח חדש
	
	
exit_check_apple:
	lea bx, [board]		;שינוי הלוח עפ התפוח
	mov di, [apple]
	mov [byte ptr bx+di], '@'
	pop di
	pop bx
	ret 
endp check_apple

; wait 0.1 sec
proc Sleep
	push ax
	push cx
	mov ax, 40h
	mov es, ax
	mov ax, [Clock]
FirstTrick:
	cmp ax, [Clock]
	je FirstTrick
	
	mov cx, 1
DelayLoop:
	mov ax, [Clock]
Tick:
	cmp ax, [Clock]
	je Tick
	loop DelayLoop
	pop cx
	pop ax
	ret 
endp Sleep


start:
	mov ax, @data
	mov ds, ax

	call START_GAME
	call CHANGEBOARD
	call PRINT
	call sleep
	mov dx, 2
	
	
WaitForData:
	push dx
	call sleep
	call ChangeSnake
	call check_apple
	call CHANGEBOARD	
	call Print
	
	push dx
	push ax
	mov dl, [applex]
	add dl, '0'
	mov ah, 2h
	int 21h
	
	mov dl, [appley]
	add dl, '0'
	mov ah, 2h
	int 21h
	pop ax
	pop dx
	
	mov ah, 1
	Int 16h
	jz WaitForData
	mov ah, 0
	int 16h
	
	
check1:
	cmp ah, 20h 		;D - Right
	jne check2
	mov dx, 1			;Right
	mov ah, 2h
	int 21h
	xor ax, ax
	jmp WaitForData
	
check2:
	cmp ah, 1Eh			;A = Left
	jne check3
	mov dx, 2			; Left
	mov ah, 2h
	int 21h
	xor ax, ax
	jmp WaitForData
	
check3:
	cmp ah, 1Fh			;S = Down
	jne check4
	mov dx, 3			;Down
	mov ah, 2h
	int 21h
	xor ax, ax
	jmp WaitForData

check4:
	cmp ah, 11h			;W = up
	jne check5
	mov dx, 4			;up
	mov ah, 2h
	int 21h
	xor ax, ax
	jmp WaitForData

Check5:					;ENd the Game
	cmp ah, 1h			;Esc
	je exit
	mov ah, 2h
	int 21h
	xor ax, ax
	jmp WaitForData

	

	
exit:
	mov ax, 4c00h
	int 21h
END start


