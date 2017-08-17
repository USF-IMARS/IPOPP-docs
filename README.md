# IPOPP-docs
NASA DRL's International Polar Orbiter Processing Package (IPOPP) is a collection of subsystems developed by NASA DRL which act as an ochestration framework for ingesting, processing, and publishing satellite imagery.

This repo houses public documentation and issue-tracking for the working collection of subsystems as maintained by the USF IMaRS group. Helpful raw files may also be stored here, but generally documentation will be in markdown format in the /docs directory and can be browsed from github directly. Remember that individual subsystems may have their own documentation and issue-tracking, this repo is the broad catch-all for when you're not sure or for getting a general overview.



Because the individual sub-systems of IPOPP are (somewhat) independent (hopefully more so in the future), we maintain these subsystems in individual repositories:

* IS - Information System (TODO)
* [DSM](https://github.com/USF-IMARS/dsm) - Data Storage Manager
* [NSLS](https://github.com/USF-IMARS/nsls) - Logging System 

It may be possible to package the subsystems into this repo using git sub-modules in the future, but I haven't gottent there yet.



USF IMaRS makes use of the following SPA packages within the IPOPP framework:

* [modisl1db](https://github.com/USF-IMARS/modisl1db)
* [seadas_spa](https://github.com/USF-IMARS/seadas_spa)
* [gmt](https://github.com/USF-IMARS/gmt)
* [CVIIRS-SPA](https://github.com/USF-IMARS/CVIIRS-SPA)
* [snap_spa](https://github.com/USF-IMARS/snap_spa)
* [imars_spa](https://github.com/USF-IMARS/imars)
* [h2g](https://github.com/USF-IMARS/h2g)
* [crefl](https://github.com/USF-IMARS/crefl)

A few additional tools we have developed:
* [imars_bin](https://github.com/USF-IMARS/imars_bin) is a collection of common scripts used by a couple of our SPA packages
* [RemoteDownlinks](https://github.com/USF-IMARS/RemoteDownlinks) is used to ingest raw satellite files over the internet from NASA rather than recieving them directly
* [ipopp-thumbs](https://github.com/USF-IMARS/ipopp-thumbs) is a little script to produce thumbnails from larger true-color pngs
* [StationTester](https://github.com/USF-IMARS/StationTester) is an attempt to implement a test-suite across SPAs. It also includes a script which reads your IPOPP configuration and produces a dependency graph to help track down pipeline issues.
* [ipopp-installer](https://github.com/USF-IMARS/ipopp-installer) was an attempt to script our IPOPP installation which was later replaced by use of puppet.

Lastly, please note that IMaRS is currently attempting to use puppet as a way to programatically deploy and configure IPOPP processing nodes. The [puppet-ipopp](https://github.com/USF-IMARS/puppet-ipopp) module works in conjunction with roles/profiles in [our puppet configuration](https://github.com/USF-IMARS/imars_puppet) to this end.
