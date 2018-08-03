/*
 * MC EXPERIMENT2.c
 *
 * Created: 22-May-18 9:26:21 PM
 * Author : Latif Siddiq Suuny
 */ 
#define F_CPU 1000000
#include <avr/io.h>
#include <util/delay.h>
/*
int Ground[8]={1,2,4,7,8,11,13,16};
int Power[8]={3,5,6,9,10,12,14,15};
*/

//I displayed 3 in this pattern,you can modify it according to you. 
int Pattern[8][8]={
				{0,1,1,1,1,1,1,0},
				{0,0,0,0,0,0,1,0},
				{0,0,0,0,0,0,1,0},
				{0,1,1,1,1,1,1,0},
				{0,1,1,1,1,1,1,0},
				{0,0,0,0,0,0,1,0},
				{0,0,0,0,0,0,1,0},
				{0,1,1,1,1,1,1,0}
				};



void static_display(){
   
   for(int i=0;i<8;i++){
		for(int j=0;j<8;j++){
			if(Pattern[i][j]){
			 
			   PORTA=1<<i;
			   PORTD=~(1<<j);
			   _delay_ms(.5);
			}
		}
   }
}
void blink_display(){
	for(int k=0;k<100;k++){ // to view the blink perfectly
	for(int i=0;i<8;i++){
		for(int j=0;j<8;j++){
			if(Pattern[i][j]){
				
				PORTA=1<<i;
				PORTD=~(1<<j);
				_delay_ms(.5);
			}
		}
	}}
	//_delay_ms(1000);
    //clearing the pattern
		  PORTA=0x00;
		  PORTD=0xFF;
	_delay_ms(500);
}

// l is for rotation direction. l=1 for left to right and l=-1 for right to left
void rotate_display(int l ){
	for(int k=0;k<8;k++){
	for(int l=0;l<50;l++){ // to have perfect view of rotation pattern,you can change it according to you
	for(int i=0;i<8;i++){
		for(int j=0;j<8;j++){
			if(Pattern[i][j]){
				PORTA=1<<i;
				int m;
                if(l==-1){
                m=(j-k)%8;
				if(m<0) m+=8;}
                else m=(j+k)%8;
				PORTD=~(1<<(m));
				_delay_ms(.5);
			}
		}
	}
	}
	}
//	_delay_ms(500);
}
int main(void)
{
    /* Replace with your application code */
	DDRA=0xFF;
	DDRD=0xFF;
	
	  PORTA=0x00;
	  PORTD=0xFF;
    while (1) 
    {	
	//static_display();
	//rotate_display(1);
	//blink_display();
	}
}

