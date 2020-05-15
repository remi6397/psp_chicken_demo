PSP CHICKEN Scheme Demo
=======================

> Make PSP games in Scheme, just like Naughty Dog does!

Build
-----

1. Download and setup PSPSDK
2. Download and setup my [CHICKEN Scheme Port for PSP](https://github.com/remi6397/chicken-core-psp)
3. Issue the following commands in this directory:
   ```sh
   make rebuild
   # Test with PPSSPP - But beware! PPSSPP is capable of running severely broken PSP games that may not work or even crash on real hardware!
   ppsspp EBOOT.PBP
   ```

Status
------

No explicit invocations to gcc/ld are done in Makefile, only ``csc`` and ``psp-strip`` are called. ``psp-strip`` has to be called separately, as import fixup should be performed on an unstripped binary.
