  void delay(int k)
{
      int i,j;
      for (i=0;i<k;i++)
      {
          for (j=0;j<1000;j++);
      }
}



void main()

{short duty1 = 180; //Initial value for duty
TRISD = 0xFF; //PORTD as input
TRISC = 0x00; //PORTC as output
TRISB = 0x00; //PORTB as output
TRISA = 0x00; //PORTA as output
PWM1_Init(1000); //Initialize PWM1
PWM1_Start(); //start PWM1
PWM1_Set_Duty(duty1); //Set current duty for PWM1



 while (1) //Endless loop
{
if (PORTD.F0==0)
{PORTC.F4=1; //Run motor in clockwise
 PORTC.F5=0; //Run motor in clockwise
 PORTB.F0=1; // Signal 1 is RED
 PORTB.F1=0;// Signal 1 is RED
 PORTB.F2=0;// Signal 1 is RED
 PORTB.F3=0; // Signal 2 is GREEN
 PORTB.F4=0;// Signal 2 is GREEN
 PORTB.F5=1;// Signal 2 is GREEN
 PORTB.F6=0; // Signal 3 is GREEN
 PORTB.F7=0;// Signal 3 is GREEN
 PORTC.F0=1;// Signal 3 is GREEN
 delay(5);
}


if (PORTD.F1==0)
{ PORTC.F4=0; //Run motor in anticlockwise
  PORTC.F5=1; //Run motor in anticlockwise
  PORTB.F0=0; // Signal 1 is GREEN
  PORTB.F1=0;// Signal 1 is GREEN
  PORTB.F2=1;// Signal 1 is GREEN
  PORTB.F3=1; // Signal 2 is RED
  PORTB.F4=0;// Signal 2 is RED
  PORTB.F5=0;// Signal 2 is RED
  PORTB.F6=1; // Signal 3 is RED
  PORTB.F7=0;// Signal 3 is RED
  PORTC.F0=0;// Signal 3 is RED
  delay(5);
}

if (PORTD.F2==0)
{ PORTC.F4=0; //Stop the Motor
  PORTC.F5=0; //Stop the Motor
  PORTB.F0=1; // Signal 1 is RED
 PORTB.F1=0;// Signal 1 is RED
 PORTB.F2=0;// Signal 1 is RED
 PORTB.F3=0; // Signal 2 is GREEN
 PORTB.F4=0;// Signal 2 is GREEN
 PORTB.F5=1;// Signal 2 is GREEN
 PORTB.F6=0; // Signal 3 is GREEN
 PORTB.F7=0;// Signal 3 is GREEN
 PORTC.F0=1;// Signal 3 is GREEN
 delay(5);
  }
 }
 }