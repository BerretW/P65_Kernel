
.setcpu		"65C02"
.smart		on
.autoimport	on
.case		on

.segment  "VECTORS"

.addr      _nmi_int    ; NMI vector
.addr      _init     ; Reset vector
.addr      _irq_int    ; IRQ/BRK vector
