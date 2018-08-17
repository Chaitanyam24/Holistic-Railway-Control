#line 1 "C:/Users/User/Dropbox/Mini Project/BE Project/Signals/Micro C files/Signals.c"
 void delay(int k)
{
 int i,j;
 for (i=0;i<k;i++)
 {
 for (j=0;j<1000;j++);
 }
}



void main()

{ TRISD = 0xFF;
TRISC = 0x00;
TRISB = 0x00;
TRISA = 0x00;


 while (1)
{

if (PORTD.F0==1 && PORTD.F1==1 )
{ PORTB = 0x01;
PORTC= 0x04;
PORTA= 0x04;
delay(5);
 }
 if (PORTD.F0==1 && PORTD.F1==0 )
{ PORTB = 0x04;
PORTC= 0x01;
PORTA= 0x01;
delay(5);

}

 }
 }
