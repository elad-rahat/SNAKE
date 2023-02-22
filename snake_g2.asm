IDEAL
MODEL small
STACK 100h
DATASEG
; --------------------------
start_game_color db 1  ;עוזר לפונקציה "התחלת משחק"  פ
SNAKE dw 400 dup (?)
Clock equ es:6Ch
snake_lengh db 4
appley dw ?
applex dw ?
applenum dw ?
;text
WIN_TEXT db 'You won!!! good job',13,10,'$'
LOSE_TEXT db 'YOU LOSE, TRY AGAIN',13,10,'$'
END_ENTER_NUM_TEXT_1 db 'enter num 1:',13,10,'$'
END_ENTER_NUM_TEXT_2 db 'enter num 2:',13,10,'$'
END_ENTER_NUM_TEXT_3 db 'enter num 3:',13,10,'$'

APPLE_PLACE dw 400 dup (?)
NUMBER_FOR_THE_APPLE db 0, 7, 5, 2, 3, 1, 9, 0, 6, 2, 8, 3, 2, 1, 5, 9, 4, 1, 3, 3, 2, 1, 9, 5, 4, 3, 1, 4, 4, 4, 3, 9, 1, 6, 4, 2, 1, 9, 2, 2, 4, 2, 1, 8, 0, 0, 0, 1, 3, 5, 5, 1, 6, 4, 7, 1, 9, 1, 6, 2, 6, 8, 1, 7, 1, 7, 2, 8, 7, 2, 7, 5, 5, 8, 8, 5, 3, 8, 0, 0, 8, 6, 5, 2, 9, 9, 4, 8, 4, 5, 9, 3, 6, 2, 5, 9, 1, 2, 9, 4, 7, 7, 0, 5, 4, 0, 1, 4, 0, 8, 0, 7, 1, 1, 5, 9, 2, 4, 5, 7, 1, 2, 6, 5, 1, 9, 1, 5, 7, 5, 4, 1, 9, 8, 6, 6, 6, 9, 7, 2, 5, 5, 5, 7, 8, 1, 2, 8, 5, 0, 9, 0, 8, 8, 0, 9, 9, 7, 9, 7, 5, 3, 1, 6, 6, 6, 5, 4, 7, 2, 4, 9, 5, 9, 7, 7, 2, 8, 3, 4, 0, 3, 3, 5, 9, 4, 6, 4, 7, 2, 7, 0, 9, 4, 4, 8, 7, 7, 9, 3
THE_CHOSEN_NUMBER_FOR_THE_APPLE dw 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10
HOW_MUCH_APPLe_CHOSEN dw ?

;graffic
;apple
WHITE_APPLE db 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 48, 15, 15, 15, 15, 15, 15, 15, 15, 48, 48, 15, 15, 15, 15, 15, 15, 15, 4, 4, 4, 4, 15, 15, 15, 15, 15, 4, 4, 4, 4, 4, 4, 15, 15, 15, 15, 4, 4, 4, 4, 4, 4, 15, 15,  15, 15, 4, 4, 4, 4, 4, 4, 15, 15,  15, 15, 4, 4, 4, 4, 4, 4, 15, 15, 15, 15, 15, 4, 4, 4, 4, 15, 15, 15, 15, 15, 15, 15, 4, 4, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15
GREEN_APPLE db 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 48, 3, 3, 3, 3, 3, 3, 3, 3, 48, 48, 3, 3, 3, 3, 3, 3, 3, 4, 4, 4, 4, 3, 3, 3, 3, 3, 4, 4, 4, 4, 4, 4, 3, 3, 3, 3, 4, 4, 4, 4, 4, 4, 3, 3, 3, 3, 4, 4, 4, 4, 4, 4, 3, 3, 3, 3, 4, 4, 4, 4, 4, 4, 3, 3, 3, 3, 3, 4, 4, 4, 4, 3, 3, 3, 3, 3, 3, 3, 4, 4, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3

;head snake
;right
head_snake_right db 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 0 ,0, 48, 48, 48, 48, 48, 48, 48, 48, 0, 15, 48, 48,48, 48, 48, 48, 48, 48, 48, 48, 48, 4, 48, 48, 48, 48, 48, 48, 48, 48, 48, 4, 48, 48, 48, 48, 48, 48, 0, 15, 48, 48, 48, 48, 48, 48, 48, 48, 0, 0, 48, 48,48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48 
;left
head_snake_left db 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 0, 0, 48, 48, 48, 48, 48, 48, 48, 48, 15, 0, 48, 48, 48, 48, 48, 48, 4, 48, 48, 48, 48, 48, 48, 48, 48, 48, 4, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 15, 0, 48, 48, 48, 48, 48, 48, 48, 48, 0, 0, 48, 48, 48, 48,48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48
;up
head_snake_up db 48, 48, 48, 48 ,4, 4, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 0, 15, 48, 48, 15, 0, 48, 48, 48, 48, 0, 0, 48, 48, 0, 0, 48, 48 ,48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48 
;down
head_snake_down db 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 0, 0, 48, 48, 0, 0, 48, 48, 48, 48, 0, 15, 48, 48, 15, 0, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 4, 4, 48, 48, 48, 48
;the_rest_of_the_snake
body_snake db 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48, 48 

;עזרה ךפונקציות
;עוזר לזה שנוכל להדפיס את התפח מחדש(אם במקרה התפוח נוצר על הנחש)כ
color_of_apple db ?		
;עוזר ךפונקציה "הדפסת הלוח" כדי שתוכל לדעת לאן הנחש מסתכל
dircetion_of_the_snake db 2	
;עוזר לפונק יצירת תפוחים
how_much_apple_create dw 0

;;;
; --------------------------
CODESEG
;graffic_func
;יוצר תפוח ברקע לבן
proc create_white_apple
	push bp
	mov bp, sp
	push si
	push di
	push ax
	push dx
	push bx
	push cx
	
	lea bx, [WHITE_APPLE]
	
	mov si, 10
	mov ax, 10

	mov dx, [bp+4]			;y
	mov cx, [bp+6]			;x
	xor di, di

Loopx_create_white_apple:
	push ax
	
	xor ax, ax
	mov al, [bx+di]
	mov ah,0ch		;graffic
	int 10h			;graffic
	pop ax

	inc cx			;plus 1 for the x
	add di, 1
	sub si, 1
	cmp si, 0
	jg Loopx_create_white_apple
Loopy_create_white_apple:
	mov cx, [bp+6]	;חזרה לערך איקס המקורי
	mov si, 10		;back to x(10)
	
	add dx, 1		;plus 1 for the y
	sub ax, 1
	cmp ax, 0
	jg Loopx_create_white_apple
	
	pop cx 
	pop bx
	pop dx
	pop ax
	pop di
	pop si
	pop bp
	ret 4
endp create_white_apple

proc create_green_apple
	push bp
	mov bp, sp
	push si
	push di
	push ax
	push dx
	push bx
	push cx
	
	lea bx, [GREEN_APPLE]
	
	mov si, 10
	mov ax, 10

	mov dx, [bp+4]			;y
	mov cx, [bp+6]			;x
	xor di, di

Loopx_create_green_apple:
	push ax
	
	xor ax, ax
	mov al, [bx+di]
	mov ah,0ch		;graffic
	int 10h			;graffic
	pop ax

	inc cx			;plus 1 for the x
	add di, 1
	sub si, 1
	cmp si, 0
	jg Loopx_create_green_apple
Loopy_create_green_apple:
	mov cx, [bp+6]	;חזרה לערך איקס המקורי
	mov si, 10		;back to x(10)
	
	add dx, 1		;plus 1 for the y
	sub ax, 1
	cmp ax, 0
	jg Loopx_create_green_apple
	
	pop cx 
	pop bx
	pop dx
	pop ax
	pop di
	pop si
	pop bp
	ret 4
endp create_green_apple


;sanke_head
proc create_head_snake_right
	push bp
	mov bp, sp
	push si
	push di
	push ax
	push dx
	push bx
	push cx
	
	lea bx, [head_snake_right]
	
	mov si, 10
	mov ax, 10

	mov dx, [bp+4]			;y
	mov cx, [bp+6]			;x
	xor di, di

Loopx_create_head_snake_right:
	push ax
	
	xor ax, ax
	mov al, [bx+di]
	mov ah,0ch		;graffic
	int 10h			;graffic
	pop ax

	inc cx			;plus 1 for the x
	add di, 1
	sub si, 1
	cmp si, 0
	jg Loopx_create_head_snake_right
Loopy_create_head_snake_right:
	mov cx, [bp+6]	;חזרה לערך איקס המקורי
	mov si, 10		;back to x(10)
	
	add dx, 1		;plus 1 for the y
	sub ax, 1
	cmp ax, 0
	jg Loopx_create_head_snake_right
	
	
	pop cx 
	pop bx
	pop dx
	pop ax
	pop di
	pop si
	pop bp
	ret 4
endp create_head_snake_right


proc create_head_snake_left
	push bp
	mov bp, sp
	push si
	push di
	push ax
	push dx
	push bx
	push cx
	
	lea bx, [head_snake_left]
	
	mov si, 10
	mov ax, 10

	mov dx, [bp+4]			;y
	mov cx, [bp+6]			;x
	xor di, di

Loopx_create_head_snake_left:
	push ax
	
	xor ax, ax
	mov al, [bx+di]
	mov ah,0ch		;graffic
	int 10h			;graffic
	pop ax

	inc cx			;plus 1 for the x
	add di, 1
	sub si, 1
	cmp si, 0
	jg Loopx_create_head_snake_left
Loopy_create_head_snake_left:
	mov cx, [bp+6]	;חזרה לערך איקס המקורי
	mov si, 10		;back to x(10)
	
	add dx, 1		;plus 1 for the y
	sub ax, 1
	cmp ax, 0
	jg Loopx_create_head_snake_left
	
	pop cx 
	pop bx
	pop dx
	pop ax
	pop di
	pop si
	pop bp
	ret 4
endp create_head_snake_left


proc create_head_snake_up
	push bp
	mov bp, sp
	push si
	push di
	push ax
	push dx
	push bx
	push cx
	
	lea bx, [head_snake_up]
	
	mov si, 10
	mov ax, 10

	mov dx, [bp+4]			;y
	mov cx, [bp+6]			;x
	xor di, di

Loopx_create_head_snake_up:
	push ax
	
	xor ax, ax
	mov al, [bx+di]
	mov ah,0ch		;graffic
	int 10h			;graffic
	pop ax

	inc cx			;plus 1 for the x
	add di, 1
	sub si, 1
	cmp si, 0
	jg Loopx_create_head_snake_up
Loopy_create_head_snake_up:
	mov cx, [bp+6]	;חזרה לערך איקס המקורי
	mov si, 10		;back to x(10)
	
	add dx, 1		;plus 1 for the y
	sub ax, 1
	cmp ax, 0
	jg Loopx_create_head_snake_up
	
	pop cx 
	pop bx
	pop dx
	pop ax
	pop di
	pop si
	pop bp
	ret 4
endp create_head_snake_up


proc create_head_snake_down
	push bp
	mov bp, sp
	push si
	push di
	push ax
	push dx
	push bx
	push cx
	
	lea bx, [head_snake_down]
	
	mov si, 10
	mov ax, 10

	mov dx, [bp+4]			;y
	mov cx, [bp+6]			;x
	xor di, di

Loopx_create_head_snake_down:
	push ax
	
	xor ax, ax
	mov al, [bx+di]
	mov ah,0ch		;graffic
	int 10h			;graffic
	pop ax

	inc cx			;plus 1 for the x
	add di, 1
	sub si, 1
	cmp si, 0
	jg Loopx_create_head_snake_down
Loopy_create_head_snake_down:
	mov cx, [bp+6]	;חזרה לערך איקס המקורי
	mov si, 10		;back to x(10)
	
	add dx, 1		;plus 1 for the y
	sub ax, 1
	cmp ax, 0
	jg Loopx_create_head_snake_down
	
	pop cx 
	pop bx
	pop dx
	pop ax
	pop di
	pop si
	pop bp
	ret 4
endp create_head_snake_down


proc create_body_of_the_snake
	push bp
	mov bp, sp
	push si
	push di
	push ax
	push dx
	push bx
	push cx
	
	lea bx, [body_snake]
	
	mov si, 10
	mov ax, 10

	mov dx, [bp+4]			;y
	mov cx, [bp+6]			;x
	xor di, di

Loopx_create_body_of_the_snake:
	push ax
	
	xor ax, ax
	mov al, [bx+di]
	mov ah,0ch		;graffic
	int 10h			;graffic
	pop ax

	inc cx			;plus 1 for the x
	add di, 1
	sub si, 1
	cmp si, 0
	jg Loopx_create_body_of_the_snake
Loopy_create_body_of_the_snake:
	mov cx, [bp+6]	;חזרה לערך איקס המקורי
	mov si, 10		;back to x(10)
	
	add dx, 1		;plus 1 for the y
	sub ax, 1
	cmp ax, 0
	jg Loopx_create_body_of_the_snake
	
	pop cx 
	pop bx
	pop dx
	pop ax
	pop di
	pop si
	pop bp
	ret 4
endp create_body_of_the_snake


;number in apple
;0
proc zero_on_apple
	push bp
	mov bp, sp
	push si
	push di
	push ax
	push dx
	push bx
	push cx
	
	mov dx, [bp+4]			;y
	mov cx, [bp+6]			;x
	
	add cx, 3
	add dx, 4
	mov al, 0
	
	;נעבור על כל הפיקסלים כדי להדפיס 0

	
	mov ah,0ch		;graffic
	int 10h			;graffic
	
	add cx, 1
	mov ah,0ch		;graffic
	int 10h			;graffic
	
	add cx, 1
	mov ah,0ch		;graffic
	int 10h			;graffic
	
	add dx, 1
	mov ah,0ch		;graffic
	int 10h			;graffic
	
	add dx, 1
	mov ah,0ch		;graffic
	int 10h			;graffic
	
	add dx, 1
	mov ah,0ch		;graffic
	int 10h			;graffic
	
	add dx, 1
	mov ah,0ch		;graffic
	int 10h			;graffic
	
	sub cx, 1
	mov ah,0ch		;graffic
	int 10h			;graffic
	
	sub cx, 1
	mov ah,0ch		;graffic
	int 10h			;graffic
	
	sub dx, 1
	mov ah,0ch		;graffic
	int 10h			;graffic
	
	sub dx, 1
	mov ah,0ch		;graffic
	int 10h			;graffic
	
	sub dx, 1
	mov ah,0ch		;graffic
	int 10h			;graffic
	

	
	pop cx 
	pop bx
	pop dx
	pop ax
	pop di
	pop si
	pop bp
	ret 4
endp zero_on_apple




;1
proc one_on_apple
	push bp
	mov bp, sp
	push si
	push di
	push ax
	push dx
	push bx
	push cx
	
	mov dx, [bp+4]			;y
	mov cx, [bp+6]			;x
	
	add cx,4
	add dx, 4
	
	mov al, 0
	
	mov si, 4
	mov di, 2
loopx_one_on_apple:
	push ax
	
	mov ah,0ch		;graffic
	int 10h			;graffic
	pop ax
	
	inc dx			;plus 1 for the x
	sub si, 1
	cmp si, 0
	jg loopx_one_on_apple
loopy_one_on_apple:
	mov dx, [bp+4]	;חזרה לערך איקס המקורי
	add dx,4

	mov si, 4		;back to x(10)
	
	add cx, 1		;plus 1 for the y
	sub di, 1
	cmp di, 0
	jg loopx_one_on_apple
	
	pop cx 
	pop bx
	pop dx
	pop ax
	pop di
	pop si
	pop bp
	ret 4
endp one_on_apple

;2
proc two_on_apple
	push bp
	mov bp, sp
	push si
	push di
	push ax
	push dx
	push bx
	push cx
	
	mov dx, [bp+4]			;y
	mov cx, [bp+6]			;x
	
	add cx, 3
	add dx, 4
	mov al, 0		;color
	
	;נעבור על על הפיקסלים שנצרכים כדי להדפיס 2
	
	mov ah,0ch		;graffic
	int 10h			;graffic
	
	add cx, 1
	mov ah,0ch		;graffic
	int 10h			;graffic
	
	add cx, 1
	mov ah,0ch		;graffic
	int 10h			;graffic
	
	add dx, 1
	mov ah,0ch		;graffic
	int 10h			;graffic
	
	add dx, 1
	mov ah,0ch		;graffic
	int 10h			;graffic
	
	sub cx, 1
	mov ah,0ch		;graffic
	int 10h			;graffic
	
	sub cx, 1
	mov ah,0ch		;graffic
	int 10h			;graffic
	
	add dx, 1
	mov ah,0ch		;graffic
	int 10h			;graffic
	
	add dx, 1
	mov ah,0ch		;graffic
	int 10h			;graffic
	
	add cx, 1
	mov ah,0ch		;graffic
	int 10h			;graffic

	add cx, 1
	mov ah,0ch		;graffic
	int 10h			;graffic

	
	pop cx 
	pop bx
	pop dx
	pop ax
	pop di
	pop si
	pop bp
	ret 4
endp two_on_apple

;3
proc three_on_apple
	push bp
	mov bp, sp
	push si
	push di
	push ax
	push dx
	push bx
	push cx
	
	mov dx, [bp+4]			;y
	mov cx, [bp+6]			;x
	
	add cx, 3
	add dx, 4
	mov al, 0
	
	;נעבור על כל הפיקלסים כדי ליצור את המספר 3

	
	mov ah,0ch		;graffic
	int 10h			;graffic
		
	add cx, 1
	mov ah,0ch		;graffic
	int 10h			;graffic
	
	add cx, 1
	mov ah,0ch		;graffic
	int 10h			;graffic
	
	add dx, 1
	mov ah,0ch		;graffic
	int 10h			;graffic
	
	add dx, 1
	mov ah,0ch		;graffic
	int 10h			;graffic
	
	sub cx, 1
	mov ah,0ch		;graffic
	int 10h			;graffic
	
	sub cx, 1
	mov ah,0ch		;graffic
	int 10h			;graffic
	
	add cx, 2
	add dx, 1
	mov ah,0ch		;graffic
	int 10h			;graffic
	
	add dx, 1
	mov ah,0ch		;graffic
	int 10h			;graffic
	
	sub cx, 1
	mov ah,0ch		;graffic
	int 10h			;graffic
	
	sub cx, 1
	mov ah,0ch		;graffic
	int 10h			;graffic

	

	
	pop cx 
	pop bx
	pop dx
	pop ax
	pop di
	pop si
	pop bp
	ret 4
endp three_on_apple

;4
proc four_on_apple
	push bp
	mov bp, sp
	push si
	push di
	push ax
	push dx
	push bx
	push cx
	
	mov dx, [bp+4]			;y
	mov cx, [bp+6]			;x
	
	add cx, 3
	add dx, 4
	mov al, 0
	
	;נעבור על כל הפיקסלים כדי לעבור על המספר המבוקש

	
	mov ah,0ch		;graffic
	int 10h			;graffic
	
	add dx, 1
	mov ah,0ch		;graffic
	int 10h			;graffic
	
	add dx, 1
	mov ah,0ch		;graffic
	int 10h			;graffic
	
	add cx, 1
	mov ah,0ch		;graffic
	int 10h			;graffic
	
	add cx, 1
	mov ah,0ch		;graffic
	int 10h			;graffic
	
	add dx, 1
	mov ah,0ch		;graffic
	int 10h			;graffic
	
	add dx, 1
	mov ah,0ch		;graffic
	int 10h			;graffic
	
	sub dx, 4
	mov ah,0ch		;graffic
	int 10h			;graffic

	add dx, 1 
	mov ah,0ch		;graffic
	int 10h			;graffic
	

	
	pop cx 
	pop bx
	pop dx
	pop ax
	pop di
	pop si
	pop bp
	ret 4
endp four_on_apple

;5

proc five_on_apple
	push bp
	mov bp, sp
	push si
	push di
	push ax
	push dx
	push bx
	push cx
	
	mov dx, [bp+4]			;y
	mov cx, [bp+6]			;x
	
	add cx, 5
	add dx, 4
	mov al, 0
	
	;נעבור על כל הפיקסלים כדי לעבור על המספר המבוקש

	
	mov ah,0ch		;graffic
	int 10h			;graffic
	
	sub cx, 1
	mov ah,0ch		;graffic
	int 10h			;graffic
	
	sub cx, 1
	mov ah,0ch		;graffic
	int 10h			;graffic
	
	add dx, 1
	mov ah,0ch		;graffic
	int 10h			;graffic
	
	add dx, 1
	mov ah,0ch		;graffic
	int 10h			;graffic
	
	add cx, 1
	mov ah,0ch		;graffic
	int 10h			;graffic
	
	add cx, 1
	mov ah,0ch		;graffic
	int 10h			;graffic
	
	add dx, 1
	mov ah,0ch		;graffic
	int 10h			;graffic
	
	add dx, 1
	mov ah,0ch		;graffic
	int 10h			;graffic
	
	sub cx, 1
	mov ah,0ch		;graffic
	int 10h			;graffic
	
	sub cx, 1
	mov ah,0ch		;graffic
	int 10h			;graffic
	

	
	pop cx 
	pop bx
	pop dx
	pop ax
	pop di
	pop si
	pop bp
	ret 4
endp five_on_apple


;6
proc six_on_apple
	push bp
	mov bp, sp
	push si
	push di
	push ax
	push dx
	push bx
	push cx
	
	mov dx, [bp+4]			;y
	mov cx, [bp+6]			;x
	
	add cx, 5
	add dx, 4
	mov al, 0
	
	;נעבור על כל הפיקסלים כדי לעבור על המספר המבוקש

	
	mov ah,0ch		;graffic
	int 10h			;graffic
	
	sub cx, 1
	mov ah,0ch		;graffic
	int 10h			;graffic
	
	sub cx, 1
	mov ah,0ch		;graffic
	int 10h			;graffic
	
	add dx, 1
	mov ah,0ch		;graffic
	int 10h			;graffic
	
	add dx, 1
	mov ah,0ch		;graffic
	int 10h			;graffic
	
	add cx, 1
	mov ah,0ch		;graffic
	int 10h			;graffic
	
	add cx, 1
	mov ah,0ch		;graffic
	int 10h			;graffic
	
	add dx, 1
	mov ah,0ch		;graffic
	int 10h			;graffic
	
	add dx, 1
	mov ah,0ch		;graffic
	int 10h			;graffic
	
	sub cx, 1
	mov ah,0ch		;graffic
	int 10h			;graffic
	
	sub cx, 1
	mov ah,0ch		;graffic
	int 10h			;graffic
	
	sub dx, 1
	mov ah,0ch		;graffic
	int 10h			;graffic

	
	pop cx 
	pop bx
	pop dx
	pop ax
	pop di
	pop si
	pop bp
	ret 4
endp six_on_apple


;7
proc seven_on_apple
	push bp
	mov bp, sp
	push si
	push di
	push ax
	push dx
	push bx
	push cx
	
	mov dx, [bp+4]			;y
	mov cx, [bp+6]			;x
	
	add cx, 3
	add dx, 4
	mov al, 0
	
	;נעבור על כל הפיקסלים כדי לעבור על המספר המבוקש

	
	mov ah,0ch		;graffic
	int 10h			;graffic
	
	add cx, 1
	mov ah,0ch		;graffic
	int 10h			;graffic
	
	add cx, 1
	mov ah,0ch		;graffic
	int 10h			;graffic
	
	add dx, 1
	mov ah,0ch		;graffic
	int 10h			;graffic
	
	add dx, 1
	mov ah,0ch		;graffic
	int 10h			;graffic
	
	add dx, 1
	mov ah,0ch		;graffic
	int 10h			;graffic
	
	add dx, 1
	mov ah,0ch		;graffic
	int 10h			;graffic


	
	pop cx 
	pop bx
	pop dx
	pop ax
	pop di
	pop si
	pop bp
	ret 4
endp seven_on_apple

;8
proc eight_on_apple
	push bp
	mov bp, sp
	push si
	push di
	push ax
	push dx
	push bx
	push cx
	
	mov dx, [bp+4]			;y
	mov cx, [bp+6]			;x
	

	mov al, 0
	
	;נעבור על כל הפיקסלים כדי לעבור על המספר המבוקש

	
	push cx
	push dx
	call zero_on_apple
	
	add cx, 4
	add dx, 6
	
	mov ah,0ch		;graffic
	int 10h			;graffic
	

	
	pop cx 
	pop bx
	pop dx
	pop ax
	pop di
	pop si
	pop bp
	ret 4
endp eight_on_apple




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
	
;9
proc nine_on_apple
	push bp
	mov bp, sp
	push si
	push di
	push ax
	push dx
	push bx
	push cx
	
	mov dx, [bp+4]			;y
	mov cx, [bp+6]			;x
	
	add cx, 5
	add dx, 6
	mov al, 0
	
	;נעבור על כל הפיקסלים כדי לעבור על המספר המבוקש

	
	mov ah,0ch		;graffic
	int 10h			;graffic
	
	sub cx, 1
	mov ah,0ch		;graffic
	int 10h			;graffic
	
	sub cx, 1
	mov ah,0ch		;graffic
	int 10h			;graffic
	
	sub dx, 1
	mov ah,0ch		;graffic
	int 10h			;graffic
	
	sub dx, 1
	mov ah,0ch		;graffic
	int 10h			;graffic
	
	
	push [bp+6]
	push [bp+4]
	call seven_on_apple

	add cx, 2
	add dx, 4
	mov ah,0ch		;graffic
	int 10h			;graffic
	
	sub cx, 1
	mov ah,0ch		;graffic
	int 10h			;graffic
	
	sub cx, 1
	mov ah,0ch		;graffic
	int 10h			;graffic

	
	pop cx 
	pop bx
	pop dx
	pop ax
	pop di
	pop si
	pop bp
	ret 4
endp nine_on_apple	
	
	
;יוצר מיקום של תפוח
proc create_apple
	push bx
	push ax
	push es
	push dx
	push di
	push si
	
;כדי לבדוק כמה תפוחים נאספו, נוריד מאורך הנחש 4
;כי אורך הנחש מתחיל ב 4
	
	mov si, [how_much_apple_create]
	
	
	lea bx, [APPLE_PLACE]
	mov dx, [bx+si]
	add dx, 40
	mov [applex], dx
	push dx		;push x
	
	lea bx, [APPLE_PLACE]
	mov dx, [bx+si+2]
	mov [appley], dx
	push dx		;push y
	
	add [how_much_apple_create], 4
	
	
;נרצה לבדוק מה הרקע לתפוח

	mov ax, [appley]
	mov bl, 10
	div bl
;נבדוק אם השורה זוגית או איזוגית (כדי שנפעל בהתאם ביחס לטורים) מ
	mov bl, 2
	xor ah, ah
	div bl
	
	cmp ah, 0
	jne check_odd_2_create_apple
;check_even_2

;באופן דומה נחלק ב 10
	xor ax, ax
	mov ax, [applex]
	mov bl, 10
	div bl

;נבדוק אם אנחנו בטור זוגי או לא, ונפעל בהתאם	
	mov bl, 2
	xor ah, ah
	div bl
	
	cmp ah, 0
	jne call_green_apple_even
	call create_white_apple
	
	mov [color_of_apple], 0
	
	jmp end_create_apple
	
call_green_apple_even:

	call create_green_apple
	mov [color_of_apple], 1
	
	jmp end_create_apple
	
check_odd_2_create_apple:
;באופן דומה נחלק ב 10

	xor ax, ax
	mov ax, [applex]
	mov bl, 10
	div bl
	
;נבדוק אם אנחנו בטור זוגי או לא, ונפעל בהתאם	
	mov bl, 2
	xor ah, ah
	div bl
	
	cmp ah, 0
	jne call_white_apple_odd
	
	call create_green_apple
	mov [color_of_apple], 1
	
	jmp end_create_apple
	
call_white_apple_odd:
	call create_white_apple
	mov [color_of_apple], 0
	


end_create_apple:
;בוחר את המספר שיוצג על התפוח

	

	
	lea bx, [NUMBER_FOR_THE_APPLE]
	mov di, [appley]
	mov si, [bx+di]
	mov [applenum], si
	




	
	
	
end_create_num_on_apple:
	lea bx, [THE_CHOSEN_NUMBER_FOR_THE_APPLE]
	mov di, [HOW_MUCH_APPLe_CHOSEN]
	mov [word ptr bx+di], si
	
	add [HOW_MUCH_APPLe_CHOSEN], 2
	

	
	pop si
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
;שומר במקום הראשון את האיקס הראשון, במקום השני את הוואי הראשון, וכן הלאה
; initialize
	xor bx, bx
	xor di, di
	xor si, si
	
	mov ax, 40h
	mov es, ax
	mov cx, 400
	
RandLoop_x:
	; generate random number, cx number of times
	mov ax, [Clock] ; read timer counter
	mov ah, [byte cs:bx] ; read one byte from memory
	xor al, ah ; xor memory and counter
	and al, 00001111b ; leave result between 0-15
	mov dl, al
	
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


proc check_lose
	push bx
	push dx
	push cx
	push ax
	push di
	
	
	lea bx, [snake]
	
;בדיקה אם הנחש יצא מהשטח
	;x check1
	mov dx, [bx]		;הראש של הנחש איקס
;צד ימין
	cmp dx, 10
	jl lose
;צד שמאל
	cmp dx, 300
	jg lose

	
	;y check
	mov dx, [bx+2]		;הראש של הנחש וואי
;למעלה
	cmp dx, 10
	jl lose
;למטה
	cmp dx, 180
	jg lose
	
	
;בדיקה אם הנחש נגע בעצמו
	mov dx, [bx]		;נשווה עם כל מיקומי הנחש
	mov ax, [bx+2]
	
	xor cx, cx
	mov cl, [snake_lengh]
	sub cx, 1		;כי לא צריך לבדוק אם הראש של הנחש פוגע בעצמו
	
	mov di, 4
	
	check_lose_loop:
	cmp dx, [bx+di]
	jne end_check_lose_loop
	cmp ax, [bx+di+2]
	jne end_check_lose_loop
	jmp lose
end_check_lose_loop:
	add di, 4
	loop check_lose_loop
	
	jmp not_lose
	
lose:
	call lose_game
not_lose:
	
	
	pop di
	pop ax
	pop cx
	pop dx
	pop bx
	ret
endp check_lose

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
	jne check_odd_2_CHANGEBOARD
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
	
check_odd_2_CHANGEBOARD:
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
	
	
	;שינוי הערך הראשון (החדש) לריבוע לסנייק
	lea bx, [snake]
	mov cx, [bx]		;x
	mov dx, [bx+2]		;y
	
	push cx		;push x
	push dx		;push y
;בודק איזה כיוון הנחש

check_head_of_the_snake_right:
	cmp [dircetion_of_the_snake], 1	
	jne check_head_of_the_snake_left
	call create_head_snake_right
	jmp create_the_body_of_the_snake
	
check_head_of_the_snake_left:
	cmp [dircetion_of_the_snake], 2	
	jne check_head_of_the_snake_down
	call create_head_snake_left
	jmp create_the_body_of_the_snake

check_head_of_the_snake_down:
	cmp [dircetion_of_the_snake], 3	
	jne check_head_of_the_snake_up 
	call create_head_snake_down
	jmp create_the_body_of_the_snake
	
check_head_of_the_snake_up:
	call create_head_snake_up
	
create_the_body_of_the_snake:	
	mov di, 4
	xor ax, ax
	mov al, [snake_lengh]
	sub ax, 1 		;כי על החלק הראשון של הנחש עברנו כבר

loop_body_of_the_snake:
	mov cx, [bx+di]
	mov dx, [bx+di+2]
	
	push cx
	push dx
	
	call create_body_of_the_snake
	add di, 4
	sub ax, 1
	cmp ax, 0
	jne loop_body_of_the_snake
	
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
	
	cmp [snake_lengh] , 16
	jl exit_check_apple
	call win_game
	
exit_check_apple:


	pop di
	pop bx
	ret 
endp check_apple
	

proc win_game
	push ds
	push dx
	push ax
	push bx
	push di
	push cx
	
	mov cx, 30
loop_sleep_one_sec:
	call sleep
	loop loop_sleep_one_sec
	
	
;text mode
	mov ah, 0
	mov al, 2
	int 10h
	


	
;print win massenge	
	push seg WIN_TEXT
	pop ds
	mov dx, offset WIN_TEXT

	mov ah, 9h
	int 21h
	
	jmp exit
	
	pop cx 
	pop di
	pop bx
	pop ax
	pop dx
	pop ds
	ret 0
endp win_game




proc lose_game
	push ds
	push dx
	push ax
	
	mov ah, 0
	mov al, 2
	int 10h

	
	push seg LOSE_TEXT
	pop ds
	mov dx, offset LOSE_TEXT

	mov ah, 9h
	int 21h
	
	jmp exit
	
	pop ax
	pop dx
	pop ds
	ret 2
endp lose_game




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
	call check_lose
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
	
	;בדיקה אם ההפך מהקודם
	cmp dx, 2
	je WaitForData
	
	mov dx, 1			;Right
	mov [dircetion_of_the_snake], 1
	xor ax, ax
	jmp WaitForData
	
check2:
	cmp ah, 1Eh			;A = Left
	jne check3
	
	;בדיקה אם ההפך מהקודם
	cmp dx, 1
	je WaitForData
	
	mov dx, 2			; Left
	mov [dircetion_of_the_snake], 2
	xor ax, ax
	jmp WaitForData
	
check3:
	cmp ah, 1Fh			;S = Down
	jne check4
	
	;בדיקה אם ההפך מהקודם
	cmp dx, 4
	je WaitForData
	
	mov dx, 3			;Down
	mov [dircetion_of_the_snake], 3
	xor ax, ax
	jmp WaitForData

check4:
	cmp ah, 11h			;W = up
	jne check5
	
	;בדיקה אם ההפך מהקודם
	cmp dx, 3
	je WaitForData
	
	mov dx, 4			;up
	mov [dircetion_of_the_snake], 4
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
	