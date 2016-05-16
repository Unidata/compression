# Private FP-based compression repository.

This repository contains the **not-yet-public** code for compression routines.  Moving here to make porting to windows easier.

> These libraries are meant to be used with the `compress` branch of netcdf-c.

# Contents

* zfp-0.2.1/	- zfp source directory
* fpzip-1.1.0/	- fpzip source directory.
* bzip2-1.0.6/	- bzip2 source directory.

Since szip and zip are already supported by HDF5,
they are not provided here.

# Building

Both automake and cmake build support is provided.

The relevant ./configure options are:

* --prefix=<install directory>
* --enable-all    Build all compression libraries.
* --enable-bzip2  Build bzip2 library.
* --enable-fpzip  Build fpzip library.
* --enable-zfp    Build zfp library.

Additionally, for fpzip only, it is possible to specify some
features to control its operation.

* --with-opt=FAST|SAFE|EMUL|INT   compression optimizations
* --with-output-buffer-size=<int> output Buffer Size (ideally the disk block size)
* --with-convert=UNION|CAST       bitwise type conversion mechanism to use

https://computation.llnl.gov/casc/fpzip/
https://computation.llnl.gov/casc/zfp/
