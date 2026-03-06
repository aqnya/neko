obj-m += neko_md.o
neko-y := stub.o neko.o

KDIR := $(KDIR)
MDIR := $(realpath $(dir $(abspath $(lastword $(MAKEFILE_LIST)))))
IDIR := $(MDIR)/include

all:
	make -C $(KDIR) M=$(MDIR) modules
clean:
	make -C $(KDIR) M=$(MDIR) clean
