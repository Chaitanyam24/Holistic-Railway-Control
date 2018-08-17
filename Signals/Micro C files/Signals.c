  void delay(int k)
{
      int i,j;
      for (i=0;i<k;i++)
      {
          for (j=0;j<1000;j++);
      }
}



void main()

{ TRISD = 0xFF; //PORTD as input
TRISC = 0x00; //PORTC as output
TRISB = 0x00; //PORTB as output
TRISA = 0x00; //PORTA as output


 while (1) //Endless loop
{

if (PORTD.F0==1  && PORTD.F1==1  ) // Internal tracks are operational. Hence incoming Train has to wait.
{ PORTB = 0x01;// Signal 1 is RED
PORTC= 0x04; // Signal 2 is GREEN
PORTA= 0x04; // Signal 3 is GREEN
delay(5);
 }
 if (PORTD.F0==1  && PORTD.F1==0  ) // Switching starts,  outward train has to switch to track 2.
{ PORTB = 0x04; // Signal 1 is GREEN
PORTC= 0x01; // Signal 2 is RED
PORTA= 0x01; // Signal 3 is RED
delay(5);

}

 }
 }
