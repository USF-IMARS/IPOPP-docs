Sensitive information (for IMaRS members only) to go along with this wiki is in [these google docs](https://drive.google.com/drive/folders/0B87rlN3HaLtFQzhXZ0hqMmVaV3M?usp=sharing). If you have a question/concern, open an issue in [the issue tracker](https://github.com/USF-IMARS/IPOPP-docs/issues).


# General info:
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
