// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Fill.asm

// Runs an infinite loop that listens to the keyboard input.
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel;
// the screen should remain fully black as long as the key is pressed. 
// When no key is pressed, the program clears the screen, i.e. writes
// "white" in every pixel;
// the screen should remain fully clear as long as no key is pressed.

// Put your code here.

    @status
    M=-1    // set status black 0xFFFF
    D=0     // set argument for setscreen
    @SETSCREEN
    0;JMP

(LOOP)
    @KBD
    D=M     // D = pressing keyboard button character
    @SETSCREEN
    D;JEQ
    D=-1

(SETSCREEN)
    @ARG    // get the argument D
    M=D
    @status
    D=D-M   // D = D - status
    @LOOP
    D;JEQ   // if new status == old status

    @ARG
    D=M
    @status
    M=D     // status = ARG

    @SCREEN
    D=A     // D = SCREEN address
    @8192
    D=D+A   // D = the last SCREEN pixel address
    @i
    M=D     // i = D

(SETLOOP)
    @i
    D=M-1   // i = i - 1
    M=D
    @LOOP
    D;JLT   // if i < 0 then jump to LOOP

    @status
    D=M     // D = status
    @i
    A=M
    M=D     // set address i value to status
    @SETLOOP
    0;JMP