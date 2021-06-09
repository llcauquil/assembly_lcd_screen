// IO.c
// This software configures the switch and LED
// You are allowed to use any switch and any LED, 
// although the Lab suggests the SW1 switch PF4 and Red LED PF1
// Runs on LM4F120 or TM4C123
// Program written by: put your names here
// Date Created: 
// Last Modified:  
// Lab number: 6


#include "tm4c123gh6pm.h"
#include <stdint.h>

/*
#define SYSCTL_RCGCGPIO_R;

#define GPIO_PORTF_DATA_R (*((volatile uint32_t *)0xE000E018))
#define GPIO_PORTF_DIR_R (*((volatile uint32_t *)0xE000E018))
#define GPIO_PORTF_DEN_R (*((volatile uint32_t *)0xE000E018))
*/

#define PF2       	   (*((volatile uint32_t *)0x40025010))
#define PF4       	   (*((volatile uint32_t *)0x40025040))

//------------IO_Init------------
// Initialize GPIO Port for a switch and an LED
// Input: none
// Output: none
void IO_Init(void) {
 // --UUU-- Code to initialize PF4 and PF2
	
		volatile unsigned long delay;
		SYSCTL_RCGCGPIO_R |= 0X20; //0010 0000 WAKES UP PORT F
		//while((SYSCTL_PRGPIO_R&0X8) == 0){};
	
		delay=100;
		delay=100;
		delay=100;
		delay=100;
		delay=100;
	
		GPIO_PORTF_DIR_R |= 0x10;//0001 0000 MAKES PF4 OUTPUT
		GPIO_PORTF_DIR_R &= ~0x04;//0000 0100 MAKES PF2 INPUT
		
		
		GPIO_PORTF_DEN_R |= 0X14; //0001 0100 DIGITAL MAKER
		
		GPIO_PORTF_AFSEL_R &= ~0X14;
	
}

//------------IO_HeartBeat------------
// Toggle the output state of the  LED.
// Input: none
// Output: none
void IO_HeartBeat(void) {
 // --UUU-- PF2 is heartbeat
		GPIO_PORTF_DATA_R ^= 0x04;
}


//------------IO_Touch------------
// wait for release and press of the switch
// Delay to debounce the switch
// Input: none
// Output: none
void IO_Touch(void) {
 // --UUU-- wait for release; delay for 20ms; and then wait for press
	uint32_t i, x;
	x = 0x10;
	while(x==0x10){
		x = GPIO_PORTF_DATA_R;
		x &= 0x10;
		
	}
	
	for(i=0;i<1600000;i++){}
	
	while (x==0)
		x = GPIO_PORTF_DATA_R;
		x &= 0x10;	
}  

