# NISGS Control System (NCS)

See also docs at `~/drl/ncs/doc`.

## Commands Not found in the Reference 

### Ncs_copy
(maybe?) Copies an object in the IPOPP JVM from `source` to `copy`.

Examples:
```xml
# imars/img_publisher:
<Ncs_copy copy="imars.{sat}.{sensor}.{product}.mapped.png.OBJ" source="cfg_wild.OBJ"/>

# modisl1db/l1atob:
<!--And put the product object where it belongs-->
<Ncs_log text="Putting reserved object where it belongs"/>
<Ncs_copy copy="drl.{sat}.modis.mxd01.OBJ" source="cfg_wild.OBJ"/>
<!-- Put the reserved product object into "reservedProduct" -->
<!-- (so NCS can find it to fail this job if needed) -->
<Ncs_copy copy="reservedProduct" source="drl.{sat}.modis.mxd01.OBJ"/>
#...
<!-- clean everything up - walk the outputs
     creating new Products, decorating them with Resources,
     and Ancillaries, and Storing them  -->
<Ncs_copy copy="drl.{sat}.modis.mxd021km" source="modis.mxd021km"/>
<Ncs_copy copy="drl.{sat}.modis.mxd02hkm" source="modis.mxd02hkm"/>
<Ncs_copy copy="drl.{sat}.modis.mxd02qkm" source="modis.mxd02qkm"/>
```

### Breakpoint
Setting a breakpoint is as easy as crashing the whole thing! ;)
```xml
    <Ncs_log text="{any_undefined_variable_name_here}"/>
```

## Useful Station Information in the .cfgfile

```xml
    <SETUP>
        <!-- names (first 4 are required by DSM)-->
        <Ncs_set name="cfg_stationName" value="imars_img_publisher"/>
        <Ncs_set name="cfg_groupTag" value="imars_img_publisher"/>
        <Ncs_set name="cfg_siteName" value="{NISGS_SITE_NAME}"/>
        <Ncs_set name="dataDirectory" value="{DSM_DATA_DIRECTORY}"/>
        <Ncs_set name="version" value="ImgPublisher"/>

        <!-- log info -->
        <Ncs_set name="cfg_stationLog" value="station.stationlog"/>
        <!--  Initialize wrapped algorithm   -->

        <!-- algorithm(s) info -->
        <InitAlgorithm debug="{cfg_debug}"
          file="{cfg_nisgs_home}/SPA/imars/wrapper/img_publisher/installation.xml" result="cfg_algo.OBJ"/>
    </SETUP>
    <EXECUTE>
        <!-- ### INFLOWS ###
        <!-- reserved products: (station inflow (can only be one?)) -->
        <Dsm_command class="DSM" debug="{cfg_debug}"
            method="reserveProductLikeProductType" result="cfg_wild.OBJ">
            <String value="imars.%.mapped.png"/>
            <String value="imars.%.mapped"/>
        </Dsm_command>

        <!-- release reserved products (at END of file) -->
        <Ncs_log text="Releasing reserved product drl.aqua.modis.pds"/>
        <Dsm_command class="DSM" debug="{cfg_debug}" method="releaseProduct">
          <Object value="cfg_wild.OBJ"/>
        </Dsm_command>
        


        <!-- ### OUTFLOWS ###
        <!-- create new product: (outflow(s)) -->
        <Dsm_command class="Product" debug="{cfg_debug}" method="new"
          result="drl.aqua.modis.mxd01.OBJ" runFlag="true">
          <Object value="drl.aqua.modis.pds.OBJ"/>
          <String value="drl.aqua.modis.mxd01"/>
        </Dsm_command>

        <!-- set attribs of new product -->
        <!-- algorithm used to generate: -->
        <Dsm_command class="drl.aqua.modis.mxd01.OBJ" debug="{cfg_debug}"
          method="setAlgorithm" runFlag="true">
          <String value="Mod L1A Aqua"/>
          <String value="{version}"/>
        </Dsm_command>
        <!-- Add file {drl.aqua.modis.mxd01} as DATA resource -->
        <Dsm_command class="DSM" debug="{cfg_debug}"
          method="addDataResource" runFlag="true">
          <Object value="drl.aqua.modis.mxd01.OBJ"/>
          <String value="{drl.aqua.modis.mxd01}"/>
        </Dsm_command>
        <!-- Add contributing resource ancillary drl.leapsec (file {leapsec}) -->
        <Dsm_command class="drl.aqua.modis.mxd01.OBJ" debug="{cfg_debug}"
          method="addContributingResource" runFlag="true">
          <String value="{leapsec}"/>
          <String value=" "/>
        </Dsm_command>

        <!-- Storing product drl.aqua.modis.mxd01 -->
        <!-- register crefl with DSM  -->
        <Dsm_command class="DSM" debug="{cfg_debug}" method="storeProduct" runFlag="true">
          <Object value="drl.aqua.modis.mxd01.OBJ"/>
        </Dsm_command>

    </EXECUTE>
```
