// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Mult.asm

// Multiplies R0 and R1 and stores the result in R2.
// (R0, R1, R2 refer to RAM[0], RAM[1], and RAM[2], respectively.)

// Put your code here.

    @R2
    M=0     // set R2 = 0
    @i
    M=0     // set i = 0
(LOOP)
    @i
    D=M     // set D = i
    @R0
    D=D-M   // D = i - R0
    @LOOP_END
    D;JEQ   // if D >= 0 jump to end
    
    @R1
    D=M     // set D = R1
    @R2
    M=D+M   // set M = D + R2
    @i
    M=M+1   // i=i+1
    @LOOP
    0;JMP
(LOOP_END)
    @LOOP_END
    0;JMP