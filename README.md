 # Implementation of GNU Sientific Library for EV6x Processors

## General
The implemententation is derived from [GSL](https://www.gnu.org/software/gsl)    
Version:  2.5  
Link to zip archive [gsl-2.5.tar.gz](http://mirror.tochlab.net/pub/gnu/gsl/gsl-2.5.tar.gz)  
Link to [GSL documentation](https://www.gnu.org/software/gsl//doc/html/)  
Current implementation is based on `ev_runtime` build framework  

## Pre-requisites

### Common tools
 1. RHEL6.6/CentOS 
 2. Metaware EV with nSIM64 
 3. gcc v6.2.0
 3. CMake v3.8 or higher
 3. Make v3.82 or higher

### ev_runtime  
 `gsl-for-synopsys` reuses the following components of `ev_runtime`:
 1. build framework
 2. HW configurations
 3. prebuilt libraries:  
    **mwlib**, **evthreads** and **crt**  
 
## Structure
The project contains libraries with test applications, example applications and configuration code  
The configuration code structure is similar to `ev_runtime` 
  
### 1. Libraries  
   The project includes a set of libraries. Each library has:
   1. separate folder  
   Ex: **blas**, **block** and so on
   2. C library code and C test application code
   3. build scripts  
   **Makefile**  
   **CMakeLists.txt**  
   **cmake/<library_name>.cmake** - CMake library package
   
   4. test part [optional] 
   C test code is usually placed in **test.c** file  
   build scripts are placed in **test** sub-folder like  
   **cblas/test/(Makefile and CMakeLists.txt)**  
   >Note: test application is not a library so it has no *.cmake    
   
### 2. Examples
   The project includes a set of examples.  
   1. Descriptions of all examples are located in one folder **doc**
   2. C code of all examples are located in sub-folder - **doc/examples**
   3. Reference outputs of all examples are located in sub-folder - **doc/examples**
   4. Each example has a sub-folder for build scripts like:  
   **doc/examples/blas/(Makefile and CMakeLists.txt)**

### 3. Configuration code  
   1. **config** folder   
   The folder contains general Make/CMake scripts for libraries, library tests and examples    
   2. **install** folder  
   It's generated during compilation. It is used for same purpose as `ev_runtime` **install** folder:    
   keeps C headers, built libraries and CMake packages         
   3. **include** folder  
   Extra CMake package. It is used to ensure consistency with `ev_runtime` code/build structure.    
   During compilation it collects all common C headers and places them into **install/include** folder
   4. top **Makefile** file  
   The file contains of all pre-requisites targets and general targets: **install/all/build/clean** for libraries, library tests and examples     
   5. **setup.sh**    
   The script initializes and checks the environment         
   usage: 
   ```
   source setup.sh
   ```
   or
   ```
   source setup.sh -check
   ```
   6. **README.md**   
   This file.  
   7. GSL original build system scripts
   Original GSL build system is based on Autoconf. There are a lot of configuration files with extensions `*.in`, `*.am`.  They are not used in this package and are left in the repo for information purpose  
   There are also several original BASH scripts which are not used.  

### 4. Design specific
   1. Environment variable `EV_GSL_HOME` should be set and point to top `gsl-for-synopsys` folder  
   2. C define `SYNOPSYS_ARC_HSEV` is used in patched code places  
   3. Inlining is activated. See `HAVE_INLINE` in **config/cmake/Modules/gsl.cmake**
   4. GSL float implementations  
      Different platforms could support `float` different ways. Function `gsl_ieee_set_mode()` is used for setup float.    
      Dummy function for ARC is placed here:  
      **/gsl-for-synopsys/ieee-utils/fp-arc_ev.c**
    
## Download, build and run 
   It is assumed that the developer already has pre-built `ev_runtime` with required HW configurations.  
### Download
```
   cd <your_dir>  
   git clone   git@github.com:foss-for-synopsys-dwc-arc-processors/gsl-for-synopsys.git
```   
### Init
```  
   cd gsl-for-synopsys  
   source ./setup.sh  [-check]
```   
### Build  
   \# Build and run system is same as in `ev_runtime`  
   \# Developers can use Makefile `install` target to build all libraries, tests and examples  
   \# parallel compilation is supported by `-jN` Makefile option,   
   \# where `N` is number of CPUs   
   \# Ex: build Linux native with Release on 8 cores    
   make install -j8 EVSS_CFG=ev_native EVSS_DBG=0  
   \# Ex: build ARC with Debug  
   make install -j8 EVSS_CFG=EV61_full_cnn880_demo_haps80_2.12a EVSS_DBG=1  
### Run  
#### Example. run `cblas` library test  
```
   cd gsl-for-synopsys/cblas/test  
   # you should see a folder like **build_ev_native_release**     
   ls  
   # run tests on Linux   
   make run EVSS_CFG=ev_native EVSS_DBG=0  
   # run tests on ARC nSIM    
   make run EVSS_CFG=EV61_full_cnn880_demo_haps80_2.12a EVSS_DBG=1  
   # run on HAPS  
   make haps-load haps-reset run EVSS_CFG=EV61_full_cnn880_demo_haps80_2.12a EVSS_DBG=1 HAPS=1  
```   
#### Example. Run `blas` example  
```
   cd gsl-for-synopsys/doc/examples/blas  
   make run EVSS_CFG=ev_native EVSS_DBG=0  
```   
   and same steps as described in `cblas` library test example above.
   

