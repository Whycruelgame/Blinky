#define LED_PIN 5

void delay (unsigned int count)
{
    volatile unsigned int i;
    for(i = 0; i < count; i++)
    {

    }
}
void GPIO_Init(void){
  volatile unsigned int *RCC_APB2ENR = (volatile unsigned int *)0x40021018;
  //Enables GPIO Port A
  *RCC_APB2ENR |= (1 << 2);
  //Configures Port A pin 5 to be push or pull output, at 2 MHZ
  volatile unsigned int *GPIOA_CRL = (volatile unsigned int *)0x40010800;
  *GPIOA_CRL &= ~(0xF << 20);
  *GPIOA_CRL |= (0x2<< 20);
}
void toggleLED()
{
  //Address for GPIOA_ODR Which toggles high and low voltages for LED pin
  volatile unsigned int *GPIOA_ODR = (volatile unsigned int *)0x4001080C;
  *GPIOA_ODR ^= (0x1 << 5);

}
int main(void)
{
  GPIO_Init();
  while(1)
  {
    delay(500000);
    toggleLED();
    
  }
  return 0;
}


/*  Peripheral Clock Enable Register: RCC_APB2ENR
 *  0x40022000  - RCC Address
 *  0x18000000  - RCC_APB2ENR Address Offset
 *  0x58022000  - True RCC_APB2ENR Address
 *
 *  GPIO port mode reigster: 
 *  GPIO prot input data Register
 *  GPIO port output data register
 */
