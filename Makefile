all: gblink2.gb

install: gblink2.gb
	ems-flasher --format
	ems-flasher --write $<

gblink2.o: symbols.bin font.bin

%.o: %.s
	rgbasm -o $@ $<

gblink2.gb: gblink2.o command-table.o
	rgblink -o $@ -n $(patsubst %.gb,%.sym,$@) $^
	rgbfix -v $@

clean:
	rm *.o *.sym

.PHONY: clean
