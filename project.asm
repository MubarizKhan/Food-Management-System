; Restaurant Billing System

; Restaurant Billing system is a program that allows people to choose 
; from a list of menu items until they
; have everything they've wanted to order and then calculate the total
; bill when they are finished selecting from a list.

Include Irvine32.inc

.386
.model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword
; include mouse.inc 

.data
     bill DWORD 0
    string BYTE '           WELCOME TO RESTAURANT',0dh,0ah,0
     string1 BYTE ' Menu:',0dh,0ah
             BYTE '      Enter 1 - Chicken food ',0dh,0ah
             BYTE '      Enter 2 - Chinese food ',0dh,0ah
             BYTE '      Enter 3 - Fast food ',0dh,0ah
             BYTE '      Enter 4 - Drinks ',0dh,0ah
             BYTE '      Enter 5 - Dessert ',0dh,0ah
             BYTE '      Enter 6 - Naan ',0dh,0ah
             BYTE '      Enter 7 - Exit ',0dh,0ah,0

    string2  BYTE '      Enter 1- To continue',0dh,0ah
             BYTE '      Enter 2 - Exit ',0dh,0ah,0

    string3  BYTE '      Enter 1 - Naan   =   Rs 10',0dh,0ah
             BYTE '      Enter 2 - Roti   =   Rs 05',0dh,0ah
             BYTE '      Enter 3 - Exit ',0dh,0ah,0

    buffer3 DWORD 10,05 ;Naan aur roti ki price

    string4  BYTE '      Enter 1 - Chicken Briyani  =  Rs 100 per plate',0dh,0ah
             BYTE '      Enter 2 - Chicken Karahi   =  Rs 90 per plate',0dh,0ah
             BYTE '      Enter 3 - Chicken Tikka    =  Rs 70 per plate',0dh,0ah
             BYTE '      Enter 4 - Murgh Haleem     =  Rs 85 per plate',0dh,0ah
             BYTE '      Enter 5 - Exit ',0dh,0ah,0

    buffer4 DWORD 100,90,70,85 ; array containing price of biryani, karahi etc

    string5  BYTE '      Enter 1 - Egg Fried Rice               =  Rs 150 per plate ',0dh,0ah
             BYTE '      Enter 2 - Chicken Manchurian with rice =  Rs 165 per plate ',0dh,0ah
             BYTE '      Enter 3 - Chicken Macroni              =  Rs 95 per plate ',0dh,0ah
             BYTE '      Enter 4 - Chicken Shahlik              =  Rs 80 per plate ',0dh,0ah
             BYTE '      Enter 5 - Exit ',0dh,0ah,0

   buffer5 DWORD 150,165,95,80

    string6  BYTE '      Enter 1 - Zinger Burger    =  Rs 100 ',0dh,0ah
             BYTE '      Enter 2 - Chicken Pizza    =  Rs 150',0dh,0ah
             BYTE '      Enter 3 - French Fries     =  Rs 50',0dh,0ah
             BYTE '      Enter 4 - Chicken Shawarma =  Rs 95',0dh,0ah
             BYTE '      Enter 5 - Exit ',0dh,0ah,0

    buffer6 DWORD 100,150,50,95

    string7  BYTE '      Enter 1 - Coca Cola      =  Rs 90 (1.5 litre)',0dh,0ah
             BYTE '      Enter 2 - Sprite         =  Rs 90 (1.5 litre)',0dh,0ah
             BYTE '      Enter 3 - Mint Margarita =  Rs 65',0dh,0ah
             BYTE '      Enter 4 - Pineapple Juice=  Rs 70',0dh,0ah
             BYTE '      Enter 5 - Exit ',0dh,0ah,0

    buffer7 DWORD 90,90,65,70

    string8  BYTE '      Enter 1 - Choclate Cake     =  Rs 155',0dh,0ah
             BYTE '      Enter 2 - Brownie           =  Rs 145',0dh,0ah
             BYTE '      Enter 3 - Cocunut Cream Pie =  Rs 75',0dh,0ah
             BYTE '      Enter 4 - Vanilla Ice-cream =  Rs 60',0dh,0ah
             BYTE '      Enter 5 - Exit ',0dh,0ah,0

    buffer8 DWORD 155,145,75,60
    
    spaces BYTE '      Enter --->  ',0

    spaces1 BYTE '      Re-Enter --->  ',0

    errorMsg BYTE '   -> INVALID ENTRY !!! ',0dh,0ah,0

    Quantity BYTE '      Quantity:     ',0

    billing BYTE  '      Total Bill:   Rs. ',0    

.code
main proc

    ; invoke main1
     call Crlf
     call Crlf
    mov edx,OFFSET string
     call WriteString
     L1:                         
       mov edx,OFFSET string1
       call WriteString
       call Crlf
       mov edx,OFFSET spaces
       call WriteString
       call Readint
       call Crlf
       call Checkerror    ; check whether user enter the number in given range

       cmp eax,1      ; comparison b/w what user enter with each item of list
       je L2
       cmp eax,2
       je L3
       cmp eax,3
       je L4
       cmp eax,4
       je L5
       cmp eax,5
       je L6
       cmp eax,6
       je L8
       jmp last

     L2: call Chicken       ; calling procedures depends on what user enters
         jmp L7
     L3: call Chinese
         jmp L7
     L4: call FastFood
         jmp L7
     L5: call Drinks
         jmp L7
     L6: call Dessert
         jmp L7
     L8: call NaanRoti
     L7: mov edx,OFFSET string2
         call WriteString
         mov edx,OFFSET spaces
         call WriteString
         call Readint
         call Checkerror1
         cmp eax,1           ; if user want to continue then jump to L1
         je L1
     last:                    
         call Crlf
         call Crlf
         mov edx,OFFSET billing
         call WriteString
         mov eax,bill        
         call Writeint       ; prints the bill
         call Crlf           ; next line
         call Crlf
         call WaitMsg
    invoke ExitProcess,0
main endp


Chicken PROC

; print the oriental menu and add prices into bill according to which item of what quantity user selects 
; and call another func(NaanRoti) according to requirment
; Receives: string4, buffer4
; Returns: return updated bill
;-------------------------------------------------------------------------------------------------------
         mov edx,OFFSET string4
         call WriteString
         call Crlf
         mov edx,OFFSET spaces
         call WriteString
         call Readint
         call Crlf
         call Crlf
         call Checkerror3
         cmp eax,1
         je L1
         cmp eax,2
         je L2
         cmp eax,3
         je L3
         cmp eax,4
         je L4
         cmp eax,5
         jmp last
 L1: mov edx,OFFSET Quantity
     call WriteString
     call Readint
     call Crlf
     mov ecx,eax
     mov ebx,[buffer4]      ; buffer4 is array contains price of oriental foods
     L11:                   ; quantity times a loop L11 runs           
        add bill,ebx            ; add price into bill
        loop L11
     jmp last
 L2: mov edx,OFFSET Quantity
     call WriteString
     call Readint
     call Crlf
     mov ecx,eax
     mov ebx,[buffer4 + 4]
     L22:
         add bill,ebx
         loop L22
     call NaanRoti
     jmp last
 L3: mov edx,OFFSET Quantity
     call WriteString
     call Readint
     call Crlf
     mov ecx,eax
     mov ebx,[buffer4 + 8]
     L33:
         add bill,ebx
         loop L33
     call NaanRoti
     jmp last
 L4: mov edx,OFFSET Quantity
     call WriteString
     call Readint
     call Crlf
     mov ecx,eax
     mov ebx,[buffer4 + 12]
     L44:
         add bill,ebx
         loop L44
     call NaanRoti
last:
ret
Chicken ENDP

NaanRoti PROC


; print the menu(naan,roti) and add prices into bill according to which item of what quantity user selects 
; Receives: string3, buffer3
; Returns: return updated bill
;---------------------------------------------------------------------------------------------------------
 
        mov edx,OFFSET string3
        call WriteString
        call Crlf
        mov edx,OFFSET spaces
        call WriteString
        call Readint
        call Crlf
        call Checkerror2
        cmp eax,1
        je L1
        cmp eax,2
        je L2
        jmp last
     L1:
        mov ebx,[buffer3]    ; buuffer3 is array contains price of Naan and roti
        mov edx,OFFSET Quantity
        call WriteString
        call Readint
        call Crlf
        mov ecx,eax
        L11:
          add bill,ebx
          loop L11
       jmp last
     L2:
        mov ebx,[buffer3 + 4]
        mov edx,OFFSET Quantity
        call WriteString
        call Readint
        call Crlf
        mov ecx,eax
        L22:
          add bill,ebx
          loop L22
last:
ret
NaanRoti ENDP


Chinese PROC
 

; print the chinese menu and add prices into bill according to which item of what quantity user selects 
; Receives: string5, buffer5
; Returns: return updated bill
;------------------------------------------------------------------------------------------------------
         mov edx,OFFSET string5
         call WriteString
         call Crlf
         mov edx,OFFSET spaces
         call WriteString
         call Readint
         call Crlf
         call Crlf
         call Checkerror3       ; check for error
         cmp eax,1
         je L1
         cmp eax,2
         je L2
         cmp eax,3
         je L3
         cmp eax,4
         je L4
         cmp eax,5
         jmp last

 ; price of 1st,2nd,.. item of Chinese menu is on 1st,2nd.. index of buffer5 respectively
 ; same for all other menus

 L1: mov edx,OFFSET Quantity
     call WriteString
     call Readint
     mov ecx,eax
     mov ebx,[buffer5]   
     L11:
        add bill,ebx
        loop L11
     jmp last
 L2: mov edx,OFFSET Quantity
     call WriteString
     call Readint
     mov ecx,eax
     mov ebx,[buffer5 + 4]
     L22:
         add bill,ebx
         loop L22
     jmp last
 L3: mov edx,OFFSET Quantity
     call WriteString
     call Readint
     call Crlf
     mov ecx,eax
     mov ebx,[buffer5 + 8]
     L33:
         add bill,ebx
         loop L33
     jmp last
 L4: mov edx,OFFSET Quantity
     call WriteString
     call Readint
     call Crlf
     mov ecx,eax
     mov ebx,[buffer5 + 12]
     L44:
         add bill,ebx
         loop L44
last:

ret
Chinese ENDP
         
FastFood PROC


; print the fastfood menu and add prices into bill according to which item of what quantity user selects 
; Receives: string6, buffer6
; Returns: return updated bill
;-------------------------------------------------------------------------------------------------------
         mov edx,OFFSET string6
         call WriteString
         call Crlf
         mov edx,OFFSET spaces
         call WriteString
         call Readint
         call Crlf
         call Crlf
         call Checkerror3
         cmp eax,1
         je L1
         cmp eax,2
         je L2
         cmp eax,3
         je L3
         cmp eax,4
         je L4
         cmp eax,5
         jmp last
 L1: mov edx,OFFSET Quantity
     call WriteString
     call Readint
     call Crlf
     mov ecx,eax
     mov ebx,[buffer6]
     L11:
        add bill,ebx
        loop L11
     jmp last
 L2: mov edx,OFFSET Quantity
     call WriteString
     call Readint
     call Crlf
     mov ecx,eax
     mov ebx,[buffer6 + 4]
     L22:
         add bill,ebx
         loop L22
     jmp last
 L3: mov edx,OFFSET Quantity
     call WriteString
     call Readint
     call Crlf
     mov ecx,eax
     mov ebx,[buffer6 + 8]
     L33:
         add bill,ebx
         loop L33
     jmp last
 L4: mov edx,OFFSET Quantity
     call WriteString
     call Readint
     call Crlf
     mov ecx,eax
     mov ebx,[buffer6 + 12]
     L44:
         add bill,ebx
         loop L44
last:
ret
FastFood ENDP
         
Drinks PROC


; print the drinks menu and add prices into bill according to which item of what quantity user selects 
; Receives: string7, buffer7
; Returns: return updated bill
;-----------------------------------------------------------------------------------------------------
         mov edx,OFFSET string7
         call WriteString
         call Crlf
         mov edx,OFFSET spaces
         call WriteString
         call Readint
         call Crlf
         call Crlf
         call Checkerror3
         cmp eax,1
         je L1
         cmp eax,2
         je L2
         cmp eax,3
         je L3
         cmp eax,4
         je L4
         cmp eax,5
         jmp last
 L1: mov edx,OFFSET Quantity
     call WriteString
     call Readint
     call Crlf
     mov ecx,eax
     mov ebx,[buffer7]
     L11:
        add bill,ebx
        loop L11
     jmp last
 L2: mov edx,OFFSET Quantity
     call WriteString
     call Readint
     call Crlf
     mov ecx,eax
     mov ebx,[buffer7 + 4]
     L22:
         add bill,ebx
         loop L22
     jmp last
 L3: mov edx,OFFSET Quantity
     call WriteString
     call Readint
     call Crlf
     mov ecx,eax
     mov ebx,[buffer7 + 8]
     L33:
         add bill,ebx
         loop L33
     jmp last
 L4: mov edx,OFFSET Quantity
     call WriteString
     call Readint
     call Crlf
     mov ecx,eax
     mov ebx,[buffer7 + 12]
     L44:
         add bill,ebx
         loop L44
last:
ret
Drinks ENDP
         
Dessert PROC


; print the dessert menu and add prices into bill according to which item of what quantity user selects 
; Receives: string8, buffer8
; Returns: return updated bill
;------------------------------------------------------------------------------------------------------
         mov edx,OFFSET string8
         call WriteString
         call Crlf
         mov edx,OFFSET spaces
         call WriteString
         call Readint
         call Crlf
         call Crlf
         call Checkerror3
         cmp eax,1
         je L1
         cmp eax,2
         je L2
         cmp eax,3
         je L3
         cmp eax,4
         je L4
         cmp eax,5
         jmp last
 L1: mov edx,OFFSET Quantity
     call WriteString
     call Readint
     call Crlf
     mov ecx,eax
     mov ebx,[buffer8]
     L11:
        add bill,ebx
        loop L11
     jmp last
 L2: mov edx,OFFSET Quantity
     call WriteString
     call Readint
     call Crlf
     mov ecx,eax
     mov ebx,[buffer8 + 4]
     L22:
         add bill,ebx
         loop L22
     jmp last
 L3: mov edx,OFFSET Quantity
     call WriteString
     call Readint
     mov ecx,eax
     call Crlf
     mov ebx,[buffer8 + 8]
     L33:
         add bill,ebx
         loop L33
     jmp last
 L4: mov edx,OFFSET Quantity
     call WriteString
     call Readint
     call Crlf
     mov ecx,eax
     mov ebx,[buffer8 + 12]
     L44:
         add bill,ebx
         loop L44

last:
ret
Dessert ENDP

Checkerror PROC

; check whether eax contains value in range 1-6
; Receives: eax
; Returns: eax contains value in range 1-6 according to user's choice
;--------------------------------------------------------------------
L1:
   cmp eax,1
   jl L2
   cmp eax,6
   jg L2
   jmp last

L2:
   mov edx, OFFSET errorMsg
   call WriteString
   call Crlf
   mov edx,OFFSET spaces1
   call WriteString
   call Readint
   jmp L1
last:
ret
Checkerror ENDP

Checkerror1 PROC

; check whether eax contains value either 1 or 2
; Receives: eax
; Returns: eax contains value either 1 or 2 according to user's choice
;---------------------------------------------------------------------
L1:
   cmp eax,1
   jl L2
   cmp eax,2
   jg L2
   jmp last

L2:
   mov edx, OFFSET errorMsg
   call WriteString
   call Crlf
   mov edx,OFFSET spaces1
   call WriteString   
   call Readint
   jmp L1
last:
ret
Checkerror1 ENDP

Checkerror2 PROC

; check whether eax contains value in range 1-3
; Receives: eax
; Returns: eax contains value in range 1-3 according to user's choice
;--------------------------------------------------------------------
L1:
   cmp eax,1
   jl L2
   cmp eax,3
   jg L2
   jmp last

L2:
   mov edx, OFFSET errorMsg
   call WriteString
   call Crlf
   mov edx,OFFSET spaces1
   call WriteString   
   call Readint
   jmp L1
last:
ret
Checkerror2 ENDP

Checkerror3 PROC

; check whether eax contains value in range 1-5
; Receives: eax
; Returns: eax contains value in range 1-6 according to user's choice
;--------------------------------------------------------------------
L1:
   cmp eax,1
   jl L2
   cmp eax,5
   jg L2
   jmp last

L2:
   mov edx, OFFSET errorMsg
   call WriteString
   call Crlf
   mov edx,OFFSET spaces1
   call WriteString   
   call Readint
   jmp L1
last:
ret
Checkerror3 ENDP

end main