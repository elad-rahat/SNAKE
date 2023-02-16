IDEAL
MODEL small
STACK 100h
DATASEG
; --------------------------
start_game_color db 1  ;עוזר לפונקציה "התחלת משחק"  פ
SNAKE dw 40 dup (?)
Clock equ es:6Ch
snake_lengh db 4
appley dw ?
applex dw ?
WIN_TEXT db 'You win!!! good job',13,10,'$'
APPLE_PLACE dw 41 dup (?)
;עוזר לפונק יצירת תפוחים
how_much_apple_create dw 0


;;;
; --------------------------
CODESEG
;יוצר ריבוע, בהינתן קורדינאטות וצבע
proc create_square
	push bp
	mov bp, sp
	push cx
	push dx
	push ax
	push si
	push di
	push bx
	
; הגדרות גרפיקה
	mov bh, 0h

	
	mov dx, [bp+4]		;y
	mov cx, [bp+6]		;x
	mov al, [bp+8]		;color
	
	mov si, 10		;x loop
	mov di, 10		;y loop
Loopx:
	mov ah,0ch		;graffic
	int 10h			;graffic
	
	inc cx			;plus 1 for the x
	sub si, 1
	cmp si, 0
	jg loopx
loopy:
	mov cx, [bp+6]	;חזרה לערך איקס המקורי
	mov si, 10		;back to x(10)
	
	add dx, 1		;plus 1 for the y
	sub di, 1
	cmp di, 0
	jg loopx
	
	pop bx
	pop di
	pop si
	pop ax
	pop dx
	pop cx
	pop bp

	ret 6
endp create_square
	
	
	
	
;יוצר מיקום של תפוח
proc create_apple
	push bx
	push ax
	push es
	push dx
	push di
	
;כדי לבדוק כמה תפוחים נאספו, נוריד מאורך הנחש 4
;כי אורך הנחש מתחיל ב 4
	
	mov si, [how_much_apple_create]
	
	push 4		;color
	
	lea bx, [APPLE_PLACE]
	mov dx, [bx+si]
	add dx, 40
	mov [applex], dx
	push dx		;push x
	
	lea bx, [APPLE_PLACE]
	mov dx, [bx+si+2]
	mov [appley], dx
	push dx		;push y
	
	add [how_much_apple_create], 4		;בגלל שיש גם איקס וגם וואי
	call create_square
	
	
	pop di
	pop dx
	pop es
	pop ax
	pop bx
	ret
endp create_apple	
	
	
	
;מארגן את הלוח-ודברים התחלתיים בפעם הראשונה
proc START_GAME
	push ax
	push bx
	push cx
	push si
	push di
	push dx
	
	;graffic setting
	mov cx, 10		;x
	mov dx, 10		;y
	
	;loop setting
	mov di, 30		;loopx
	mov si, 18		;loopy
	
print_loop:
;כדי לצבוע כל פעם משבצת בצבע אחר, משווה בין הערך של המשתנה, ובהתאם מדפיס את הצבע ומחליף
	cmp [start_game_color], 0		;green
	jne white
	mov [start_game_color], 1	;move to white
	push 3		;green/ push color
	jmp x_y_push
	
white:
	mov [start_game_color], 0 	;move to green
	push 15		;white/ push color
	
x_y_push:
	push cx		;push x
	push dx		;push y
	
	call create_square
	
	add cx, 10		;add for the x 10, to create another sqaure near
	;x loop
	sub di, 1
	cmp di, 0
	jg print_loop
	
	;y loop
	cmp [start_game_color], 0		;באופן דומה, משנה את הצבעים 
	jne chenge_to_green
	mov [start_game_color], 1		;change to white
	jmp loopagain
	
chenge_to_green:
	mov [start_game_color], 0		;change to white
loopagain:
	mov cx, 10		;return to x
	add dx, 10		;plus for the y
	mov di, 30
	sub si, 1
	cmp si, 0
	jg print_loop
	
	;שמירת מיקום הנחש ההתחלתי
	lea bx, [SNAKE]
	mov [word ptr bx], 150    ;x, 1 place
	mov [word ptr bx+2], 90    ;y, 1 place
	
	mov [word ptr bx+4], 150    ;x, 2 place
	mov [word ptr bx+6], 100    ;y, 2 place
	
	mov [word ptr bx+8], 150    ;x, 3 place
	mov [word ptr bx+10], 110    ;y, 3 place
	
	mov [word ptr bx+12], 150    ;x, 4 place
	mov [word ptr bx+14], 120    ;y, 4 place
	
;change the board, to the snake
	lea bx, [SNAKE]
	xor di, di
	
	mov si, 4		;loop 'print' the snake
change_board_snake_first:

	push 20		;black/ push color
	mov ax, [bx+di]
	push ax
	add di, 2		;להוסיף 2(רשימה ב 16 ביטים), כדי לעבור על כל איברי הרשימה
	mov ax, [bx+di]
	push ax
	add di, 2
	call create_square
	
	sub si, 1
	cmp si, 0
	jg change_board_snake_first


;בוחר את המיקום (מראש) של 10 תפוחים
;שומר במקום הראשון את האיקס הראשון ובשני את השני, וכן הלאה... 
; initialize
	xor bx, bx
	xor di, di
	
	mov ax, 40h
	mov es, ax
	mov cx, 40
	
RandLoop_x:
	; generate random number, cx number of times
	mov ax, [Clock] ; read timer counter
	mov ah, [byte cs:bx] ; read one byte from memory
	xor al, ah ; xor memory and counter
	and al, 00001111b ; leave result between 0-15
	
	push bx
;נכפיל ב 10, כי כל ריבוע הוא 10
	add al, 1		;נוסיף 1, ע"פ הגדרת הלוח
	mov dl, 10
	mul dl 
	
	lea bx, [APPLE_PLACE]
	mov [bx+di], ax
	add di, 2
	pop bx
	
	inc bx
	
	loop RandLoop_x

	
	call create_apple
	
	
	
	
	pop dx
	pop di
	pop si
	pop cx
	pop bx
	pop ax
	ret
endp START_GAME




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



; משנה את המיקום של הנחש
proc ChangeSnake
	push bp
	mov bp, sp
	push ax
	push cx
	push bx
	push di
	push dx
	
	lea bx, [SNAKE]


	xor ax, ax
	xor dx, dx
	mov al, [snake_lengh]
	sub al, 1
	mov dl, 4
	mul dl		;כדי להעביר קודם את ה y 
	mov di, ax
	
	xor cx, cx
	mov cl, [snake_lengh]
	
	lea bx, [SNAKE]
LoopChSnake:
	mov dx, [word ptr bx+di]				;נחליף את ה5 ב4 ואז את ה 4 ב 3 וכו... 
	mov [word ptr bx+di+4], dx			;change y
	add di, 2
	mov dx, [word ptr bx+di]
	mov [word ptr bx+di+4], dx			;change x
	sub di, 6							;מוריד את הפלוס שתיים שהוספנו מקודם + מוריד 4, להחלפה הבאה
	loop LoopChSnake
	


	mov ax, [bp+4]			;הערך שהתקבל: 1-4
	
right:
	cmp ax, 1    ;ימינה
	jne left
	add [word ptr bx], 10		;add to x value
	jmp ExitChangeSnake
	
left:
	cmp ax, 2  ;שמאל
	jne down
	sub [word ptr bx], 10		;sub to x value
	jmp ExitChangeSnake
	
down:
	cmp ax, 3   ;למטה
	jne up
	add [word ptr bx+2], 10		;add to y value
	jmp ExitChangeSnake
	
up:
	cmp ax, 4
	sub [word ptr bx+2], 10		;sub to y value
	
ExitChangeSnake:
	
	pop dx
	pop di
	pop bx
	pop cx
	pop ax
	pop bp
	ret 2
endp ChangeSnake




; משנה את הלוח עפ תזוזת הנחש
proc CHANGEBOARD
	push cx
	push bx
	push di
	push si
	push dx
	push ax
	
	xor di, di
	xor dx, dx
	lea bx, [SNAKE]
	
	xor ax, ax
	mov al, [snake_lengh]
	mov dl, 4
	mul dl 				;בגלל שגם האיקס תופס מקום וגם הווי, נכפיל ב 4
	mov si, ax
	
	;שינוי הערך האחרון של הנחש בחזרה לריבוע
	mov cx, [bx+si]		;x
	mov dx, [bx+si+2]		;y
	
;בדיקה לצבע, האם לשנות ללבן? או לכחול?
;נחלק ב 10, כדי לבדוק באיזה שורה אנחנו
	mov ax, dx
	mov bl, 10
	div bl
;נבדוק אם השורה זוגית או איזוגית (כדי שנפעל בהתאם ביחס לטורים) מ
	mov bl, 2
	xor ah, ah
	div bl
	
	cmp ah, 0
	jne check_odd_2
;check_even_2

;באופן דומה נחלק ב 10
	xor ax, ax
	mov ax, cx
	mov bl, 10
	div bl

;נבדוק אם אנחנו בטור זוגי או לא, ונפעל בהתאם	
	mov bl, 2
	xor ah, ah
	div bl
	
	cmp ah, 0
	jne push_green_even
	push 15			;push color/ white
	jmp end_push_color
	
push_green_even:
	push 3			;push color/ green 
	jmp end_push_color
	
check_odd_2:
;באופן דומה נחלק ב 10

	xor ax, ax
	mov ax, cx
	mov bl, 10
	div bl
	
;נבדוק אם אנחנו בטור זוגי או לא, ונפעל בהתאם	
	mov bl, 2
	xor ah, ah
	div bl
	
	cmp ah, 0
	jne push_white_odd
	push 3			;push color/ green
	jmp end_push_color
	
push_white_odd:
	push 15		;push white 
	
end_push_color:
	push cx 	;push x
	push dx		;push y
	call create_square
	
	
	lea bx, [snake]
	;שינוי הערך הראשון (החדש) לריבוע לסנייק
	mov cx, [bx]		;x
	mov dx, [bx+2]		;y
	
	push 20		;push color/black
	push cx		;push x
	push dx		;push y
	call create_square
	
	pop ax
	pop dx
	pop si
	pop di
	pop bx
	pop cx
	ret
endp CHANGEBOARD
	
	
	
;בודק אם הנחש נגע בתפוח
proc check_apple
	push bx
	push di
	
	lea bx, [snake]
	
	;בדיקת השוואת ה x 
	mov di, [applex]
	cmp [word ptr bx], di		
	jne exit_check_apple
	
	;בדיקת השוואת ה y
	mov di, [appley]
	cmp [word ptr bx+2], di		
	jne exit_check_apple
	
	call create_apple	;יצירת תפוח חדש
	
	add [snake_lengh], 1		;הגדלת גודל הנחש
	
	cmp [snake_lengh] , 15
	jl exit_check_apple
	call win_game
	
exit_check_apple:
	push 4
	push [applex]
	push [appley]
	call create_square
	
	pop di
	pop bx
	ret 
endp check_apple
	

proc win_game
	push bx
	push ax
	
	lea bx, [WIN_TEXT]
	mov ah, 9h
	int 21h
	jmp exit
	
	pop ax
	pop bx
	ret
endp win_game


start:
	mov ax, @data
	mov ds, ax
	

; הגדרות גרפיקה
	mov bh, 0h
	mov ax, 13h
	int 10h
	
	call START_GAME
	call sleep
	mov dx, 2
	
	
WaitForData:	
	push dx
	call sleep
	call ChangeSnake
	call check_apple
	call CHANGEBOARD			
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
;	mov ah, 0
;	mov al, 2
;	int 10h


exit:
	mov ax, 4c00h
	int 21h
END start
	