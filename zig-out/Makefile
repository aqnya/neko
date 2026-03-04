obj-m += neko.o
neko-y := stub.o neko_main.o

KDIR := $(KDIR)
MDIR := $(realpath $(dir $(abspath $(lastword $(MAKEFILE_LIST)))))
IDIR := $(MDIR)/include

all:
	make -C $(KDIR) M=$(MDIR) modules
clean:
	make -C $(KDIR) M=$(MDIR) clean
