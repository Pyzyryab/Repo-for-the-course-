    processor 6502
    seg code
    org $F000		; Define the code origin

Start:
    sei			; Disable interrupts
    cld			; Disable the BCD decimal math mode
    ldx #$FF		; Loads the X register with the decimal literal $FF
    txs			; Transfer the X register to the (S)tack pointer

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Clear the Page Zero region ($00 to $FF)
; Meaning the entire RAM and also the entire TIA registers
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    lda #0 		; A = 0
    ldx #$FF		; X = #$FF (will be used as the counter of the loop)

MemLoop:
    sta $0,X		; Store the value of A inside memory address $0 + X 
    dex			; X--
    bne MemLoop		; branch if not equuals to cero, go back to MemLoop

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Cleaning up
; Filling the ROM size to exactly 4KB
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    org $FFFC
    .word Start		; Reset vector at $FCCC (where the program starts)
    .word Start		; Interrupt vector at $FFFE (unused in the VCS)
