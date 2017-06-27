A number of different systems work together to comprise the IPOPP stack. Some of these systems can be run on different machines and be made to work together. A summary of the key systems (as far as I know):

1. NCS - "Control system". Orchestration framework which monitors & manages the running of IPOPP station algorithms.
2. [DSM](https://github.com/USF-IMARS/dsm) - "Data System Manger" which manages the actual data products and thier corresponding mysql entries. 
3. IS - "Information System" which manages non-data-product information while IPOPP is running. 
4. [NSLS](https://github.com/USF-IMARS/nsls) - "Logger System" used by IPOPP so one machine can be used to monitor logs across multiple slave machines.

The above systems are packages with the ipopp installer, but IMaRS maintains separate distributions as github repositories (linked above) to support active development.

The arrangement of these systems at IMaRS is using a slave-master paradigm, wherein one master machine runs the DSM, IS, and NCLS systems, and multiple slaves are used as processors running NCS. The master may also run an instance of NCS so that it may also perform processing. 

The following diagram outlines the general flow of information between the systems (although I'm not sure what version of IPOPP this diagram is from)

![overview](https://github.com/USF-IMARS/IPOPP-docs/blob/master/docs/figures/systems-overview.png?raw=true)

