
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
	GOTO       L__delay12
	MOVF       FARG_delay_k+0, 0
	SUBWF      R1+0, 0
L__delay12:
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
	GOTO       L__delay13
	MOVLW      232
	SUBWF      R3+0, 0
L__delay13:
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
;Signals.c,14 :: 		{short duty1 = 180; //Initial value for duty
	MOVLW      180
	MOVWF      main_duty1_L0+0
;Signals.c,15 :: 		TRISD = 0xFF; //PORTD as input
	MOVLW      255
	MOVWF      TRISD+0
;Signals.c,16 :: 		TRISC = 0x00; //PORTC as output
	CLRF       TRISC+0
;Signals.c,17 :: 		TRISB = 0x00; //PORTB as output
	CLRF       TRISB+0
;Signals.c,18 :: 		TRISA = 0x00; //PORTA as output
	CLRF       TRISA+0
;Signals.c,19 :: 		PWM1_Init(1000); //Initialize PWM1
	BCF        T2CON+0, 0
	BCF        T2CON+0, 1
	MOVLW      249
	MOVWF      PR2+0
	CALL       _PWM1_Init+0
;Signals.c,20 :: 		PWM1_Start(); //start PWM1
	CALL       _PWM1_Start+0
;Signals.c,21 :: 		PWM1_Set_Duty(duty1); //Set current duty for PWM1
	MOVF       main_duty1_L0+0, 0
	MOVWF      FARG_PWM1_Set_Duty_new_duty+0
	CALL       _PWM1_Set_Duty+0
;Signals.c,25 :: 		while (1) //Endless loop
L_main6:
;Signals.c,27 :: 		if (PORTD.F0==0)
	BTFSC      PORTD+0, 0
	GOTO       L_main8
;Signals.c,28 :: 		{PORTC.F4=1; //Run motor in clockwise
	BSF        PORTC+0, 4
;Signals.c,29 :: 		PORTC.F5=0; //Run motor in clockwise
	BCF        PORTC+0, 5
;Signals.c,30 :: 		PORTB.F0=1; // Signal 1 is RED
	BSF        PORTB+0, 0
;Signals.c,31 :: 		PORTB.F1=0;// Signal 1 is RED
	BCF        PORTB+0, 1
;Signals.c,32 :: 		PORTB.F2=0;// Signal 1 is RED
	BCF        PORTB+0, 2
;Signals.c,33 :: 		PORTB.F3=0; // Signal 2 is GREEN
	BCF        PORTB+0, 3
;Signals.c,34 :: 		PORTB.F4=0;// Signal 2 is GREEN
	BCF        PORTB+0, 4
;Signals.c,35 :: 		PORTB.F5=1;// Signal 2 is GREEN
	BSF        PORTB+0, 5
;Signals.c,36 :: 		PORTB.F6=0; // Signal 3 is GREEN
	BCF        PORTB+0, 6
;Signals.c,37 :: 		PORTB.F7=0;// Signal 3 is GREEN
	BCF        PORTB+0, 7
;Signals.c,38 :: 		PORTC.F0=1;// Signal 3 is GREEN
	BSF        PORTC+0, 0
;Signals.c,39 :: 		delay(5);
	MOVLW      5
	MOVWF      FARG_delay_k+0
	MOVLW      0
	MOVWF      FARG_delay_k+1
	CALL       _delay+0
;Signals.c,40 :: 		}
L_main8:
;Signals.c,43 :: 		if (PORTD.F1==0)
	BTFSC      PORTD+0, 1
	GOTO       L_main9
;Signals.c,44 :: 		{ PORTC.F4=0; //Run motor in anticlockwise
	BCF        PORTC+0, 4
;Signals.c,45 :: 		PORTC.F5=1; //Run motor in anticlockwise
	BSF        PORTC+0, 5
;Signals.c,46 :: 		PORTB.F0=0; // Signal 1 is GREEN
	BCF        PORTB+0, 0
;Signals.c,47 :: 		PORTB.F1=0;// Signal 1 is GREEN
	BCF        PORTB+0, 1
;Signals.c,48 :: 		PORTB.F2=1;// Signal 1 is GREEN
	BSF        PORTB+0, 2
;Signals.c,49 :: 		PORTB.F3=1; // Signal 2 is RED
	BSF        PORTB+0, 3
;Signals.c,50 :: 		PORTB.F4=0;// Signal 2 is RED
	BCF        PORTB+0, 4
;Signals.c,51 :: 		PORTB.F5=0;// Signal 2 is RED
	BCF        PORTB+0, 5
;Signals.c,52 :: 		PORTB.F6=1; // Signal 3 is RED
	BSF        PORTB+0, 6
;Signals.c,53 :: 		PORTB.F7=0;// Signal 3 is RED
	BCF        PORTB+0, 7
;Signals.c,54 :: 		PORTC.F0=0;// Signal 3 is RED
	BCF        PORTC+0, 0
;Signals.c,55 :: 		delay(5);
	MOVLW      5
	MOVWF      FARG_delay_k+0
	MOVLW      0
	MOVWF      FARG_delay_k+1
	CALL       _delay+0
;Signals.c,56 :: 		}
L_main9:
;Signals.c,58 :: 		if (PORTD.F2==0)
	BTFSC      PORTD+0, 2
	GOTO       L_main10
;Signals.c,59 :: 		{ PORTC.F4=0; //Stop the Motor
	BCF        PORTC+0, 4
;Signals.c,60 :: 		PORTC.F5=0; //Stop the Motor
	BCF        PORTC+0, 5
;Signals.c,61 :: 		PORTB.F0=1; // Signal 1 is RED
	BSF        PORTB+0, 0
;Signals.c,62 :: 		PORTB.F1=0;// Signal 1 is RED
	BCF        PORTB+0, 1
;Signals.c,63 :: 		PORTB.F2=0;// Signal 1 is RED
	BCF        PORTB+0, 2
;Signals.c,64 :: 		PORTB.F3=0; // Signal 2 is GREEN
	BCF        PORTB+0, 3
;Signals.c,65 :: 		PORTB.F4=0;// Signal 2 is GREEN
	BCF        PORTB+0, 4
;Signals.c,66 :: 		PORTB.F5=1;// Signal 2 is GREEN
	BSF        PORTB+0, 5
;Signals.c,67 :: 		PORTB.F6=0; // Signal 3 is GREEN
	BCF        PORTB+0, 6
;Signals.c,68 :: 		PORTB.F7=0;// Signal 3 is GREEN
	BCF        PORTB+0, 7
;Signals.c,69 :: 		PORTC.F0=1;// Signal 3 is GREEN
	BSF        PORTC+0, 0
;Signals.c,70 :: 		delay(5);
	MOVLW      5
	MOVWF      FARG_delay_k+0
	MOVLW      0
	MOVWF      FARG_delay_k+1
	CALL       _delay+0
;Signals.c,71 :: 		}
L_main10:
;Signals.c,72 :: 		}
	GOTO       L_main6
;Signals.c,73 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
