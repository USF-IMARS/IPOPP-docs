These terms are subject to change in order to better comply with existing docs, but here is what I'm using for now:

**SPA** AKA **Station Package** refers to a collection of **Stations** found in the `~/drl/SPA/` directory. 

**Station** refers to the individual station within an **SPA** in the `/station/` directory within a **SPA**. Upon installation of the parent **SPA** a **station** will be found installed in `~/drl/ncs/stations/`. 

**Sub-station Programs** AKA **Algorithms** are programs that can be called from within **stations**' `.cfgfile` using `InitAlgorithm` to load the **algorithm** `installation.xml`. They are formally defined (in xml) in the **SPA**'s `/wrapper/` directory, and **algorithm** code is generally kept in the `/algorithm/` directory within the **SPA**.

For a visual summary see `IMARS-docs/IPOPP-station-flow-overview.png`

## SPA Directory Structure 
```
|- README.md
|- algorithm (algorithm code)
|    |-- docs
|    |-- run
|        |-- bin
|        |-- data
|        |-- scripts
|        |-- var
|- station (station definitions)
|     |-- Station1name
|     |   |--- station.cfgfile
|     |-- Station2name
|     |   |--- ... (see above)
|     |-- ...
|- wrapper (algorithm definitions)
|     |-- substationProgram1name
|     |   |--- generic.xml
|     |   |--- installation.xml
|     |   |--- run (duplicate)
|     |-- substationProgram2name
|     |   |--- ... (see above)
|     |-- ...
|     |-- lib (duplicate)
|- NISGSinstall.xml 
|- NISGSinstall.sh (duplicate)
```


## Station files:
Files defining a station (generally) reside within the `/SPA/my-spa-name/station/` directory. The name of the subdirectory should match the name of the station. Within this directory are the files:

1. `station.cfgfile` - file which defines the behavior of the station 
2. `station.cfgfile.xml` - ???

## Alrgorithms:
Within the `/SPA/my-spa-name/wrapper/` directory reside sub-station programs that are used by the stations. Files in a program dir are:

1. `generic.xml` - describes algorithm(s?) (like a prototype)
2. `installation.xml` - defines algorithm(s?), specifying their description (usually `generic.xml`) and  executable file(s?).
