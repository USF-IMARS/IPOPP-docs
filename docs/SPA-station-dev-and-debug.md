# Workflow

1. modify post-install SPA Station .cfgfile in `~/drl/ncs/stations/{stationName}/` (to avoid affecting other servers using shared SPA dir)
2. restart station to test manually
3. `cp ~/drl/ncs/stations/{stationName}/station.cfgfile ~/drl/SPA/{SPAName}/station/{stationName}/.` (!this modifies file in shared SPA dir!)
4. check SPA test suite passes
5. `git commit` changes
6. reinstall station


# Debugging SPAs
* SPA not running? Don't worry, it's probably just failing silently! ;)
* locate all extant FAIL logs: `find /home/ipopp/drl/ncs/stations/* -name *FAIL*`
* also see Appendix H of IPOPP Users Guide (v2.5) "Diagnosing and Recovering from IPOPP Operational Errors"
* `drl/ncs/stations/<SPA service name>/jsw/bin/wrapper.sh console` useful for debugging SPAs or `start`ing a particular SPA. 
    - from the console copy any commands from `cmd = <COMMAND_IS_HERE>` and paste them into shell to look for errors.  
    - to re-run a failed marker, open markers.sh and delete the failed marker. It should re-run automatically.
        * if it does not, try deleting the last initial granule (last :00 or :30 min pass)
* Failed SPA logs go to drl/ncs/stations/<SPA service name>/FAIL*
    - use `grep -R '' ~/drl/ncs/stations/<SERVICENAME>/FAIL*` to list all lines in all files in fail dir.
* Do not assume that SPAs are independent. Installation of one can affect the others. For instance, installing gbad will break modisl1db.l0l1aqua and you will need to re-copy modisl1db from your original source.
* SPA stopped @ `Object found in pool: DSM = gov.nasa.gsfc.nisgs.dsm.DSM@1a327280` in console? This means it is waiting for prerequisite product(s). Working as intended.
* Trouble interacting with the database? eg: `NCS Error Exception  Command Error` when storing products. Check database logs (must be root) `USE mysql; SELECT * FROM general_log ORDER BY event_time DESC;` to find the time around your error. 
    - special case of this is `INSERT INTO MappedProducts...` error. Observed with `modis_mercator_sst`. To fix this use `IMARS-docs/createMappedProducts.mysql` to create the MappedProducts table.
        * As far as I can tell, this traces back to `SELECT Products.id,Products.subproduct FROM Products...` in  `dsm.jar/GCDatabase.class`
* SPA shows as `OFF` in dashboard, but is actually running. 
    - this can happen when SPA runs very quickly; it is not a problem.
    - observed on gmt/modis_mercator_sst, (imars) modis_cloud_filter

## modis_mapping_sst
* `ImportError: libmysqlclient.so.18: cannot open shared object file: No such file or directory`
    - try reinstalling MySQL-python with package installer
        * `sudo apt-get install python-mysqldb`
* `Can't connect to local MySQL server...`
    - lib might not be able to find right socket file
    - can pass socket file directly
    - or symlink to standalone ipopp mysql
        * `sudo mkdir /var/run/mysqld`
        * `sudo ln -s /home/<USERNAME>/drl/standalone/mysql.sock /var/run/mysqld/mysqld.sock`
* error not uncovered by running commands from `wrapper.sh console`, but `Method invocation returned error` in nsls console, and `ncs/stations/<station>/FAIL*/mosaic_errfile` contains `cannot create /.install4j: Permission denied`
    - `/.install4j` is not a breaking error, but to resolve it do:
    - `sudo touch /.install4j`
    - `sudo chown <USERNAME> /.install4j`
    - `sudo chmod 644 /.install4j`


# Troubleshooting
## Errors:
* ERROR 2003 (HY000): Can't connect to MySQL server on 'localhost' (111 "Connection refused")
    - May be caused by corrupted database 
    - Eg from ctrl+c in middle of a restart_ipopp.sh (DONT DO THIS)

## Warnings: 
* IS/retriever “No remote FTP files in dir: ancillary/*
    - This is because nasa recently changed their protocol from http to https. And they did not update their software. Solution in this gist.
    -Could also be that ancillary files are not published yet.
* Cloud filter : Parameter output_file: ~/drl/data/pub/gsfcdata/terra/modis/level2/terra.SST.FILTERED.16047230000.hdf does not exist
    - probably missing python dependency
* "Not the initial granule" - "initial granule" is first file in 30min set of files. This file is used to help process the other files in each 30min chunk.
