org 100h
.model small 
.stack 100h



.data

;MODULE: PRE-FIXED TICKET PRICES      
v1type1    DD 100        
v1type2    DD 200 
v1type3    DD 300 

v2type1    DD 200         
v2type2    DD 400 
v2type3    DD 600

v3type1    DD 300        
v3type2    DD 500 
v3type3    DD 700 

v4type1    DD 150         
v4type2    DD 350 
v4type3    DD 550  

;MODULE: INTIAL VARIABLES 
venue_type     DB 0
ticket_type    DB 0
ticket_num     DD 0
ticket_price   DD 0   
result         DD 0 


;MODULE: SELECTION                  
venues:        DB 0Dh,0Ah,"Select a Venue           : (1-VENUE1, 2-VENUE2, 3-VENUE3, 4-VENUE4) ",'$'
ticket:        DB 0Dh,0Ah,"Select the Ticket Type   : (1-TYPE 1, 2-TYPE 2, 3-TYPE 3) ",'$'
ticket_number: DB 0Dh,0Ah,"No of Tickets Required   : ",'$'
bill:          DB 0Dh,0Ah,"The Estimated Cost is Rs : ",'$'


;MODULE: MENU
menu:    DB 0Dh,0Ah,"1- View Venues",0Dh,0Ah
         DB "2- Purchase Tickets",0Dh,0Ah 
         DB "3- Exit",0Dh,0Ah,
         DB "Select an Option: ", '$'

;MODULE: END OF LINE
CRLF     db 13,10,'$' 

;MODULE: VENUE LIST
venue_info:   
         DB 0Dh,0Ah,0Dh,0Ah,"Venue            Location                   Contact Number    Max Capacity",0Dh,0Ah
         DB "VENUE1           LOCATION1                  123456789         1000",0Dh,0Ah
         DB "VENUE2           LOCATION2                  123456789         2000",0Dh,0Ah 
         DB "VENUE3           LOCATION3                  123456789         3000",0Dh,0Ah 
         DB "VENUE4           LOCATION4                  123456789         4000",0Dh,0Ah,'$'

;MODULE: VENUUE INFORMATION
venue1:
         DB 0Dh,0Ah,"1- VENUE 1",0Dh,0Ah,
         DB "Ticket Type          Cost",0Dh,0Ah
         DB "TYPE1                100 USD",0Dh,0Ah 
         DB "TYPE2                200 USD",0Dh,0Ah
         DB "TYPE3                300 USD",0Dh,0Ah,'$' 

venue2:
         DB "2- VENUE 2",0Dh,0Ah,
         DB "Ticket Type          Cost",0Dh,0Ah
         DB "TYPE1                200 USD",0Dh,0Ah 
         DB "TYPE2                400 USD",0Dh,0Ah
         DB "TYPE3                600 USD",0Dh,0Ah,'$'     
         
venue3:
         DB "3- VENUE 3",0Dh,0Ah,
         DB "Ticket Type          Cost",0Dh,0Ah
         DB "TYPE1                300 USD",0Dh,0Ah 
         DB "TYPE2                500 USD",0Dh,0Ah
         DB "TYPE3                700 USD",0Dh,0Ah,'$' 

venue4:
         DB "4- VENUE 4",0Dh,0Ah,
         DB "Ticket Type          Cost",0Dh,0Ah
         DB "TYPE1                150 USD",0Dh,0Ah 
         DB "TYPE2                350 USD",0Dh,0Ah
         DB "TYPE3                550 USD",0Dh,0Ah,'$' 
         
         
         
                
.code 

;MODULE START

begin:
      mov ax,@data
      mov ds,ax
  
start:
  
      mov dx, offset menu
      mov ah, 09h
      int 21h 
      
;MODULE: GET MENU CHOICE      
get_choice:
      
      mov ah, 1
      int 21h
    
      cmp al, '1'
      je  CHOICE_1
      
      cmp al, '2'
      je  CHOICE_2
          
      cmp al, '3'
      je  CHOICE_3
        
      jmp get_choice
      
      
;MODULE: CHOICE 1      
CHOICE_1:

      mov dx, offset venue_info
      mov ah, 9
      int 21h

      mov dx, offset CRLF
      MOV AH,9
      INT 21H  
        
      jmp start
      
;MODULE: CHOICE 2
CHOICE_2:
     
      mov dx, offset CRLF
      MOV AH,9
      INT 21H
      mov dx, offset venue1
      mov ah, 9
      int 21h 
         
      mov dx, offset CRLF
      MOV AH,9
      INT 21H
      
      mov dx, offset venue2
      mov ah, 9
      int 21h
      
      mov dx, offset CRLF
      MOV AH,9
      INT 21H
      
      mov dx, offset CRLF
      MOV AH,9
      INT 21H
      mov dx, offset venue3
      mov ah, 9
      int 21h 
         
      mov dx, offset CRLF
      MOV AH,9
      INT 21H
      
      mov dx, offset venue4
      mov ah, 9
      int 21h
      
           
      mov dx, offset venues
      mov ah, 9
      int 21h
      
 
      MOV AH, 1
      INT 21H
      mov venue_type, al


      mov dx, offset ticket
      mov ah, 9
      int 21h    
	  
 
      MOV AH, 1
      INT 21H
      mov ticket_type, al
	  

      mov dx, offset ticket_number
      mov ah, 9
      int 21h
	  
;MODULE: COMPARISON       
      call INDEC
      mov ticket_num, ax


      cmp venue_type, '1'
      je  ven1
      cmp venue_type, '2'
      je ven2 
      cmp venue_type, '3'
      je  ven3
      cmp venue_type, '4'
      je ven4
      jmp CHOICE_2 
  

;MODULE: VENUE 1       
  ven1:

      cmp ticket_type, '1'
      jne jump11
	  mov ax, v1type1
      mov ticket_price, ax
	  jmp cal
	  
    jump11:
      cmp ticket_type, '2'
      jne jump12
	  mov ax, v1type2
      mov ticket_price, ax
      jmp cal
        
    jump12:
      cmp ticket_type, '3'
      jne CHOICE_2
	  mov ax, v1type3
      mov ticket_price, ax
	  jmp cal

;MODULE: VENUE 2
  ven2:

      cmp ticket_type, '1'
      jne jump21
	  mov ax, v2type1
      mov ticket_price, ax
      jmp cal	  
      
    jump21:
      cmp ticket_type, '2'
      jne jump22
	  mov ax, v2type2
      mov ticket_price, ax
      jmp cal
      
    jump22:
      cmp ticket_type, '3'
      jne CHOICE_2
	  mov ax, v2type3
      mov ticket_price, ax
	  jmp cal 

;MODULE: VENUE 3	  
  ven3:

      cmp ticket_type, '1'
      jne jump31
	  mov ax, v2type1
      mov ticket_price, ax
      jmp cal  
      
    jump31:
      cmp ticket_type, '2'
      jne jump32
	  mov ax, v2type2
      mov ticket_price, ax
      jmp cal
      
    jump32:
      cmp ticket_type, '3'
      jne CHOICE_2
	  mov ax, v2type3
      mov ticket_price, ax
	  jmp cal 	  

;MODULE: VENUE 4	  
  ven4:

      cmp ticket_type, '1'
      jne jump41
	  mov ax, v2type1
      mov ticket_price, ax
      jmp cal  
      
    jump41:
      cmp ticket_type, '2'
      jne jump42
	  mov ax, v2type2
      mov ticket_price, ax
      jmp cal
      
    jump42:
      cmp ticket_type, '3'
      jne CHOICE_2
	  mov ax, v2type3
      mov ticket_price, ax
	  jmp cal 	  

;MODULE: CALCULATE	  	 
    cal:  
      mov cx, ticket_num
	  mov ax, ticket_price
      mul cx 
      mov result, ax
      

      mov dx, offset CRLF
      MOV AH,9
      INT 21H
      mov dx, offset bill
      MOV AH,9
      INT 21H      
      
      mov ax, result
      call OUTDEC
      
      mov dx, offset CRLF
      MOV AH,9
      INT 21H
               
      jmp start


;MODULE: CHOICE 3      
CHOICE_3:
      mov ah,4Ch
      int 21h


;MODULE: OUTDEC MODULE       
  OUTDEC  PROC
      PUSH  AX
      PUSH  BX
      PUSH  CX
      PUSH  DX
      
      OR    AX,AX
      JGE   @END_IF1
      PUSH  AX
      
      MOV   DL,'-'
      MOV   AH,2
      INT   21H
      
      POP   AX
      NEG   AX
      
    @END_IF1:
      XOR  CX,CX
      MOV  BX,10D
      
    @REPEAT1:
      XOR  DX,DX
      DIV  BX
      PUSH DX
      INC  CX
      OR   AX,AX
      JNE  @REPEAT1
      MOV  AH,2
      
    @PRINT_LOOP:
      POP  DX
      OR  DL,30H
      INT  21H
      LOOP  @PRINT_LOOP
      
      POP  DX
      POP  CX
      POP  BX
      POP  AX
      RET
  OUTDEC  ENDP

;MODULE: INDEC MODULE
  
  INDEC  PROC
    
    
      PUSH  BX
      PUSH  CX
      PUSH  DX
      
    @BEGIN:
      MOV  AH,2
      MOV  DL,'?'
      INT  21H
      XOR  BX,BX
      XOR  CX,CX
      MOV  AH,1
      INT  21H
      CMP  AL,'-'
      JE  @MINUS
      CMP  AL,'+'
      JE  @PLUS 
      JMP @REPEAT2
      
    @MINUS:
      MOV  CX,1
      
    @PLUS:
      INT  21H
      
    @REPEAT2:
      CMP  AL,'0'
      JNGE  @NOT_DIGIT
      CMP  AL,'9'
      JNLE  @NOT_DIGIT
      AND  AX,000FH
      PUSH  AX
      MOV  AX,10
      MUL  BX
      POP  BX
      ADD  BX,AX
      MOV  AH,1
      INT  21H 
      CMP  AL,0DH
      JNE  @REPEAT2
      MOV  AX,BX
      OR  CX,CX
      JE  @EXIT
      NEG  AX
      
    @EXIT:
      POP  DX
      POP  CX
      POP  BX
      RET
      
    @NOT_DIGIT:
      cmp  al, 'f'  
      je   @EXIT:
      MOV  AH,2
      MOV  DL,0DH
      INT  21H
      MOV  DL,0AH
      INT  21H
      JMP  @BEGIN
      
  INDEC  ENDP
