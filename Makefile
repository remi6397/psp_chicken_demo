PSPSDK=$(shell psp-config --pspsdk-path)
PSPPATH=$(shell psp-config --pspdev-path)
PSPPREFIX=$(shell psp-config --psp-prefix)

TARGET = ChickenDemo
C_FILES    = main.c
SCM_FILES  = $(wildcard *.scm)
OBJS       =

C_PREFIX = psp
CSC      = $(C_PREFIX)csc
STRIP    = psp-strip
MKSFO    = mksfo
PACK_PBP = pack-pbp
FIXUP    = psp-fixup-imports
ENC      = PrxEncrypter

PSPSDK_LIBS = -lpspdebug -lpspdisplay -lpspge -lpspctrl -lpspsdk
LDFLAGS = $(LIBS)

C_INCDIR  = $(PSPPREFIX)/include/chicken
INCDIR = . $(PSPSDK)/include $(PSPPREFIX)/include $(C_INCDIR)
LIBDIR = . $(PSPSDK)/lib $(PSPPREFIX)/lib

CFLAGS   = -G0
CSCFLAGS = -O2 $(addprefix -I,$(INCDIR)) $(addprefix -L,$(LIBDIR)) $(addprefix -C ,$(CFLAGS)) $(addprefix -L ,$(LDFLAGS)) $(CSCEXTRAS)

PSP_FW_REVISION = 661
PSP_EBOOT_TITLE = ChickenDemo
PSP_EBOOT_SFO = PARAM.SFO
PSP_EBOOT_ICON = NULL
PSP_EBOOT_ICON1 = NULL
PSP_EBOOT_UNKPNG = NULL
PSP_EBOOT_PIC1 = NULL
PSP_EBOOT_SND0 = NULL
PSP_EBOOT_PSAR = NULL
PSP_EBOOT = EBOOT.PBP

all: $(EXTRA_TARGETS) $(PSP_EBOOT)

$(PSP_EBOOT_SFO):
	$(MKSFO) '$(PSP_EBOOT_TITLE)' $@

$(PSP_EBOOT): $(TARGET).elf $(PSP_EBOOT_SFO)
	$(STRIP) $(TARGET).elf -o $(TARGET)_strip.elf
	$(PACK_PBP) $(PSP_EBOOT) $(PSP_EBOOT_SFO) $(PSP_EBOOT_ICON)  \
		$(PSP_EBOOT_ICON1) $(PSP_EBOOT_UNKPNG) $(PSP_EBOOT_PIC1)  \
		$(PSP_EBOOT_SND0)  $(TARGET)_strip.elf $(PSP_EBOOT_PSAR)
	-rm -f $(TARGET)_strip.elf

$(TARGET).elf: $(C_FILES) $(SCM_FILES)
	$(CSC) -static -e -o $@ $^ $(CSCFLAGS)
	$(FIXUP) $@

EXTRA_CLEAN = $(SCM_FILES:.scm=.link)

clean:
	-rm -f $(TARGET)_strip.elf $(TARGET).elf $(TARGET).link $(EXTRA_CLEAN) $(PSP_EBOOT_SFO) $(PSP_EBOOT) $(EXTRA_TARGETS)

rebuild: clean all

.PHONY: all clean rebuild
