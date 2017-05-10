# include/ice40.mk
# for verilog
# jcl/othinking/2017-01-31

# keep intermediates
#
.PRECIOUS: %.blif %.txt
.SUFFIXES: .v .blif .txt .bin .ex
%.blif: %.v
	yosys -q -p "synth_ice40 -blif $*.blif" $*.v
%.txt: %.blif %.pcf
	arachne-pnr -p $*.pcf $*.blif -o $*.txt
%.bin: %.txt
	icepack $*.txt $*.bin
%.ex: %.txt
	icebox_explain $*.txt > $*.ex

# end
