AKA "How to convert an IPOPP SPA into a bash script" or "how to port IPOPP SPAs into another system"

This is a short explaination on how to manually trace through a single "Science Processing Alrgorithm" script.
We will go from the SPA files through to a single bash command that is executed on the worker.
Before starting look over [SPA terminology & basics](https://github.com/USF-IMARS/IPOPP-docs/blob/master/docs/SPAs-Stations-Algorithms.md).

## the bash command

To start you must identify the `cfgfile` of the individual "SPA" "station" you want to deconstruct.
We will start from this `station.cfgfile`:
1. Find the `<InitAlgorithm` element - this points to another xml file that will define the command, and loads the algorithm into a variable (usually called `cfg_algo.OBJ`). Later in this file `<RunAlgorithm` element calls the loaded algorithm.
2. from the install.xml file that was pointed to by `InitAlgorithm`, find the nearby `generic.xml`, which will include a `<Ncs_run` element with the `cmd` attribute set to a template of the actual command used.

## input filename(s)
1. within the `station.cfgfile` find a `<Dsm_command` element with the attribute `method="reserveProductLikeProductType"`. The first `<String` child element will have the `value` attribute set to an identifier key used by DSM to determine product types. It should look something like this: `<String value="imars.{sat}.{sensor}.{product_family}.mapped"/>`.
2. to find how this maps to files you will need to connect to the DSM database and execute the following SQL:

```mysql
# ==============================================================
# look up a product files (resources) from a DSM identier key
# ==============================================================
use DSM;
# find the product id_key you want from ProductTypes.name
select * from ProductTypes where name like "drl.%.modis.pds";
SET @id_key = "drl.aqua.modis.pds"; 

# find a product with the id_key and save the id
select * from Products where productType=@id_key;
SET @prod_id = 2;  # choose any product.id from the result

# use the id to lookup the resources
select * from Resources where product=@prod_id;
# ==============================================================
```

## output filename(s)
1. within `stationfile.cfgfile` find a `Dsm_command` element with `method="storeProduct"`. A `<String` child element should be found which gives the DSM identifier key for the output product.
2. from this string you can determine the input files from the DSM database using the same method as for input files.
