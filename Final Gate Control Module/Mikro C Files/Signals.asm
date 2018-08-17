
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
	GOTO       L__delay33
	MOVF       FARG_delay_k+0, 0
	SUBWF      R1+0, 0
L__delay33:
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
	GOTO       L__delay34
	MOVLW      232
	SUBWF      R3+0, 0
L__delay34:
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
;Signals.c,15 :: 		ADCON1 = 0x86; // PORTA Digital
	MOVLW      134
	MOVWF      ADCON1+0
;Signals.c,16 :: 		TRISD = 0xFF; //PORTD as input
	MOVLW      255
	MOVWF      TRISD+0
;Signals.c,17 :: 		TRISC = 0x00; //PORTC as output
	CLRF       TRISC+0
;Signals.c,18 :: 		TRISB = 0x00; //PORTB as output
	CLRF       TRISB+0
;Signals.c,19 :: 		TRISA = 0xFF; //PORTA as input
	MOVLW      255
	MOVWF      TRISA+0
;Signals.c,20 :: 		PWM1_Init(1000); //Initialize PWM1
	BCF        T2CON+0, 0
	BCF        T2CON+0, 1
	MOVLW      249
	MOVWF      PR2+0
	CALL       _PWM1_Init+0
;Signals.c,21 :: 		PWM1_Start(); //start PWM1
	CALL       _PWM1_Start+0
;Signals.c,22 :: 		PWM1_Set_Duty(duty1); //Set current duty for PWM1
	MOVF       main_duty1_L0+0, 0
	MOVWF      FARG_PWM1_Set_Duty_new_duty+0
	CALL       _PWM1_Set_Duty+0
;Signals.c,26 :: 		while (1) //Endless loop
L_main6:
;Signals.c,28 :: 		if (PORTA.F0==0  && PORTA.F1==1 ) // No Priority
	BTFSC      PORTA+0, 0
	GOTO       L_main10
	BTFSS      PORTA+0, 1
	GOTO       L_main10
L__main31:
;Signals.c,30 :: 		if (PORTD.F0==1  && PORTD.F4==1 ) // Train arrives
	BTFSS      PORTD+0, 0
	GOTO       L_main13
	BTFSS      PORTD+0, 4
	GOTO       L_main13
L__main30:
;Signals.c,31 :: 		{  PORTC.F4=1; //Run motor in clockwise
	BSF        PORTC+0, 4
;Signals.c,32 :: 		PORTC.F5=0; //Run motor in clockwise
	BCF        PORTC+0, 5
;Signals.c,33 :: 		PORTC.F6=1; //Run motor in clockwise
	BSF        PORTC+0, 6
;Signals.c,34 :: 		PORTC.F7=0; //Run motor in clockwise
	BCF        PORTC+0, 7
;Signals.c,35 :: 		PORTB.F0=0; // Signal 1 is GREEN
	BCF        PORTB+0, 0
;Signals.c,36 :: 		PORTB.F1=0;// Signal 1 is GREEN
	BCF        PORTB+0, 1
;Signals.c,37 :: 		PORTB.F2=1;// Signal 1 is GREEN
	BSF        PORTB+0, 2
;Signals.c,38 :: 		PORTB.F3=0; // Signal 2 is GREEN
	BCF        PORTB+0, 3
;Signals.c,39 :: 		PORTB.F4=0;// Signal 2 is GREEN
	BCF        PORTB+0, 4
;Signals.c,40 :: 		PORTB.F5=1;// Signal 2 is GREEN
	BSF        PORTB+0, 5
;Signals.c,41 :: 		PORTB.F6=0; // Signal 3 is OFF
	BCF        PORTB+0, 6
;Signals.c,42 :: 		PORTB.F7=0;// Signal 3 is OFF
	BCF        PORTB+0, 7
;Signals.c,43 :: 		PORTC.F0=0;// Signal 3 is OFF
	BCF        PORTC+0, 0
;Signals.c,44 :: 		delay(5);
	MOVLW      5
	MOVWF      FARG_delay_k+0
	MOVLW      0
	MOVWF      FARG_delay_k+1
	CALL       _delay+0
;Signals.c,45 :: 		}
L_main13:
;Signals.c,46 :: 		if (PORTD.F3==1  && PORTD.F1==1 )  // Train departs
	BTFSS      PORTD+0, 3
	GOTO       L_main16
	BTFSS      PORTD+0, 1
	GOTO       L_main16
L__main29:
;Signals.c,47 :: 		{ PORTC.F4=0; //Run motor in anticlockwise
	BCF        PORTC+0, 4
;Signals.c,48 :: 		PORTC.F5=1; //Run motor in anticlockwise
	BSF        PORTC+0, 5
;Signals.c,49 :: 		PORTC.F6=0; //Run motor in anticlockwise
	BCF        PORTC+0, 6
;Signals.c,50 :: 		PORTC.F7=1; //Run motor in anticlockwise
	BSF        PORTC+0, 7
;Signals.c,51 :: 		PORTB.F0=1; // Signal 1 is RED
	BSF        PORTB+0, 0
;Signals.c,52 :: 		PORTB.F1=0;// Signal 1 is RED
	BCF        PORTB+0, 1
;Signals.c,53 :: 		PORTB.F2=0;// Signal 1 is RED
	BCF        PORTB+0, 2
;Signals.c,54 :: 		PORTB.F3=1; // Signal 2 is RED
	BSF        PORTB+0, 3
;Signals.c,55 :: 		PORTB.F4=0;// Signal 2 is RED
	BCF        PORTB+0, 4
;Signals.c,56 :: 		PORTB.F5=0;// Signal 2 is RED
	BCF        PORTB+0, 5
;Signals.c,57 :: 		PORTB.F6=0; // Signal 3 is OFF
	BCF        PORTB+0, 6
;Signals.c,58 :: 		PORTB.F7=0;// Signal 3 is OFF
	BCF        PORTB+0, 7
;Signals.c,59 :: 		PORTC.F0=0;// Signal 3 is OFF
	BCF        PORTC+0, 0
;Signals.c,61 :: 		delay(5);
	MOVLW      5
	MOVWF      FARG_delay_k+0
	MOVLW      0
	MOVWF      FARG_delay_k+1
	CALL       _delay+0
;Signals.c,62 :: 		}
L_main16:
;Signals.c,63 :: 		if (PORTD.F6==1 ) // Car arrives
	BTFSS      PORTD+0, 6
	GOTO       L_main17
;Signals.c,65 :: 		PORTB.F0=0; // Signal 1 is OFF
	BCF        PORTB+0, 0
;Signals.c,66 :: 		PORTB.F1=0;// Signal 1 is OFF
	BCF        PORTB+0, 1
;Signals.c,67 :: 		PORTB.F2=0;// Signal 1 is OFF
	BCF        PORTB+0, 2
;Signals.c,68 :: 		PORTB.F3=1; // Signal 2 is RED
	BSF        PORTB+0, 3
;Signals.c,69 :: 		PORTB.F4=0;// Signal 2 is RED
	BCF        PORTB+0, 4
;Signals.c,70 :: 		PORTB.F5=0;// Signal 2 is RED
	BCF        PORTB+0, 5
;Signals.c,71 :: 		PORTB.F6=1; // Signal 3 is RED
	BSF        PORTB+0, 6
;Signals.c,72 :: 		PORTB.F7=0;// Signal 3 is RED
	BCF        PORTB+0, 7
;Signals.c,73 :: 		PORTC.F0=0;// Signal 3 is RED
	BCF        PORTC+0, 0
;Signals.c,74 :: 		delay(5);
	MOVLW      5
	MOVWF      FARG_delay_k+0
	MOVLW      0
	MOVWF      FARG_delay_k+1
	CALL       _delay+0
;Signals.c,75 :: 		PORTC.F4=0; //Stop the Motor
	BCF        PORTC+0, 4
;Signals.c,76 :: 		PORTC.F5=0; //Stop the Motor
	BCF        PORTC+0, 5
;Signals.c,77 :: 		PORTC.F6=0; //Stop the Motor
	BCF        PORTC+0, 6
;Signals.c,78 :: 		PORTC.F7=0; //Stop the Motor
	BCF        PORTC+0, 7
;Signals.c,79 :: 		}
L_main17:
;Signals.c,81 :: 		if (PORTD.F7==1 ) // Car departs
	BTFSS      PORTD+0, 7
	GOTO       L_main18
;Signals.c,83 :: 		PORTB.F0=0; // Signal 1 is OFF
	BCF        PORTB+0, 0
;Signals.c,84 :: 		PORTB.F1=0;// Signal 1 is OFF
	BCF        PORTB+0, 1
;Signals.c,85 :: 		PORTB.F2=0;// Signal 1 is OFF
	BCF        PORTB+0, 2
;Signals.c,86 :: 		PORTB.F3=0; // Signal 2 is GREEN
	BCF        PORTB+0, 3
;Signals.c,87 :: 		PORTB.F4=0;// Signal 2 is GREEN
	BCF        PORTB+0, 4
;Signals.c,88 :: 		PORTB.F5=1;// Signal 2 is GREEN
	BSF        PORTB+0, 5
;Signals.c,89 :: 		PORTB.F6=0; // Signal 3 is GREEN
	BCF        PORTB+0, 6
;Signals.c,90 :: 		PORTB.F7=0;// Signal 3 is GREEN
	BCF        PORTB+0, 7
;Signals.c,91 :: 		PORTC.F0=1;// Signal 3 is GREEN
	BSF        PORTC+0, 0
;Signals.c,92 :: 		delay(5);
	MOVLW      5
	MOVWF      FARG_delay_k+0
	MOVLW      0
	MOVWF      FARG_delay_k+1
	CALL       _delay+0
;Signals.c,93 :: 		PORTC.F4=0; //Stop the Motor
	BCF        PORTC+0, 4
;Signals.c,94 :: 		PORTC.F5=0; //Stop the Motor
	BCF        PORTC+0, 5
;Signals.c,95 :: 		PORTC.F6=0; //Stop the Motor
	BCF        PORTC+0, 6
;Signals.c,96 :: 		PORTC.F7=0; //Stop the Motor
	BCF        PORTC+0, 7
;Signals.c,98 :: 		}
L_main18:
;Signals.c,99 :: 		}
L_main10:
;Signals.c,101 :: 		if (PORTA.F0==0  && PORTA.F1==0  ) // Train Priority
	BTFSC      PORTA+0, 0
	GOTO       L_main21
	BTFSC      PORTA+0, 1
	GOTO       L_main21
L__main28:
;Signals.c,103 :: 		if (PORTD.F0==1 )
	BTFSS      PORTD+0, 0
	GOTO       L_main22
;Signals.c,105 :: 		PORTC.F4=1; //Run motor in clockwise
	BSF        PORTC+0, 4
;Signals.c,106 :: 		PORTC.F5=0; //Run motor in clockwise
	BCF        PORTC+0, 5
;Signals.c,107 :: 		PORTC.F6=1; //Run motor in clockwise
	BSF        PORTC+0, 6
;Signals.c,108 :: 		PORTC.F7=0; //Run motor in clockwise
	BCF        PORTC+0, 7
;Signals.c,109 :: 		PORTB.F0=0; // Signal 1 is GREEN
	BCF        PORTB+0, 0
;Signals.c,110 :: 		PORTB.F1=0;// Signal 1 is GREEN
	BCF        PORTB+0, 1
;Signals.c,111 :: 		PORTB.F2=1;// Signal 1 is GREEN
	BSF        PORTB+0, 2
;Signals.c,112 :: 		PORTB.F3=0; // Signal 2 is OFF
	BCF        PORTB+0, 3
;Signals.c,113 :: 		PORTB.F4=0;// Signal 2 is OFF
	BCF        PORTB+0, 4
;Signals.c,114 :: 		PORTB.F5=0;// Signal 2 is OFF
	BCF        PORTB+0, 5
;Signals.c,115 :: 		PORTB.F6=0; // Signal 3 is OFF
	BCF        PORTB+0, 6
;Signals.c,116 :: 		PORTB.F7=0;// Signal 3 is OFF
	BCF        PORTB+0, 7
;Signals.c,117 :: 		PORTC.F0=0;// Signal 3 is OFF
	BCF        PORTC+0, 0
;Signals.c,119 :: 		delay(5);
	MOVLW      5
	MOVWF      FARG_delay_k+0
	MOVLW      0
	MOVWF      FARG_delay_k+1
	CALL       _delay+0
;Signals.c,121 :: 		}
L_main22:
;Signals.c,124 :: 		}
L_main21:
;Signals.c,125 :: 		if (PORTA.F0==1  && PORTA.F1==1  ) // Car Priority
	BTFSS      PORTA+0, 0
	GOTO       L_main25
	BTFSS      PORTA+0, 1
	GOTO       L_main25
L__main27:
;Signals.c,127 :: 		if (PORTD.F6==1 )
	BTFSS      PORTD+0, 6
	GOTO       L_main26
;Signals.c,130 :: 		PORTB.F0=1; // Signal 1 is RED
	BSF        PORTB+0, 0
;Signals.c,131 :: 		PORTB.F1=0;// Signal 1 is RED
	BCF        PORTB+0, 1
;Signals.c,132 :: 		PORTB.F2=0;// Signal 1 is RED
	BCF        PORTB+0, 2
;Signals.c,133 :: 		PORTB.F3=1; // Signal 2 is RED
	BSF        PORTB+0, 3
;Signals.c,134 :: 		PORTB.F4=0;// Signal 2 is RED
	BCF        PORTB+0, 4
;Signals.c,135 :: 		PORTB.F5=0;// Signal 2 is RED
	BCF        PORTB+0, 5
;Signals.c,136 :: 		PORTB.F6=1; // Signal 3 is RED
	BSF        PORTB+0, 6
;Signals.c,137 :: 		PORTB.F7=0;// Signal 3 is RED
	BCF        PORTB+0, 7
;Signals.c,138 :: 		PORTC.F0=0;// Signal 3 is RED
	BCF        PORTC+0, 0
;Signals.c,139 :: 		delay(5);
	MOVLW      5
	MOVWF      FARG_delay_k+0
	MOVLW      0
	MOVWF      FARG_delay_k+1
	CALL       _delay+0
;Signals.c,140 :: 		PORTC.F4=0; //Run motor in anticlockwise
	BCF        PORTC+0, 4
;Signals.c,141 :: 		PORTC.F5=1; //Run motor in anticlockwise
	BSF        PORTC+0, 5
;Signals.c,142 :: 		PORTC.F6=0; //Run motor in anticlockwise
	BCF        PORTC+0, 6
;Signals.c,143 :: 		PORTC.F7=1; //Run motor in anticlockwise
	BSF        PORTC+0, 7
;Signals.c,144 :: 		}
L_main26:
;Signals.c,145 :: 		}
L_main25:
;Signals.c,159 :: 		}
	GOTO       L_main6
;Signals.c,160 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
