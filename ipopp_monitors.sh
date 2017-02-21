#!/bin/bash
~/drl/nsls/bin/nsls-console.sh localhost:3500 &
~/drl/dsm/gui-scripts/markers.sh &
~/drl/dsm/gui-scripts/passmanager.sh &
~/drl/tools/dashboard.sh &
