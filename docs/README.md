Sensitive information (for IMaRS members only) to go along with these docs are in [the IMaRS-docs/IPOPP page](https://github.com/USF-IMARS/IMaRS-docs/blob/master/docs/IPOPP/README.md). If you have a question/concern about the docs or IPOPP, open an issue in [the issue tracker](https://github.com/USF-IMARS/IPOPP-docs/issues).

For a brief summary of the software systems that comprise IPOPP see [systems.md](https://github.com/USF-IMARS/IPOPP-docs/blob/master/docs/systems.md).

# General info about IMaRS specifically:
* Sensors we're using : Modis & viirs 
* Satellites: Modis: aqua, terra; VIRS: npp
* Data is near-real-time. Estimated 4hrs delay. 
* Final products are: sea surface temperature (sst), ocean color (OC, NFLH), and true-color. View on website [here](http://data.imars.marine.usf.edu/#/modis/pass/1km/sst/gcoos/2017-02-12/2017-02-15).
* list of relevant abbreviations for reference [here](https://docs.google.com/spreadsheets/d/1rcN2Ay7TS0tPVdj14PRU8uwyfHEUCK5YTgbaSe5ScVo/edit?usp=sharing)

# Random, not-yet-placed tidbits:

* seadas has window redraw bug observed on lubuntu LXDE ((maybe) CentOS + gnome) | Solution (use joracle java, not openJDK): 

```
$ sudo add-apt-repository ppa:webupd8team/java
$ sudo apt-get update
$ sudo apt-get install oracle-java8-installer
$ sudo apt-get install oracle-java8-set-default
$ java -version 
```

* Oc and sst both start from same L0 files
* Step.esa setup:
    - wget http://step.esa.int/downloads/5.0/installers/esa-snap_sentinel_unix_5_0.sh

* "initial granule" is any granule without a granule in the 5min before (for more see imars_bin/querydb.py)

* the "published" field in ipopp means that the file has been transferred to the "final location" according to ipopp. Meaning it has been moved from the processing server to the DSM.

========================================

IPOPP controls the main satellite image processing pipeline.

* ipopp-installer/ipopp_monitors.sh contains a list of important ipopp scripts.

# Tools
## SLS console
`~/drl/nsls/bin/nsls_console.sh localhost:3500`
* Click box on left of error to show details.

## services.sh
`~/drl/tools/services.sh`
* [ stop || start || restart] services
* ~/drl/ncs/configs/default_config.file

## IPOPP Dashboard
`~/drl/tools/dashboard.sh`
* Layout is defined by ~drl/nsls/config/processingMonitor.xml (IMARS layout is @ ipopp-installer/processingMonitor.xml)

## MarkerManager 
`~drl/dsm/gui-scripts/markers.sh`
 * shows markers which have been reserved. IE what existing products have been marked for processing.
 * only shows one productType per station. If a station reserves multiple they will be hidden.
 * e.g. : `oc_png` produces both `imars.%.chlor_a.mapped.png` and `imars.%.nflh.mapped.png`, `img_publisher` tries to reserve them both, but only shows `imars.%.chlor_a.mapped.png` in MarkerManager

## PassManager
 `~drl/dsm/gui-scripts/passmanager.sh`
 * 

# Data
* Default values below can be changed in the IPOPP dataflow config: ~/drl/site.properties
* IPOPP default data output is something like:
    - ~/drl/data/pub/gsfcdata/*
        * Level 0-2. Level 0 is what we take in, 1 & 2 are intermediate products.
    - ~/drl/data/pub/data/*
        * Level 3 (final product) 
* IPOPP default Ingest data dir is 
    - ~/drl/data/dsm/nisfes_data
* Old default IPOPP port was 3306 (mysql std), new one: 3666
* can access db using:
    - mysql -P 3666 -u <USERNAME>
* Useful db management scripts are in ~/drl/dsm/database
* uses standalone mysql database in `~/drl/standalone`
    - cnf @ `~/drl/standalone/mysql.cnf`

# Stations
Each Station Directory has these files:
* cfgfile	-	XML-format file describing an NCS station actions,
* lockfile-	lock file to prevent multiple execution of NCS in a station,
* cmdfile	- polled file containing commands controlling station actions,
* logfile - holds log messages if NCS cannot contact NISGS Event Log Server.

# SPAs (Science Processing Algorithms)
* Gmt 
    - program does mercator projection and is old program from U of Hawaii


========================================
