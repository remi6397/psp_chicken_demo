PSP CHICKEN Scheme Demo
=======================

Make PSP games in Scheme, just like Naughty Dog does!

Build
-----

1. Download and setup PSPSDK
2. Download and setup my [CHICKEN port for PSP](https://github.com/remi6397/chicken-core-psp)
3. Issue the following commands:
   ```sh
   make clean && make CHICKEN_PSP_PATH=../chicken-core-psp
   ```
   Replace ``../chicken-core-psp`` with the actual directory you setup libchicken.a in.

Status
------

I should consult whether intercepting ``.o`` files from ``csc`` and then linking them with ``psp-gcc`` is appropriate in my case. The optimal way would be to use ``csc`` throughout the whole compilation process with ``-host`` flag if possible at all.