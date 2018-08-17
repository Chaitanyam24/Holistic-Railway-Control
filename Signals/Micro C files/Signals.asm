
_delay:

;Signals.c,1 :: 		void delay(int k)
;Signals.c,4 :: 		for (i=0;i<k;i++)
	CLRF       R1+0
	CLRF       R1+1
L_delay0:
	MOVLW      128
	XORWF      R1+1, 0
	MOVWF      R0+0
	MOVLW      128
	XORWF      FARG_delay_k+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__delay17
	MOVF       FARG_delay_k+0, 0
	SUBWF      R1+0, 0
L__delay17:
	BTFSC      STATUS+0, 0
	GOTO       L_delay1
;Signals.c,6 :: 		for (j=0;j<1000;j++);
	CLRF       R3+0
	CLRF       R3+1
L_delay3:
	MOVLW      128
	XORWF      R3+1, 0
	MOVWF      R0+0
	MOVLW      128
	XORLW      3
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__delay18
	MOVLW      232
	SUBWF      R3+0, 0
L__delay18:
	BTFSC      STATUS+0, 0
	GOTO       L_delay4
	INCF       R3+0, 1
	BTFSC      STATUS+0, 2
	INCF       R3+1, 1
	GOTO       L_delay3
L_delay4:
;Signals.c,4 :: 		for (i=0;i<k;i++)
	INCF       R1+0, 1
	BTFSC      STATUS+0, 2
	INCF       R1+1, 1
;Signals.c,7 :: 		}
	GOTO       L_delay0
L_delay1:
;Signals.c,8 :: 		}
L_end_delay:
	RETURN
; end of _delay

_main:

;Signals.c,12 :: 		void main()
;Signals.c,14 :: 		{ TRISD = 0xFF; //PORTD as input
	MOVLW      255
	MOVWF      TRISD+0
;Signals.c,15 :: 		TRISC = 0x00; //PORTC as output
	CLRF       TRISC+0
;Signals.c,16 :: 		TRISB = 0x00; //PORTB as output
	CLRF       TRISB+0
;Signals.c,17 :: 		TRISA = 0x00; //PORTA as output
	CLRF       TRISA+0
;Signals.c,20 :: 		while (1) //Endless loop
L_main6:
;Signals.c,23 :: 		if (PORTD.F0==1  && PORTD.F1==1  ) // Internal tracks are operational. Hence incoming Train has to wait.
	BTFSS      PORTD+0, 0
	GOTO       L_main10
	BTFSS      PORTD+0, 1
	GOTO       L_main10
L__main15:
;Signals.c,24 :: 		{ PORTB = 0x01;// Signal 1 is RED
	MOVLW      1
	MOVWF      PORTB+0
;Signals.c,25 :: 		PORTC= 0x04; // Signal 2 is GREEN
	MOVLW      4
	MOVWF      PORTC+0
;Signals.c,26 :: 		PORTA= 0x04; // Signal 3 is GREEN
	MOVLW      4
	MOVWF      PORTA+0
;Signals.c,27 :: 		delay(5);
	MOVLW      5
	MOVWF      FARG_delay_k+0
	MOVLW      0
	MOVWF      FARG_delay_k+1
	CALL       _delay+0
;Signals.c,28 :: 		}
L_main10:
;Signals.c,29 :: 		if (PORTD.F0==1  && PORTD.F1==0  ) // Switching starts,  outward train has to switch to track 2.
	BTFSS      PORTD+0, 0
	GOTO       L_main13
	BTFSC      PORTD+0, 1
	GOTO       L_main13
L__main14:
;Signals.c,30 :: 		{ PORTB = 0x04; // Signal 1 is GREEN
	MOVLW      4
	MOVWF      PORTB+0
;Signals.c,31 :: 		PORTC= 0x01; // Signal 2 is RED
	MOVLW      1
	MOVWF      PORTC+0
;Signals.c,32 :: 		PORTA= 0x01; // Signal 3 is RED
	MOVLW      1
	MOVWF      PORTA+0
;Signals.c,33 :: 		delay(5);
	MOVLW      5
	MOVWF      FARG_delay_k+0
	MOVLW      0
	MOVWF      FARG_delay_k+1
	CALL       _delay+0
;Signals.c,35 :: 		}
L_main13:
;Signals.c,37 :: 		}
	GOTO       L_main6
;Signals.c,38 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
