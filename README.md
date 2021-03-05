# RTOS Project
This project is inspired by a book titled [임베디드 OS 개발 프로젝트](http://www.yes24.com/Product/Goods/84909414) by 이만우. The goal is to design RTOS(Real-Time OS) used in ARM embedded machines. It would be checked in the QEMU environment. It features bootloader, exception handler, interrupt handler, task control block, scheduler, event handler, messaging, and synchronization. <br><br>

# Machine Spec
* Target board : ```RealView PB-A8```
* Architecture : ```ARMv7-A```
* CPU          : ```ARM Cortex-A8```
* number of cores    : ```1```
* Baseboard layout : [Arm developer link](https://developer.arm.com/documentation/dui0417/d/hardware-description/pb-a8-architecture)<br><br>

# Environment
* Cross-compiler : ```gcc-arm-none-eabi```
* Debuger : ```gdb-multiarch```
* Emulator : ```gemu-system-arm```<br><br>


# Features
* Bootloader
* Exception handler 
* Interrupt handler 
* Task control block
* Scheduler
* Event handler 
* Messaging
* Synchronization <br><br>


# Run

build
```
make all
```

debug mode
```
make debug 
make gdb
```

Run
```
make run
qemu exit keys: ctr+A, x
```
