# UVM_RAL_DPI_C_Example
C/C++ UVM Test Sequence Example With RAL. [AMD (Xilinx) Vivado Simulator](https://www.xilinx.com/support/download/index.html/content/xilinx/en/downloadNav/vivado-design-tools.html) (xsim) and [Metrics DSim Desktop](https://www.metrics.ca/) (dsim) are supported.

## Usage
To Compile and Run Test<BR>
```% make```

To Clean<BR>
```% make clean```

dsim is automatically used if it is installed and properly setup on your terminal. xsim is used otherwise.

You can edit dsim.mk and/or xsim.mk to accommodate your environment like tool version, path,etc.

For manual simulator selection.<BR>
```% make dsim_<command>```<BR>
```% make xsim_<command>```<BR>

Alternatively,<BR>
```% make -f dsim.mk <command>```<BR>
```% make -f xsim.mk <command>```<BR>
