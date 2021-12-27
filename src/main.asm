.include "macros_65C02.inc65"
.setcpu		"65C02"
.smart		on
.autoimport	on
.case		on
.export _main




.segment "CODE"
.include "strings.h"

_main:              SEI
                    JSR _init_vec
                    JSR _vdp_init

                    lda #<s0
  	                ldx #>s0
                    ;JSR _str_to_out
                    LDA #$41
                    LDY #0
loop:               STA _OUTPUT,Y
                    ina
                    JMP loop
                    ;CLI
                    ;cli
main:               jmp main
