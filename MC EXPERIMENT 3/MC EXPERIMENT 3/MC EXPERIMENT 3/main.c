/*
 * MC EXPERIMENT 3.c
 *
 * Created: 03-Jul-18 6:38:21 AM
 * Author : Latif Siddiq Suuny
 */ 
#ifndef F_CPU
#define F_CPU 16000000UL // 16 MHz clock speed
#endif
#define D4 eS_PORTD4
#define D5 eS_PORTD5
#define D6 eS_PORTD6
#define D7 eS_PORTD7
#define RS eS_PORTC6
#define EN eS_PORTC7

#include <avr/io.h>
#include <util/delay.h>
#include <string.h>
#include <stdlib.h>
#include "lcd.h"
void setADC(){

    ADMUX |=(1<<REFS0);
    ADCSRA |=(1<<ADEN)|(1<<ADATE)|(1<<ADPS0)|(1<<ADPS1)|(1<<ADPS2);
}

int main(void)
{
	DDRD = 0xFF;
	DDRC = 0xFF;
	//int i;
	Lcd4_Init();
	setADC();
	float voltage = 0;
	while(1)
	{
		/*Lcd4_Set_Cursor(1,1);
		Lcd4_Write_String("electroSome LCD Hello World");
		for(i=0;i<15;i++)
		{
			_delay_ms(500);
			Lcd4_Shift_Left();
		}
		for(i=0;i<15;i++)
		{
			_delay_ms(500);
			Lcd4_Shift_Right();
		}
		Lcd4_Clear();
		Lcd4_Set_Cursor(2,1);
		Lcd4_Write_Char('e');
		Lcd4_Write_Char('S');
		_delay_ms(2000);*/
		voltage = ADC/204.8*18;//ADC/18.618;
		char voltageshow[10];
		dtostrf(voltage, 5, 2, voltageshow);
		char s[]="Voltage: ";
		strcat(s,voltageshow);
		strcat(s,"v");
		Lcd4_Write_String(s);
		_delay_ms(1000);
		Lcd4_Clear();



	}
}