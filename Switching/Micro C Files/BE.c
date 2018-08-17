void main()

{ short duty1 = 180; //Initial value for duty
TRISD = 0xFF; //PORTD as input
TRISC = 0x00; //PORTC as output
TRISB = 0x00; //PORTB as output
TRISA = 0x00; //PORTA as output
PWM1_Init(1000); //Initialize PWM1
PWM1_Start(); //start PWM1
PWM1_Set_Duty(duty1); //Set current duty for PWM1


while (1) //Endless loop
{
if (PORTD.F2==1)
{ PORTB = 0x00; //Stop the motor
}

if (PORTD.F2==0)
{ PORTB = 0x01; //Run motor in clockwise
}
if (PORTD.F3==1)
{ PORTA = 0x00; //Stop the motor
}

if (PORTD.F3==0)
{ PORTA = 0x01; //Run motor in clockwise
}




} }