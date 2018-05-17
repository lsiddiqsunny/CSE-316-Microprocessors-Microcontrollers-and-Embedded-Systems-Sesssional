/*
 * Experiment1.c
 *
 * Created: 15-May-18 1:27:22 AM
 * Author : Latif Siddiq Suuny
 */ 

#ifndef F_CPU
#define F_CPU 1000000
#endif
#include <avr/io.h>
#include <avr/interrupt.h>
#include <util/delay.h>

volatile unsigned char ch=0;

ISR(INT0_vect){
	ch++;
	if(ch==16){
	ch=0;
	}
	PORTA=ch;
	_delay_ms(500);	
	GIFR = 0xFF;
	
}

ISR(INT2_vect){
	if(ch==0){
		ch=16;
	}
	ch--;
	PORTA=ch;
	_delay_ms(500);
	GIFR = 0xFF;
	
}



int main(void)
{
    /* Replace with your application code */
	DDRA=0b00001111;
	PORTA=0;

	

	GICR=(GICR|0b01100000); //active INT2 AND INT0
	//MCUCR=(MCUCR&0b11110000); // Program INT1_vect for low state

	//MCUCR=(MCUCR&0b11111110); // Program INT0_vect for low state
	MCUCR=(MCUCR|(1<<1));
	//MCUCSR=(MCUCSR&0b10111111);  // Program INT2_vect for falling state
	sei();
    while (1) 
    {
		//_delay_ms(1000);
    }
}

