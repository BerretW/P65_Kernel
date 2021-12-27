.include "macros_65C02.inc65"

.zeropage

.smart		on
.autoimport	on
.case		on
.debuginfo	on
.importzp	sp, sreg, regsave, regbank
.importzp	tmp1, tmp2, tmp3, tmp4, ptr1, ptr2, ptr3, ptr4,tmpstack
.macpack	longbranch

.export _INTE
.export _INTD
.export _str_to_out

.segment "CODE"

_INTE:  CLI
        RTS

_INTD:  SEI
        RTS


        _str_to_out:        SEI
                            PHA
                            PHY
                            sta ptr1
                            stx ptr1 + 1
                            ldy #0
        next_char:          lda (ptr1),y
                            beq eos
                            STA _OUTPUT,Y
                            INY
                            BNE next_char
        eos:	              PLY
        		                PLA
                            CLI
                            RTS
