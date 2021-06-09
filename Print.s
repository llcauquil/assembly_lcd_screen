; Print.s
; Student names: change this to your names or look very silly
; Last modification date: change this to the last modification date or look very silly
; Runs on LM4F120 or TM4C123
; EE319K lab 7 device driver for any LCD
;
; As part of Lab 7, students need to implement these LCD_OutDec and LCD_OutFix
; This driver assumes two low-level LCD functions
; ST7735_OutChar   outputs a single 8-bit ASCII character
; ST7735_OutString outputs a null-terminated string 

    IMPORT   ST7735_OutChar
    IMPORT   ST7735_OutString
    EXPORT   LCD_OutDec
    EXPORT   LCD_OutFix

    AREA    |.text|, CODE, READONLY, ALIGN=2
    THUMB

  


		
LCD_OutDec
    PUSH {R4,LR}               
    MOV R2, #10                 
    MOV R4, #0              
	
LOOP
    UDIV R3, R0, R2               
    MUL R1, R3, R2               
    SUB R1, R0, R1               
    PUSH {R1}                   
    ADD R4, R4, #1               
    MOVS R0, R3                   
    CMP R0, #0
    BNE LOOP

OUT
    POP {R0}                   
    ADD R0, R0, #0x30           
    PRESERVE8
    PUSH {R0}
    BL ST7735_OutChar               
    POP {R0}                   
    SUBS R4, R4, #1               
    BNE OUT
    POP {R4,LR}               
    BX  LR

LCD_OutFix
overload  DCB "*.***"

    PUSH {R4, LR}   
    MOV R4, SP
    SUBS SP, #4
    MOV R1, #9999
    CMP R0, R1                   
    BHI    OVER               
   
    MOV     R2, #1000
    UDIV    R3, R0, R2           
    STR     R3, [R4, #12]
    MUL     R1, R3, R2           
    SUB     R0, R0, R1           

    MOV     R2, #100
    UDIV    R3, R0, R2       
    STR     R3, [R4, #16]
    MUL     R1, R3, R2           
    SUB     R0, R0, R1               

    MOV     R2, #10
    UDIV    R3, R0, R2           
    STR     R3, [R4, #20]
    MUL     R1, R3, R2           
    SUB     R0, R0, R1           

    MOV     R2, #1
    UDIV     R3, R0, R2
    STR     R3, [R4, #28]
    MUL        R1, R3, R2
    SUB        R0, R0, R1

    LDR    R0, [R4, #12]   
    ADD R0, R0, #0x30           
    PRESERVE8
    PUSH {R0}
    BL ST7735_OutChar
    POP {R0}
   
    MOV R0, #'.'           
    PRESERVE8
    PUSH {R0}
    BL ST7735_OutChar
    POP {R0}
   
    LDR R0, [R4, #16]
    ADD R0, R0, #0x30       
    PRESERVE8
    PUSH {R0}
    BL ST7735_OutChar
    POP {R0}

    LDR R0, [R4, #20]
    ADD R0, R0, #0x30           
    PRESERVE8
    PUSH {R0}
    BL ST7735_OutChar
    POP {R0}

    LDR    R0, [R4, #28]
    ADD R0, R0, #0x30           
    PRESERVE8
    PUSH {R0}
    BL ST7735_OutChar
    POP {R0}   
    ADD SP, #4   
    B        FIN   
   
OVER
    ADD SP, #4               
    LDR R0, =overload           
    PRESERVE8
    PUSH {R0}
    BL ST7735_OutString
    POP {R0}

FIN
    POP {R4,LR}
    BX  LR
 
     ALIGN
;* * * * * * * * End of LCD_OutFix * * * * * * * *

     ALIGN                           ; make sure the end of this section is aligned
     END                             ; end of file
