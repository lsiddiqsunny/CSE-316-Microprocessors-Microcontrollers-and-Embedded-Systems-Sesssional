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

#include <util/delay.h>

unsigned char ch=0;



int main(void)
{
    /* Replace with your application code */
	DDRA=0b11111111;
	
	DDRB=0b00000000;
	PORTA=ch;

    while (1) 
    {
	//if(PINB&0b00001000){
	if(PINB& (1  << 3)){

	ch++;
	if(ch==16){
	ch=0;
	}
	PORTA=ch;
	_delay_ms(100);
	
	}
	if(PINB&0b00010000){
		if(ch==0){
		ch=16;
		}
		ch--;
		
		PORTA=ch;
		_delay_ms(100);
		
	}
		
    }
}

