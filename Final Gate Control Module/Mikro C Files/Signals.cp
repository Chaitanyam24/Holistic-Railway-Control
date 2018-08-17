#line 1 "C:/Users/ibm/Desktop/Final Gate Control Module/Mikro C Files/Signals.c"
 void delay(int k)
{
 int i,j;
 for (i=0;i<k;i++)
 {
 for (j=0;j<1000;j++);
 }
}



void main()

{short duty1 = 180;
ADCON1 = 0x86;
TRISD = 0xFF;
TRISC = 0x00;
TRISB = 0x00;
TRISA = 0xFF;
PWM1_Init(1000);
PWM1_Start();
PWM1_Set_Duty(duty1);



 while (1)
{
if (PORTA.F0==0 && PORTA.F1==1 )
{
if (PORTD.F0==1 && PORTD.F4==1 )
{ PORTC.F4=1;
 PORTC.F5=0;
 PORTC.F6=1;
 PORTC.F7=0;
 PORTB.F0=0;
 PORTB.F1=0;
 PORTB.F2=1;
 PORTB.F3=0;
 PORTB.F4=0;
 PORTB.F5=1;
 PORTB.F6=0;
 PORTB.F7=0;
 PORTC.F0=0;
 delay(5);
 }
 if (PORTD.F3==1 && PORTD.F1==1 )
 { PORTC.F4=0;
 PORTC.F5=1;
 PORTC.F6=0;
 PORTC.F7=1;
 PORTB.F0=1;
 PORTB.F1=0;
 PORTB.F2=0;
 PORTB.F3=1;
 PORTB.F4=0;
 PORTB.F5=0;
 PORTB.F6=0;
 PORTB.F7=0;
 PORTC.F0=0;

 delay(5);
 }
 if (PORTD.F6==1 )
 {
 PORTB.F0=0;
 PORTB.F1=0;
 PORTB.F2=0;
 PORTB.F3=1;
 PORTB.F4=0;
 PORTB.F5=0;
 PORTB.F6=1;
 PORTB.F7=0;
 PORTC.F0=0;
 delay(5);
 PORTC.F4=0;
 PORTC.F5=0;
 PORTC.F6=0;
 PORTC.F7=0;
 }

 if (PORTD.F7==1 )
 {
 PORTB.F0=0;
 PORTB.F1=0;
 PORTB.F2=0;
 PORTB.F3=0;
 PORTB.F4=0;
 PORTB.F5=1;
 PORTB.F6=0;
 PORTB.F7=0;
 PORTC.F0=1;
 delay(5);
 PORTC.F4=0;
 PORTC.F5=0;
 PORTC.F6=0;
 PORTC.F7=0;

 }
 }

 if (PORTA.F0==0 && PORTA.F1==0 )
 {
 if (PORTD.F0==1 )
 {
 PORTC.F4=1;
 PORTC.F5=0;
 PORTC.F6=1;
 PORTC.F7=0;
 PORTB.F0=0;
 PORTB.F1=0;
 PORTB.F2=1;
 PORTB.F3=0;
 PORTB.F4=0;
 PORTB.F5=0;
 PORTB.F6=0;
 PORTB.F7=0;
 PORTC.F0=0;

 delay(5);

 }


 }
 if (PORTA.F0==1 && PORTA.F1==1 )
 {
 if (PORTD.F6==1 )
 {

 PORTB.F0=1;
 PORTB.F1=0;
 PORTB.F2=0;
 PORTB.F3=1;
 PORTB.F4=0;
 PORTB.F5=0;
 PORTB.F6=1;
 PORTB.F7=0;
 PORTC.F0=0;
 delay(5);
 PORTC.F4=0;
 PORTC.F5=1;
 PORTC.F6=0;
 PORTC.F7=1;
 }
 }
#line 159 "C:/Users/ibm/Desktop/Final Gate Control Module/Mikro C Files/Signals.c"
 }
 }
