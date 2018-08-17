#line 1 "F:/Sem 7/BE.c"
void main()

{ short duty1 = 180;
TRISD = 0xFF;
TRISC = 0x00;
TRISB = 0x00;
TRISA = 0x00;
PWM1_Init(1000);
PWM1_Start();
PWM1_Set_Duty(duty1);


while (1)
{
if (PORTD.F2==1)
{ PORTB = 0x00;
}

if (PORTD.F2==0)
{ PORTB = 0x01;
}
if (PORTD.F3==1)
{ PORTA = 0x00;
}

if (PORTD.F3==0)
{ PORTA = 0x01;
}




} }
