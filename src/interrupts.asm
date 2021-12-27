.include "P65.inc65"

.setcpu		"65C02"
.smart		on
.autoimport	on
.case		on

.export _IRQ_ISR
.export _NMI_ISR
.export _init_vec
.export _nmi_int
.export _irq_int

.globalzp tmpstack, out_ptr
.export _OUTPUT, _INPUT

.segment "ZEROPAGE"
tmpstack: .res 2
out_ptr: .res 1

.segment "CODE"
; ---------------------------------------------------------------------------
; Non-maskable interrupt (NMI) service routine

_nmi_int:     JMP (_nmi_vec)


; ---------------------------------------------------------------------------
; Maskable interrupt (IRQ) service routine
_irq_int:     JMP (_irq_vec)



_print:             LDY #0
@print:             LDA _OUTPUT,Y
                    BEQ @end

                    JSR gr_put_byte
                    LDA #0
                    STA _OUTPUT,Y
                    INY
                    BNE @print
@end:               RTS

_NMI_ISR:
                    PHA
                    PHX
                    PHY
                    ;JSR _NMI_Event
                    ;LDA #$4D
                    ;STA VIA2_T1C_H
@end:
                    PLY
                    PLX
                    PLA
                    RTI


_IRQ_ISR:
                    SEI
                    ;PHA
                    ;PHX
                    ;PHY
                    ;LDA #$FF
                    ;STA VIA1_T1C_H
                    ;JSR _IRQ_Event
                    ;BRK

                    JSR _print
                    CLI
                    ;PLY
                    ;PLX
                    ;PLA
                    RTI

_init_vec:          JSR _init_buffers
                    STZ out_ptr
                    LDA #<_IRQ_ISR
                    STA _irq_vec
                    LDA #>_IRQ_ISR
                    STA _irq_vec + 1
                    LDA #<_NMI_ISR
                    STA _nmi_vec
                    LDA #>_NMI_ISR
                    STA _nmi_vec + 1
                    RTS
_init_buffers:
                    LDY #0
@init_1:            LDA #0
                    STA _OUTPUT,Y
                    STA _INPUT,Y
                    INY
                    BNE @init_1
                    RTS
