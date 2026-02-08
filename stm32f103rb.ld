/*Entry Point for the linker(Mainly for tools like GDB & OpenOCD)*/
ENTRY(Reset_Handler)

/*Define Flash & RAM so that linker knows where to assign adresses for memory sections*/
MEMORY
{
  flash (rx) : org = 0x08000000, len = 128k /*From Memory Map/Data Sheet */
  ram (wx) : org = 0x20000000, len = 20k
}
_estack = ORIGIN(ram) + LENGTH(ram);

/*Define Sections*/
SECTIONS
{
  /*Places table of addresses for init stack pointer, reset handler, and interrupts.*/
  .isr_vector : /*Vector Table found in CPU documentation (ARM cortex m-3)*/
  {
    . = ALIGN(4);
    KEEP(*(.isr_vector))
    . = ALIGN(4);
  } >flash

  .text :/*Contains instructions (C code etc.)*/
  {
    . = ALIGN(4);
    *(.text)
    *(.text*)
  } >flash

  .data :/*Contains initialized variables.*/
  {
    . = ALIGN(4);
    _sdata = .;
    *(.data)
    *(.data*)
    . = ALIGN(4);
    _edata = .;
  } >ram AT> flash
    
    _sidata = LOADADDR(.data); /*Start of .data*/

  .bss :/*Contains uninitialized variables*/
  {
    _sbss = .;
    __bss_start__ = _sbss;
    *(.bss)
    *(.bss*)
    *(COMMON)

    _ebss = .;
    __bss_end__ = _ebss;
  } > ram
}
