TITLE	ASSIGNMENT	HOTEL_RESERVATION_SYSTEM			; Title directives

.MODEL	SMALL											; Declare model used (SMALL)
.STACK	64												; Declare stack (64 bytes)
.DATA													; Declare data segment
; LOGIN MODULE
	Welcome			DB	'| WELCOME TO OUR HOTEL BOOKING SYSTEM |$'
	Password 		DB 	' | Please enter your password: $'
	Login 			DB 	' | Please enter your username: $'
	try1 			DB 	'Invalid Username. Please try again!$'
	try2 			DB 	'Invalid Password. Please try again!$'
	True_username 	DB 	'chuakahhow$'
	True_password 	DB 	'12345abc$'

	UserPassword 	LABEL	BYTE
	MAX1 			DB 		31
	ACTUAL1			DB		?
	DATA_A 			DB 		31 DUP('$')

	Username		LABEL	BYTE
	MAX2			DB		51
	ACTUAL2 		DB 		?
	DATA_B 			DB 		51 DUP(' ')
	
; ROOM BOOKING MODULE
	HEADER 		DB  "|====== Room Booking ======|", 10, 13, "$"			
	ROOMTYPE 	DB 	"			  +===============+=========+", 10, 13, "$" 
	ROOMTYPE2	DB	"			  |   ROOM LIST   |  PRICE  |", 10, 13, "$"
	ROOMTYPE3	DB	"			  +===============+=========+", 10, 13, "$"
	ROOMTYPE4	DB	"			  |   1. Single   | USD 60  |", 10, 13, "$"
	ROOMTYPE5	DB	"			  |   2. Double   | USD 80  |", 10, 13, "$"
	ROOMTYPE6	DB	"			  |   3. Triple   | USD 100 |", 10, 13, "$" 
	ROOMTYPE7	DB	"			  |   4. King     | USD 120 |", 10, 13, "$"
	ROOMTYPE8	DB	"			  |   5. Suite    | USD 160 |", 10, 13, "$"
	ROOMTYPE9	DB	"			  +===============+=========+", 10, 13, "$"
	
	SINGLE 		DB 	"ROOM AVAILABLE", 10, 13, "PRICE: USD 60 per day", 10, 13, "$"    		
	SGPRICE		DW  60
	SG 			DB  "?"													; use to store the comfirmation y or n in SN keyword
	
	DOUBLE 		DB 	"Room Not Available. Please choose other rooms thank you.$"
	
	TRIPLE 		DB  "ROOM AVAILABLE", 10, 13, "Price: USD 100 per day", 10, 13, "$"
	TPPRICE		DW  100
	TP 			DB  "?"													; use to store the comfirmation y or n in TR keyword
	
	KING  	 	DB 	"ROOM AVAILABLE", 10, 13, "Price: USD 120 per day", 10, 13, "$"
	KGPRICE		DW  120
	KG 			DB  "?"													; use to store the comfirmation y or n in KI keyword
	
	SUITE 	 	DB  "ROOM AVAILABLE", 10, 13, "Price: USD 160 per day", 10, 13, "$"
	SUPRICE		DW 	160
	SU  		DB  "?"													; use to store the comfirmation y or n in SE keyword
	
	COMFIRM		DB 	" | Confirm Room Selection (Y/N)? $"
	
	TTPRICE		DW 	"?"													; use to store the price that user choose in the end of the module 
	
	PYWORD		DB  10, 13, "(Press Y to proceed, N to choose other room type)", 10, 13, " | Do you want to proceed to payment ? ", "$"
	PYCHOICE	DB  "?"													; use to store the comfirmation for proceed to payment module or reloop room booking module 
	
	CHOICE		DB  10, 13, " | Please choose your Ideal Room Type (1-5): " , "$"
	TEMP 	 	DB  ?													; use to store the number of user enter from room list 
	
; PAYMENT MODULE & DISCOUNT MODULE
	; Page headers
	discHeader	DB	"|====== Discount ======|", 10, 13, "$" 
	paymHeader	DB	"|====== Payment ======|", 10, 13, "$"
		
		; Discount Messages
		discMsg1		DB	" | Apply Discount Code (Y/N) ? $"
		discMsg2		DB	" | Enter Discount Code: $"
		discError1		DB	"Invalid Selection. Please Try Again.", 10, 13, "$"
		discError2		DB	"Invalid Discount Code. Please Try Again.", 10, 13, "$"
		
		; Apply discount code selection temp var
		tempSelect		DB	?
		tempSelect2		DB 	?
		
		; Fixed discount codes
		trueCode1		DB	"sidemen44$"								; set fixed discount code 1
		trueCode2		DB	"34sidemen$"								; set fixed discount code 2
		
		; Price
		subTotal		DW	?											; store subTotal
		discTotal		DW	?											; store discTotal(Discounted Total)
			discAmt1		DB	?										; store discAmt1 when user does not enter discount code
			discAmt2		DW	?										; store discAmt2 when user entered discount code
		sstAmt			DW	?											; store sstAmt(SST Amount)
			tempBeforeFloat1	DW	?
			afterFloat	DW	?
			tempAfterFloat		DW	?
			tempAfterFloat1		DW	?									; store float value(Eg: .01) of discAmt1
			tempAfterFloat2		DW	?									; store float value(Eg: .01 of discAmt2
			tempAfterFloat3		DW	?
		total			DW	?											; store final total
			totalFloat	DW	?
			
		; Payment Messages
		paymentMsg1		DB	" PAYMENT AMOUNT AS BELOW:", 10, 13, "$"
		paymentSplit	DB	"--------------------------------------------------------------------------------", 10, 13, "$"
		paymentMsg2		DB	"	Sub-total : USD $"
		paymentMsg3		DB	"	 Discount : USD $"
		paymentMsg4		DB	" (include 5% SST) : USD $"
		paymentMsg5		DB	"	    Total : USD $"
		paymentMsg6		DB	" | Confirm Payment (Y/y) ? $"
		
		; User Information
		
		; String length
		strLength		DB	0
	
	; Program terminate message
	endMsg		DB	"|============================ Program Terminated ============================|", 10, 13, "$"
	
	; Declare var for user input discount code
	IN_CODE		LABEL	BYTE
	maxCode		DB		21
	codeLen		DB		?
	code		DB		21 DUP('$')
	
	; TRANSACTION SUMMARY MODULE
    tranHEADER	DB	"|====== Transaction Summary ======|" , 10 , 13 , "$"   											; Declare 1 byte string called tranHEADER
	GREET		DB	"Dear Chua Kah How,", 10 , 13 , "$"																	; Declare 1 byte string called GREET
	MESSAGE		DB	"This is your transaction summary:", 10 , 13 , "$"													; Declare 1 byte string called GREET
	SPLIT		DB	"|==============================================================================|", 10 , 13 , "$"
	HOTEL		DB	"HOTEL CSA", 10 , 13 , "$"
	SIN			DB	"Room Type: Single", 10 , 13 , "$"
	DOU			DB	"Room Type: Double", 10 , 13 , "$"
	TRI			DB	"Room Type: Triple", 10 , 13 , "$"
	K			DB	"Room Type: King", 10 , 13 , "$"
	SUI			DB	"Room Type: Suite", 10 , 13 , "$"
	PRESS		DB	" | Do you want to continue (Y/N) ? $"
	
	tempSelect3	DB	?
	
	; END PROGRAM
	endHeader	DB	"|====== Hotel CSA ======|", 10, 13, "$"
	msg1		DB	"Thank you for using our Hotel Booking System!!", 10, 13, "$"
	msg2		DB	" | Total No. of Loop: $"
	loopCount	Dw	0
	COMPLETE	DB	" |============================ Program Terminated ============================|", 10, 13, "$"
;------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
.386
.CODE													; Declare code segment
	; MAIN PROCESS (start from login Module)
	MAIN	PROC	FAR									; Main function starts here
	
		MOV AX, @DATA									; Initialize data register
		MOV DS, AX
		MOV ES, AX
		
		START:			
		MOV AH, 06H										; Clear screen
		MOV AL, 00H										; Clear all lines
		MOV BH, 00001010B								; Format page
				
			MOV CX, 0000H									; Set scrolling point from top left
			MOV DX, 184FH									; to right bottom
			INT 10H
				
			MOV AH, 02H
			MOV BH, 00										; Set cursor position 
			MOV DH, 1										; Row 1
			MOV DL, 21										; Column 21
			INT 10H
				
			MOV	AH, 09H
			LEA DX, Welcome									; Display Welcome
			INT 21H
					
			CALL newLine									; Call CR-LF sub-function
		
LOGIN_FUNCTION:		
			CALL newLine
				
			MOV AH , 09H
			LEA DX , Login 									  ;display the data of login
			INT 21H

			MOV AH , 0AH
			LEA DX , Username 								  ;store the data of username from the user input
			INT 21H
					
			MOVZX	BX, ACTUAL2    							  ;to get the value of ACTUAL2(the size of ACTUAL2) store in the BX
			MOV		DATA_B[BX],'$' 							  ;to know how many data store in the DATA_B until $ suach as DATA_B[5]
  		
			CALL newLine

			MOV AH , 09H
			LEA DX , password  								  ;display the data of password
			INT 21H

			MOV AH , 0AH
			LEA DX , UserPassword 							  ;store the data of UserPassword from the user input
			INT 21H
				
			MOVZX	BX, ACTUAL1  							  ;to get the value of ACTUAL1(the size of ACTUAL1) store in the BX
			MOV		DATA_A[BX],'$'							  ;to read and how many data store in the DATA_B until $ suach as DATA_B[5]
  
			CALL newLine
				
			MOV BX , 0         								  ;to let system know only can loop 10 times
			MOV CX , 11
LineA:
			MOV AL , DATA_B[BX]
			CMP True_username+BX, AL 						  ;compare the true_username and al 
			JNE ERROR1               						  ;if not eqeal jump to the lebal call EEROR1
			INC BX											  ; BX increase 1
			LOOP LineA               						  ; go back to the lebal call LineA for looping 
	
			MOV BX , 0                						  ;to let system know only can loop 8 times
			MOV CX , 9
LineB:
			MOV AL , DATA_A[BX]        
			CMP True_password+BX, AL  						 ;compare the True_password and al 
			JNE ERROR2                 						 ;if not eqeal jump to the lebal call EEROR2
			INC BX                     						 ; BX increase 1
			LOOP LineB                						 ; go back to the lebal call LineB for looping 
				
wholeLoop:	CALL PROCESS2									 ; Call in PROCESS2 (Room Booking Module)
			INC loopCount									 ; Increase loopCount by 1
			CMP	tempSelect3, 'Y'							 ; Compare tempSelect3 = 'Y' or 'y'
				JE	wholeLoop2									 ; If yes then loop the booking process
			CMP tempSelect3, 'y'
				JE	wholeLoop2
			JMP QUIT		

wholeLoop2: MOV tempSelect3, '?'							; Move '?' to replace tempSelect3 (originally 'Y' or 'y')
			MOV tempAfterFloat, 0							; reset tempAfterFloat to 0
			MOV tempAfterFloat1, 0							; reset tempAfterFloat to 0
			MOV tempAfterFloat2, 0							; reset tempAfterFloat to 0
			MOV tempAfterFloat3, 0							; reset tempAfterFloat to 0
			MOV totalFloat, 0
			JMP wholeLoop									; Jump to wholeLoop to reloop booking process

ERROR1:     
			CALL newLine									; Call CR-LF sub-function
				
				MOV AH, 06H										; Clear screen
				MOV AL, 00H										; Clear all lines
				MOV BH, 00001010B								; Format page
						
				MOV CX, 0000H									; Set scrolling point from top left
				MOV DX, 184FH									; to right bottom
				INT 10H
						
				MOV AH, 02H
				MOV BH, 00										; Set cursor position 
				MOV DH, 1										; Row 1
				MOV DL, 21										; Column 21
				INT 10H
						
				MOV	AH, 09H
				LEA DX, Welcome									; Display Welcome
				INT 21H
							
				CALL newLine									; Call CR-LF sub-function
					
				CALL newLine									; Call CR-LF sub-function
					
			MOV AH , 09H
			LEA DX , try1        							;display the data of try1
			INT 21H
			JMP LOGIN_FUNCTION   							;jump to the lebal call the LOGIN_FUNCTION
				
ERROR2:
			CALL newLine									; Call CR-LF sub-function
					
				MOV AH, 06H										; Clear screen
				MOV AL, 00H										; Clear all lines
				MOV BH, 00001010B								; Format page
						
				MOV CX, 0000H									; Set scrolling point from top left
				MOV DX, 184FH									; to right bottom
				INT 10H
						
				MOV AH, 02H
				MOV BH, 00										; Set cursor position 
				MOV DH, 1										; Row 1
				MOV DL, 21										; Column 31
				INT 10H
						
				MOV	AH, 09H
				LEA DX, Welcome									; Display Welcome
				INT 21H
							
				CALL newLine									; Call CR-LF sub-function
					
				CALL newLine									; Call CR-LF sub-function
					
			MOV AH , 09H
			LEA DX , try2									;display the data of try2
			INT 21H
			JMP LOGIN_FUNCTION 							    ;jump to the lebal call the LOGIN_FUNCTION
		
QUIT:	MOV AH, 06H										; Clear screen
		MOV AL, 00H										; Clear all lines
		MOV BH, 00001010B								; Format page
				
			MOV CX, 0000H									; Set scrolling point from top left
			MOV DX, 184FH									; to right bottom
			INT 10H
				
			MOV AH, 02H
			MOV BH, 00										; Set cursor position 
			MOV DH, 1										; Row 1
			MOV DL, 27										; Column 21
			INT 10H
				
			MOV	AH, 09H
			LEA DX, endHeader								; Display endHeader
			INT 21H
					
			CALL newLine									; Call CR-LF sub-function
			
			MOV AH, 09H
			LEA DX, msg1
			INT 21H
			
			CALL newLine									; Call CR-LF sub-function
			
			MOV AH, 09H
			LEA DX, msg2
			INT 21H
			
			MOV AX, loopCount
			CALL printAmount
			
			CALL newLine									; Call CR-LF sub-function
				CALL newLine									; Call CR-LF sub-function
					
			MOV AH, 09H
			LEA DX, COMPLETE
			INT 21H
			
		MOV AX, 4C00H									; Request for proper exit
		INT 21H
		
	MAIN ENDP											; Main function ends here


PROCESS2	PROC
	CR: MOV 	AH, 06H									; Clear screen
		MOV 	AL, 00H									; Clear all lines
		MOV 	BH, 00001010B							; Format page
					
		MOV 	CX, 0000H								; Set scrolling point from top left
		MOV 	DX, 184FH								; to right bottom
		INT 	10H
					
		MOV 	AH, 02H
		MOV 	BH, 00									; Set cursor position 
		MOV 	DH, 1									; Row 1
		MOV 	DL, 25									; Column 23
		INT	 	10H
			
		MOV 	AH , 09H
		LEA 	DX , HEADER								; print header to 
		INT 	21H
						
		CALL newLine									; Call CR-LF sub-function
		
	;---------------------------------------------------		; Print room list and let user choose their room 
	L1:	MOV 	AH , 09H							
		LEA 	DX , ROOMTYPE							; Display all the room type 
		INT 	21H	
			MOV 	AH , 09H							
			LEA 	DX , ROOMTYPE2
			INT 	21H
		MOV 	AH , 09H							
		LEA 	DX , ROOMTYPE3
		INT 	21H
			MOV 	AH , 09H							
			LEA 	DX , ROOMTYPE4
			INT 	21H	
		MOV 	AH , 09H							
		LEA 	DX , ROOMTYPE5
		INT 	21H
			MOV 	AH , 09H							
			LEA 	DX , ROOMTYPE6
			INT 	21H	
		MOV 	AH , 09H							
		LEA 	DX , ROOMTYPE7
		INT 	21H
			MOV 	AH , 09H							
			LEA 	DX , ROOMTYPE8
			INT 	21H	
		MOV 	AH , 09H							
		LEA 	DX , ROOMTYPE9
		INT 	21H

		MOV 	AH , 09H
		LEA 	DX , CHOICE								; Print and ask the user which is his/her ideal room type
		INT 	21H
			
		MOV 	AH , 01H
		INT	 	21H
			
		MOV 	TEMP , AL

	;---------------------------------------------------	 	; Compare the user choosen number and display the detail to user 
		CALL newLine									; Call CR-LF sub-function
			
		CMP		TEMP , '1'								; compare to temp if is 1 then will jump to SN keyword for single room detail 
		JE 		SN 
		
		CMP		TEMP , '2'								; compare to temp if is 2 then will jump to DU keyword for single room detail 
		JE 		DU
		
		CMP		TEMP , '3'								; compare to temp if is 3 then will jump to TR keyword for single room detail 
		JE 		TR 
		
		CMP		TEMP , '4'								; compare to temp if is 4 then will jump to KI keyword for single room detail 
		JE 		KI 
		
		CMP		TEMP , '5'								; compare to temp if is 5 then will jump to SE keyword for single room detail 
		JE 		SE 
		
		MOV 	DL , 0AH
		INT 	21H 

	;---------------------------------------------------		; SINGLE ROOM PART (SN)
	SN: CALL newLine									; Call CR-LF sub-function
			
		MOV 	AH, 09H									; Print single room available and price 
		LEA 	DX , SINGLE
		INT 	21H
			
		MOV		AH , 09H								; comfirm with user choose this room type or not choosing this room type
		LEA 	DX , COMFIRM
		INT 	21H
			   
		MOV 	AH , 01H
		INT		21H
			
		MOV 	SG , AL 
			
		CALL newLine									; Call CR-LF sub-function
			
		CMP 	SG , "y"								; Y or y will proceed to T1 to let the price move to total price 
		JE 		T1
			
		CMP 	SG , "Y"
		JE 		T1
			
		CMP 	SG , "n"								; N or n will jump to CR to reloop the module and ask again for the room type 
		JE 		CR
			
		CMP 	SG , "N"
		JE 		CR
	;---------------------------------------------------		; DOUBLE ROOM PART (DU)
	DU: MOV 	AH, 06H									; Clear screen
		MOV 	AL, 00H									; Clear all lines
		MOV 	BH, 00001010B							; Format page
					
		MOV 	CX, 0000H								; Set scrolling point from top left
		MOV 	DX, 184FH								; to right bottom
		INT 	10H
					
		MOV 	AH, 02H
		MOV 	BH, 00									; Set cursor position 
		MOV 	DH, 1									; Row 1
		MOV 	DL, 25									; Column 23
		INT	 	10H
			
		MOV 	AH , 09H
		LEA 	DX , HEADER								; print header to 
		INT 	21H
						
		CALL newLine									; Call CR-LF sub-function
		
		MOV 	AH , 09H								; Print to user about this room type is not available anymore 
		LEA 	DX , DOUBLE
		INT 	21H
			
		CALL newLine									; Call CR-LF sub-function
			
		CALL newLine									; Call CR-LF sub-function
			
		JMP  	L1 										; jump to the room type list to let user choose other room type 

	;---------------------------------------------------		; TRIPLE ROOM PART (TR)
	TR: CALL newLine									; Call CR-LF sub-function
			
		MOV 	AH , 09H								; Print triple room available and price 
		LEA 	DX , TRIPLE
		INT 	21H
			
		MOV		AH , 09H								; comfirm with user choose this room type or not choosing this room type
		LEA 	DX , COMFIRM
		INT 	21H
			   
		MOV 	AH , 01H
		INT		21H
			
		MOV 	TP , AL 
			
		CALL newLine									; Call CR-LF sub-function
			
		CMP 	TP , "y"								; Y or y will proceed to T2 to let the price move to total price 
		JE 		T2
			
		CMP 	TP , "Y"
		JE 		T2
			
		CMP 	TP , "n"								; N or n will jump to CR to reloop the module and ask again for the room type 
		JE 		CR
			
		CMP 	TP , "N"
		JE 		CR

	;---------------------------------------------------		; KING ROOM PART (KI)
	KI:	CALL newLine									; Call CR-LF sub-function
			
		MOV 	AH , 09H								; Print king room available and price 
		LEA 	DX , KING
		INT 	21H
			
		MOV		AH , 09H								; comfirm with user choose this room type or not choosing this room type
		LEA 	DX , COMFIRM
		INT 	21H
			   
		MOV 	AH , 01H
		INT		21H
			
		MOV 	KG , AL 
			
		CALL newLine									; Call CR-LF sub-function
			
		CMP 	KG , "y"								; Y or y will proceed to T3 to let the price move to total price 
		JE 		T3
			
		CMP 	KG , "Y"
		JE 		T3
			
		CMP 	KG , "n"								; N or n will jump to CR to reloop the module and ask again for the room type 
		JE 		CR
			
		CMP 	KG , "N"
		JE 		CR

	;---------------------------------------------------		; SUITE ROOM PART (SE)
	SE: CALL newLine									; Call CR-LF sub-function
			
		MOV 	AH , 09H								; Print suite room available and price 
		LEA 	DX , SUITE
		INT 	21H
			
		MOV		AH , 09H								; comfirm with user choose this room type or not choosing this room type 
		LEA 	DX , COMFIRM
		INT 	21H
			   
		MOV 	AH , 01H
		INT		21H
			
		MOV 	SU , AL 
			
		CALL newLine									; Call CR-LF sub-function
			
		CMP 	SU , "y"								; Y or y will proceed to T4 to let the price move to total price 
		JE 		T4
			
		CMP 	SU , "Y"
		JE 		T4
			
		CMP 	SU , "n"								; N or n will jump to CR to reloop the module and ask again for the room type 
		JE 		CR
			
		CMP 	SU , "N"
		JE 		CR

	;---------------------------------------------------	 
	T1:	MOV 	AX, SGPRICE								; T1 is the keyword move single room price into total price variable 
		MOV 	TTPRICE , AX 
		JMP 	PY
		
	T2:	MOV 	AX, TPPRICE								; T2 is the keyword move triple room price into total price variable 
		MOV 	TTPRICE , AX 
		JMP 	PY
			
	T3:	MOV 	AX, KGPRICE								; T3 is the keyword move king room price into total price variable 
		MOV 	TTPRICE , AX 
		JMP 	PY
			
	T4: MOV 	AX, SUPRICE								; T4 is the keyword move suite room price into total price variable 
		MOV 	TTPRICE , AX 
		JMP 	PY
			
	PY:	MOV 	AH , 09H								; Print the PYWORD message to user and ask for contunue to payment module or reloop the program
		LEA 	DX , PYWORD
		INT 	21H
			
		MOV 	AH , 01H							
		INT 	21H
			
		MOV 	PYCHOICE , AL
			
		CMP 	PYCHOICE , "Y"							; IF Y or y will proceed to payment module 
		JE 		DE
			
		CMP 	PYCHOICE , "y"
		JE 		DE
			
		CMP 	PYCHOICE , "N"							; IF N or n will reloop this module 
		JE 		CR
			
		CMP 	PYCHOICE , "n"
		JE 		CR
			
	DE: CALL PROCESS3									; Call in PROCESS3 (Discount Module)
	
		RET
PROCESS2 ENDP
;------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	; DISCOUNT MODULE
	PROCESS3	PROC									; Discount Module stars here
		DISCOUNT:
			MOV AX, TTPRICE									; Move TTPRICE into AX
			MOV subTotal, AX								; MOV AX(TTPRICE) into subTotal for further use
			MOV AX, 0										; Move 0 into AX
			
			MOV AH, 06H										; Clear screen
			MOV AL, 00H										; Clear all lines
			MOV BH, 00001010B								; Format page
				
				MOV CX, 0000H									; Set scrolling point from top left
				MOV DX, 184FH									; to right bottom
				INT 10H
				
				MOV AH, 02H
				MOV BH, 00										; Set cursor position 
				MOV DH, 1										; Row 1
				MOV DL, 28										; Column 30
				INT 10H
				
				MOV	AH, 09H
				LEA DX, discHeader								; Display discHeader
				INT 21H
					
				CALL newLine									; Call CR-LF sub-function

		DISCOUNT2:		
			MOV	AH, 09H
			LEA DX, discMsg1								; Display discSelect
			INT 21H
				MOV AH, 01H										; Accept char
				INT 21H
					MOV	tempSelect, AL								; Move char entered into tempSelect
				
			CALL newLine									; Call CR-LF sub-function
				CALL newLine									; Call CR-LF sub-function
				
			CMP	tempSelect, "Y"								; Compare tempSelect with 'Y' and 'y'
				JE	yesChoice									; If tempSelect = 'Y' or 'y' then jump to label yesChoice
			CMP tempSelect, "y"
				JE	yesChoice
			CMP tempSelect, "N"								; Compare tempSelect with 'N' and 'n'
				JE	noDisc										; If tempSelect = 'N' or 'n' then jump to label noDisc
			CMP tempSelect, "n"
				JE	noDisc

invalidChoice:	MOV AH, 06H										; Clear screen
				MOV AL, 00H										; Clear all lines
				MOV BH, 00001010B								; Format page
					
					MOV CX, 0000H									; Set scrolling point from top left
					MOV DX, 184FH									; to right bottom
					INT 10H
						
					MOV AH, 02H
					MOV BH, 00										; Set cursor position 
					MOV DH, 1										; Row 1
					MOV DL, 28										; Column 30
					INT 10H
							
					MOV	AH, 09H
					LEA DX, discHeader								; Display discHeader
					INT 21H
							
					CALL newLine									; Call CR-LF sub-function
					
				MOV AH, 09H
				LEA DX, discError1								; Display discError1
				INT 21H
				JMP DISCOUNT2									; Loop back to DISCOUNT2 label

yesChoice:		MOV AH, 09H
				LEA DX, discMsg2								; Display discMsg2
				INT 21H
					MOV AH, 0AH
					LEA DX, IN_CODE									; Prompt user enter a string of character in IN_CODE
					INT 21H
						
						CALL newLine									; Call CR-LF sub-function
					
	checkCode1:		MOV	DL, 0										; Move 0 into DL register
					MOV SI, OFFSET trueCode1						; Move OFFSET of trueCode1 into SI(Source Index) 
					
		; Count the length of trueCode1		
		cLength1:	MOV AL, [SI]									; Move the character of trueCode1 pointed in SI into AL	
					CMP AL, "$"										; Compare AL with "$" to check whether if the string ended
						JE cmpLength1									; If AL = "$", then jump to cmpLength1
					INC SI											; Else Increase SI by 1
					INC DL											; Inrease DL by 1
					JMP cLength1									; Reloop the process by jumping back to cLength1
					
		; Compare the string length of trueCode1 and codeLen
		cmpLength1:	CMP codeLen, DL									; Compare codeLen with DL to check whether if it has the same length as DL that stored trueCode1's length
						JE cmpCont1										; If both string length are the same, then jump to cmpCont1
					JMP checkCode2									; Else jump to checkCode2
					
		; Compare string trueCode1 and code based on the contents
		cmpCont1:	MOV	CL, codeLen									; Move codeLen into CL to set the counter for looping
				
					MOV SI, OFFSET code								; Move OFFSET of code into SI(Source Index)
					MOV DI, OFFSET trueCode1						; Move OFFSET of trueCode1 into DI(Destination Index)
							
		cmpCont2:	CMPSB											; Compare SI and DI to check whether if both have the same characters for each pointers
						JNE	checkCode2									; If SI and DI have different character at specified pointer, then jump to checkCode2
					LOOP cmpCont2									; Else LOOP the process cmpCont2 again
					JMP	validDisc1									; After process is done, jump to validDisc1
					
	checkCode2:		MOV	DL, 0										; Move 0 into DL register
					MOV SI, OFFSET trueCode2						; Move OFFSET of trueCode2 into SI(Source Index) 
					
		; Count the length of trueCode2
		cLength2:	MOV AL, [SI]									; Move the character of trueCode2 pointed in SI into AL	
					CMP AL, "$"										; Compare AL with "$" to check whether if the string ended
						JE cmpLength2									; If AL = "$", then jump to cmpLength2
					INC SI											; Else Increase SI by 1
					INC DL											; Inrease DL by 1
					JMP cLength2									; Reloop the process by jumping back to cLength2
		
		; Compare the string length of trueCode2 and codeLen
		cmpLength2:	CMP codeLen, DL									; Compare codeLen with DL to check whether if it has the same length as DL that stored trueCode2's length
						JE cmpCont3										; If both string length are the same, then jump to cmpCont3
					JMP invalidDisc									; Else jump to invalidDisc
					
		; Compare string trueCode2 and code based on the contents
		cmpCont3:	MOV	CL, codeLen									; Move codeLen into CL to set the counter for looping
					
					MOV SI, OFFSET code								; Move OFFSET of code into SI(Source Index)
					MOV DI, OFFSET trueCode2						; Move OFFSET of trueCode2 into DI(Destination Index)
							
		cmpCont4:	CMPSB											; Compare SI and DI to check whether if both have the same characters for each pointers
						JNE	invalidDisc									; If SI and DI have different character at specified pointer, then jump to invalidDisc
					LOOP cmpCont4									; Else LOOP the process cmpCont4 again
					JMP validDisc2									; After process is done, jump to validDisc2
							
	invalidDisc:	CALL newLine									; Call CR-LF sub-function
								
					MOV AH, 09H
					LEA DX, discError2								; Display discError2 
					INT 21H
					JMP yesChoice									; Jump back to yesChoice

	validDisc1:		MOV AX, 5										; Move value 5 into AL register as operand
						CALL calcDiscAmt								; Call in calcDiscAmt sub-function
						CALL calcDiscTotal								; Call in calcDiscTotal sub-function
						CALL PROCESS4									; Call in PROCESS4 (Payment Module)
					JMP	EXIT										; Jump to EXIT
						
	validDisc2:		MOV AX, 10										; Move value 10 into AL as operand
						CALL calcDiscAmt								; Call in calcDiscAmt sub-function
						CALL calcDiscTotal								; Call in calcDiscTotal sub-function
						CALL PROCESS4									; Call in PROCESS4 (Payment Module)
					JMP EXIT										; Jump to EXIT
		
noDisc:			MOV discAmt1, 0									; Move value 0 into discAmt1
					CALL PROCESS4									; Call in PROCESS4 (Payment Module)
				JMP EXIT										; Jump to EXIT
	
EXIT:	RET													; Return
	PROCESS3 ENDP											; Discount module ends here
;------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	; PAYMENT MODULE
	PROCESS4	PROC							; Payment module starts here
		MOV AH, 06H									; Clear screen
		MOV AL, 00H									; Clear all lines
		MOV BH, 00001010B							; Format page
					
			MOV CX, 0000H								; Set scrolling point from top left
			MOV DX, 184FH								; to right bottom
			INT 10H
					
			MOV AH, 02H
			MOV BH, 00									; Set cursor position 
			MOV DH, 1									; Row 1
			MOV DL, 28									; Column 30
			INT 10H
					
			MOV AH, 09H
			LEA DX, paymHeader							; Display paymHeader
			INT 21H
						
			CALL newLine									; Call CR-LF sub-function
					
		MOV AH, 09H
		LEA DX, paymentMsg1							; Display paymentMsg1
		INT 21H
							
			CALL newLine									; Call CR-LF sub-function
				
		MOV AH, 09H
		LEA DX, paymentSplit						; Display paymentSplit
		INT 21H
			
		MOV AH, 09H
		LEA DX, paymentMsg2							; Display paymentMsg2
		INT 21H
		
		MOV AX, subTotal							; Move subTotal into AX register
		CALL printAmount							; Call in printAmount sub-function to print the subTotal
						
			CALL newLine									; Call CR-LF sub-function
							
		MOV AH, 09H
		LEA DX, paymentMsg3							; Display paymentMsg3
		INT 21H
		
			CMP tempSelect, "Y"							; Compare tempSelect with 'Y' and 'y'
				JE selectY1									; If tempSelect = 'Y' or 'y', then jump to selectY1
			CMP tempSelect, "y"
				JE selectY1

				ADD discAmt1, 48							; Else, add discAmt1 with 48 to represent '0' in ASCII value
				MOV AH, 02H
				MOV DL , discAmt1							; Display discAmt1
				INT 21H
				JMP printNext1								; After process complete, jump to printNext1
				
	selectY1:	MOV AX, discAmt2							; Move discAmt2 into AX
				CALL printAmount							; Call in printAmount sub-function to display the discountAmt2
				CALL checkFloat								; Call in checkFloat sub-function to check whether discAmt2 has floating point value or not
				
printNext1:	CALL newLine									; Call CR-LF sub-function
							
		MOV AH, 09H
		LEA DX, paymentMsg4							; Display paymentMsg4
		INT 21H
		
			CMP tempSelect, "Y"							; Compare tempSelect with 'Y' and 'y'
				JE selectY2									; If tempSelect = 'Y' or 'y', then jump to selectY2
			CMP tempSelect, "y"
				JE selectY2
				
				MOV AX, subTotal								; Else, move subTotal into AX register
					CALL calcSST									; Call in calcSST sub-function to calculate the sstAmt
				MOV AX, sstAmt									; Move sstAmt into AX register
				JMP printSST									; After process complete, jump to printSST
			
	selectY2:	MOV AX, discTotal								; Move discTotal into AX register
					CALL calcSST									; Call in calcSST sub-function to calculate the sstAmt
				MOV AX, sstAmt									; Move sstAmt into AX register
			
printSST:	CALL printAmount								; Call in printAmount sub-function to display the sstAmt
			CALL checkFloat									; Call in checkFloat sub-function to check whether sstAmt has floating point value or not
			
			CALL newLine									; Call CR-LF sub-function
				CALL newLine									; Call CR-LF sub-function
			
		MOV AH, 09H
		LEA DX, paymentSplit							; Display paymentSplit
		INT 21H
		
		MOV AH, 09H
		LEA DX, paymentMsg5								; Display paymentMsg5
		INT 21H
		
			CALL calcTotal									; Call in calcTotal sub-function to calculate total
				MOV AX, total									; Move total into AX register
			CALL printAmount								; Call in printAmount sub-function to display total
			CALL checkFloat									; Call in checkFloat sub-function to check whether total has floating point value or not
	
			CALL newLine									; Call CR-LF sub-function
				CALL newLine									; Call CR-LF sub-function
			
		MOV AH, 09H
		LEA DX, paymentSplit							; Display paymentSplit
		INT 21H
		
		MOV AH, 09H
		LEA DX, paymentMsg6								; Display paymentMsg6
		INT 21H
			MOV AH, 01H										; Accept user input a character
			INT 21H
			MOV tempSelect2, AL								; Move the user input char into tempSelect2
			
			CMP	tempSelect2, "Y"							; Compare tempSelect2 with 'Y' and 'y'
				JE	transSum									; If tempSelect2 = 'Y' or 'y', then jump to yesChoice
			CMP tempSelect2, "y"
				JE	transSum
			JMP exitPaym1									; Else, jump to exitPaym1
	
transSum:	CALL PROCESS5									; Call in Transaction Summary sub-function
			JMP exitPaym2									; Jump to exitPaym2

exitPaym1:	MOV AH, 06H										; Clear screen
			MOV AL, 00H										; Clear all lines
			MOV BH, 00001010B								; Format page
				
				MOV CX, 0000H									; Set scrolling point from top left
				MOV DX, 184FH									; to right bottom
				INT 10H
				
				MOV CX, 0000H									; Set scrolling point from top left
				MOV DX, 184FH									; to right bottom
				INT 10H
				
				MOV AH, 02H
				MOV BH, 00										; Set cursor position 
				MOV DH, 1										; Row 1
				MOV DL, 1										; Column 1
				INT 10H
				
			MOV AH, 09H
			LEA DX, endMsg									; Display endMsg
			INT 21H
				
exitPaym2:	RET												; Return
	PROCESS4 ENDP										; Payment Module ends here
	;-------------------------------------------------------------------------------------------------------------------------------------------------
	; CR-LF (Sub-function)
	newLine	PROC
		MOV AH, 02H
		MOV DL, 0DH
		INT 21H
		MOV DL, 0AH
		INT 21H
		RET
	newLine ENDP
	;-------------------------------------------------------------------------------------------------------------------------------------------------
	; Print Amount (Sub-function)
	printAmount	PROC								; printAmount sub-function starts here
		MOV DX, 0										; Move value 0 into DX register
		MOV CX, 0										; Move value 0 into CX register
numLoop:	CMP AX, 0										; Check whether AX = 0
				JE printLoop									; If AX = 0, then jump to printLoop
				
			MOV BX, 10										; Else, move value 10 into BX Register to be used in Division procedure
				
			DIV BX											; Division method with BX(10) as divisor and AX(any value moved into AX in main function) as quotient
				
			PUSH DX											; Push DX(Remainder) into top of stack
				
			INC CX											; Increase CX(Count) by 1
				
			XOR DX, DX										; Make DX become value 0
			JMP numLoop									; Jump to numLoop over and over until AX = 0
	
printLoop:	CMP CX, 0									; Check whether CX(Count) = 0
				JE exitPrint								; If CX = 0, then jump to exitPrint
				
			POP DX										; Else, pop the top of the stack
				
			ADD DX, 48									; Add 48 to the value to represent digits in ASCII
				
			MOV AH, 02H									; Print the value that popped out of the stack 
			INT 21H
				
			DEC CX										; Decrease CX(Count) by 1
			JMP printLoop								; Jump to printLoop over and over until CX = 0		
			
exitPrint:	RET											; Return
	printAmount ENDP								; printAmount sub-function ends here
	;-------------------------------------------------------------------------------------------------------------------------------------------------
	; Calculate Discount Amount (Sub-function)
	calcDiscAmt	PROC							; calcDiscAmt sub-function starts here
		MOV	BX, subTotal							; Move subTotal into BX Register to be used in Multiplication procedure
		MUL BX										; Multiply BX(subtotal) with AX(any value moved into AX in main function)
		
		MOV BX, 100									; Move value 100 into BX Register to be used in Division procedure
		DIV BX										; Division method with BX(100) as divisor and DX,AX(multiplication result) as dividend (obtain discount amount)
		
		MOV discAmt2, AX							; Store AX(Quotient) into discAmt2 for further use
		MOV	tempAfterFloat1, DX						; Store DX(Remainder) into tempAfterFloat1 for further use
		
		CMP tempAfterFloat1, 0						; Compare tempAfterFloat1 = 0
			JE exitCalcDisc								; If tempAfterFloat1 = 0, then jump to exitCalcDisc
			
		MOV AX, 100									; Else, Move value 100 into AX Register to be used in Multiplication procedure
		MOV BX, tempAfterFloat1						; Move tempAfterFloat1 into BX Register
		MUL BX										; Multiply BX(tempAfterFloat1) with AX(100)
		
		MOV BX, 100									; Move value 100 into BX Register
		DIV BX										; Division method with BX(100) as divisor and DX,AX(multiplication result) as dividend (obtain the floating value of discAmt2)
		
		MOV tempAfterFloat1, AX						; Store AX(Quotient) into tempAfterFloat1 to be displayed as floating point value in main function
		MOV tempAfterFloat, AX
		
exitCalcDisc:	RET									; Return
	calcDiscAmt ENDP							; calcDiscAmt sub-function ends here
	;-------------------------------------------------------------------------------------------------------------------------------------------------
	; Calculate Discount Total (Sub-function)
	calcDiscTotal	PROC						; calcDiscTotal sub-function starts here
		MOV AX, subTotal							; Move subTotal into AX Register
		
		SUB AX, discAmt2							; Subtract AX(Subtotal) with discAmt2
		MOV discTotal, AX							; Store AX(Subtracted value) into discTotal
		
		RET											; Return to main function
	calcDiscTotal	ENDP						; calcDiscTotal sub-function ends here
	;-------------------------------------------------------------------------------------------------------------------------------------------------
	; Calculate SST Amount (Sub-function)
	calcSST		PROC							; calcSST sub-function starts here
		MOV	BX, 5									; Move value 5 into BX Register to be used in Multiplication procedure
		MUL BX										; Multiply BX(5) with AX(any value moved into AX in main function)
		
		MOV BX, 100									; Move value 100 into BX Register to be used in Division procedure
		DIV BX										; Division method with BX(100) as divisor and DX,AX(multiplication result) as dividend (obtain sstAmt)
		
		MOV sstAmt, AX								; Store AX(Quotient) into sstAmt for further use
		MOV afterFloat, DX							; Store DX(Remainder) into afterFloat for further use
		
		CMP afterFloat, 0							; Compare afterFloat = 0
			JE exitCalcDisc								; If afterFloat = 0, then jump to exitCalcDisc
			
		MOV AX, 100									; Else, move value 100 into AX Register to be used in Multiplication procedure
		MOV BX, afterFloat							; Move afterFloat into BX Register
		MUL BX										; Multiply BX(afterFloat) with AX(100)
		
		MOV BX, 100									; Move value 100 into BX Register
		DIV BX										; Division method with BX(100) as divisor and DX,AX(multiplication result) as dividend (obtain the floating value of sstAmt)
		
		MOV tempAfterFloat2, AX						; Store AX(Quotient) into tempAfterFloat2 to be displayed as floating point value in main function
		MOV tempAfterFloat, AX
		
		RET											; Return
	calcSST		ENDP							; calcSST sub-function ends here
	;------------------------------------------------------------------------------------------------------------------------
	; Check Float (Sub-function)
	checkFloat	PROC							; checkFloat sub-function starts here
		CMP	tempAfterFloat, 0							; Compare DX = 0
			JE exitCheck								; If afterFloat = 0, then jump to exitCheck
		
		MOV AH, 02H
		MOV DL, '.'									; Else, display the character '.'
		INT 21H
		
		MOV AX, 100									; Move value 100 into AX Register to be used in Multiplication procedure
		MOV BX, tempAfterFloat						; Move afterFloat into BX Register
		MUL BX										; Multiply BX(afterFloat) with AX(100)
		
		MOV BX, 100									; Move value 100 into BX Register to be used in Division procedure
		DIV BX										; Division method with BX(100) as divisor and DX,AX(multiplication result) as dividend (obtain the floating value)
		
		CALL printAmount							; Call in printAmount sub-function
	exitCheck: RET									; Return
	checkFloat	ENDP
	;------------------------------------------------------------------------------------------------------------------------
	calcTotal	PROC							; calcTotal sub-function starts here
		MOV AX, Subtotal							; Move Subtotal into AX Register
		
			CMP tempSelect, "Y"						; Compare tempSelect with 'Y' and 'y'
				JE discNotNull1							; If tempSelect = 'Y' or 'y', then jump to discNotNull1
			CMP tempSelect, "y"
				JE discNotNull1
			JMP discNull							; Else, jump to discNull
			
discNotNull1:	SUB AX, discAmt2						; Subtract AX(Subtotal) with discAmt2
				
				CMP tempAfterFloat1, 0					; Compare tempAfterFloat1(discAmt2 float value) with 0
					JE discNotNull2							; If tempAfterFloat1 = 0, then jump to discNotNull2
					
				SUB AX, 1								; Else, subtract AX(Subtotal) by 1
				
discNotNull2:	MOV tempBeforeFloat1, AX				; Move AX(Subtotoal - discAmt2) into tempBeforeFloat1

				CMP tempAfterFloat1, 0					; Compare tempAfterFloat1(discAmt2 float value) with 0
					JE discNotNull3							; If tempAfterFloat1 = 0, then jump to discNotNull3
				
				mov AX, 100								; Else, move value into AX register
				SUB AX, tempAfterFloat1					; Subtotal AX(Subtotal float value = 100 ) with tempAfterFloat1(discAmt2 float value)
				MOV tempAfterFloat3, AX					; Move AX(Subtotal float value - discAmt2 float value) into tempAfterFloat3
				
discNotNull3:	MOV AX, tempBeforeFloat1				; Move tempBeforeFloat1(Discounted Total = Subtotal - discAmt2) into AX Register
				ADD AX, sstAmt							; Subtract AX(Discounted Total) with sstAmt
				MOV total, AX							; Move AX(Discounted Total - sstAmt) into total
				
				CMP tempAfterFloat2, 0					; Compare tempAfterFloat2(sstAmt float value) with 0
					JE exitCalcTotal						; If tempAfterFloat2 = 0, then jump to exitCalcTotal
				
				MOV AX, tempAfterFloat3					; Else, move tempAfterFloat3(Discounted total float value) into AX Register
				ADD AX, tempAfterFloat2					; ADD AX(tempAfterFloat3) with tempAfterFloat2(SST Amount float value)
				MOV totalFloat, AX
				CMP totalFloat, 100						; Compare AX with tempAfterFloat2(sstAmt float value)
					JLE exitCalcTotal					; If AX is lesser or equal to value 100, then jump to exitCalcTotal
				
				ADD total, 1							; Else, add total by 1
				SUB totalFloat, 100						; Subtract totalFloat by 100
				JMP exitCalcTotal						; Jump to exitCalcTotal
				
discNull:		ADD AX, sstAmt							; Subtract AX(Subtotal) with sstAmt
				MOV total, AX							; Move AX(total) into total
				
				CMP tempAfterFloat2, 0					; Compare tempAfterFloat2(sstAmt float value) with 0
					JE exitCalcTotal						; If tempAfterFloat2 = 0, then jump to exitCalcTotal
				
				ADD AX, tempAfterFloat2					; Add AX with tempAfterFloat2
				MOV totalFloat, AX						; Move AX into afterFloat
exitCalcTotal:	RET										; Return
	calcTotal	ENDP								; calcTotal sub-function ends here
;-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
;Transaction Summary Module starts here
PROCESS5	PROC										; Transaction Summary starts here
SummaryF:
	MOV AH, 06H											; Clear screen
	MOV AL, 00H											; Clear all lines
	MOV BH, 00001010B									; Format page
	MOV CX, 0000H										; Set scrolling point from Left top position
	MOV DX, 184FH										; Set scrolling point to right bottom position
	INT 10H	
	
	MOV AH, 02H
	MOV BH, 00											; Set cursor position
	MOV DH, 1											; Row 1
	MOV DL, 23											; Column 23
	INT 10H
	
    MOV AH, 09H                            				
    LEA DX, tranHEADER                        			; Display Transaction Summary HEADER
    INT 21H                                				
	
	CALL newLine										; Call CR-LF sub-function
	
	MOV AH, 09H                            				
    LEA DX, GREET                        				; Display greeting
    INT 21H 
	
	CALL newLine
	
	MOV AH, 09H
	LEA DX, MESSAGE										; Display MESSAGE
	INT 21H
	
	CALL newLine										; Call CR-LF sub-function
	
	MOV AH, 09H
	LEA DX, SPLIT										; Display SPLIT
	INT 21H
	
	MOV AH, 09H
	LEA DX, HOTEL										; Display HOTEL NAME
	INT 21H
	
	CMP TEMP, '1'                                		; Comparing TEMP with 1
	JE SINGLE1
	CMP TEMP, '2'                                		; Comparing TEMP with 2
	JE DOUBLE1
	CMP TEMP, '3'                                		; Comparing TEMP with 3
	JE TRIPLE1
	CMP TEMP, '4'                                		; Comparing TEMP with 4
	JE KING1
	CMP TEMP, '5'                               		; Comparing TEMP with 5
	JE SUITE1
	
	SINGLE1: MOV AH, 09H									; Display Single 
		LEA	DX , SIN
		INT 21H
		JMP Tran1
	
	DOUBLE1: MOV AH, 09H									; Display Double
		LEA	DX , DOU
		INT 21H
		JMP Tran1
	
	TRIPLE1: MOV AH, 09H									; Display Triple
		LEA	DX , TRI
		INT 21H
		JMP Tran1
	
	KING1: MOV AH, 09H									; Display King
		LEA	DX , K
		INT 21H
		JMP Tran1
	
	SUITE1: MOV AH, 09H									; Display Suite
		LEA	DX , SUI
		INT 21H
		JMP Tran1	
		
Tran1: CALL newLine										;  Call CR-LF sub-function
	 
		MOV AH, 09H
		LEA DX, paymentMsg2							; Display paymentMsg2
		INT 21H
		
		MOV AX, subTotal							; Move subTotal into AX register
		CALL printAmount							; Call in printAmount sub-function to print the subTotal
						
			CALL newLine									; Call CR-LF sub-function
							
		MOV AH, 09H
		LEA DX, paymentMsg3							; Display paymentMsg3
		INT 21H
		
			CMP tempSelect, "Y"							; Compare tempSelect with 'Y' and 'y'
				JE A1									; If tempSelect = 'Y' or 'y', then jump to A1
			CMP tempSelect, "y"
				JE A1

				MOV AH, 02H
				MOV DL , discAmt1							; Display discAmt1
				INT 21H
				JMP printNewLine								; After process complete, jump to printNewLine
				
	A1:	MOV AX, discAmt2							; Move discAmt2 into AX
				CALL printAmount							; Call in printAmount sub-function to display the discountAmt2
				MOV AX, tempAfterFloat1
				MOV tempAfterFloat, AX
				CALL checkFloat								; Call in checkFloat sub-function to check whether discAmt2 has floating point value or not
				
printNewLine:	CALL newLine									; Call CR-LF sub-function
							
		MOV AH, 09H
		LEA DX, paymentMsg4							; Display paymentMsg4
		INT 21H
			
displaySST:	MOV AX, sstAmt
			CALL printAmount								; Call in printAmount sub-function to display the sstAmt
			MOV AX, tempAfterFloat2
			MOV tempAfterFloat, AX
			CALL checkFloat									; Call in checkFloat sub-function to check whether sstAmt has floating point value or not
			
			CALL newLine									; Call CR-LF sub-function
				CALL newLine									; Call CR-LF sub-function
			
		MOV AH, 09H
		LEA DX, paymentSplit							; Display paymentSplit
		INT 21H
		
		MOV AH, 09H
		LEA DX, paymentMsg5								; Display paymentMsg5
		INT 21H
		
			CALL calcTotal									; Call in calcTotal sub-function to calculate total
				MOV AX, total									; Move total into AX register
			CALL printAmount								; Call in printAmount sub-function to display total
			MOV AX, totalFloat
			MOV tempAfterFloat, AX
			CALL checkFloat									; Call in checkFloat sub-function to check whether total has floating point value or not
	
				CALL newLine									; Call CR-LF sub-function
					CALL newLine									; Call CR-LF sub-function
		
		MOV AH, 09H
		LEA DX, PRESS							; Display PRESS
		INT 21H
		
		MOV AH, 01H								; Accept user input
		INT 21H
		MOV tempSelect3, AL
		
		CMP	tempSelect3, "Y"							 ; Compare tempSelect3 = 'Y' or 'y'
			JE Term
		CMP tempSelect3, "y"
			JE Term
		CMP tempSelect3, "N"							 ; Compare tempSelect3 = 'N' or 'n'
			JE Term
		CMP tempSelect3, "n"
			JE Term
		JMP SummaryF
		
Term:	RET													;Return
    PROCESS5 ENDP                            				; Main function ends here

END MAIN