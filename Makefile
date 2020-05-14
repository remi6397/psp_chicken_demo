TARGET = ChickenDemo
OBJS = main.o game.o

INCDIR = $(CHICKEN_PSP_PATH)
CFLAGS = -O2 -G0 -Wall -Wl,-emain
CXXFLAGS = $(CFLAGS) -fno-exceptions -fno-rtti
ASFLAGS = $(CFLAGS)

LIBS = -lchicken -lm -lpspdebug

LIBDIR = $(CHICKEN_PSP_PATH)
LDFLAGS =

SCM_FILES = $(wildcard *.scm)
CSC_INTERMEDIATES = $(patsubst %.scm,%.c,$(SCM_FILES))
EXTRA_TARGETS = EBOOT.PBP $(CSC_INTERMEDIATES)
PSP_EBOOT_TITLE = ChickenDemo
PSP_FW_REVISION = 661

PSPSDK=$(shell psp-config --pspsdk-path)
include $(PSPSDK)/lib/build.mak

CSCFLAGS = $(addprefix -I,$(INCDIR))

%.o: %.scm
	csc $(CSCFLAGS) -cc psp-gcc -embedded -c -o $@ $<

.PHONY: $(CSC_INTERMEDIATES)