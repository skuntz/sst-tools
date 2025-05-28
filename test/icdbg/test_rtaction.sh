#!/bin/bash

# Test custom interactive console

# Settings
CONFIG=igrid2d.py
CLOCK=300000
LIBPATH="../../sstcomp/icdbg"
OUTFILE="test.rtaction.out"
ACTION="icdbg.testrtaction"
PSTR="action"

# 1) Launch the program in the background, running long enough to send signal
if [[ -f $OUTFILE ]]; then
  rm $OUTFILE
fi

# TEST 1: repeat run until simulation complete  ----------------------------------
LAUNCH="sst --add-lib-path=$LIBPATH  --sigalrm='$ACTION(interval=1s)' $CONFIG -- --clocks=$CLOCK"

echo $LAUNCH
eval $LAUNCH > $OUTFILE

# 3) Wait for completion
wait
echo Custom Realtime Action Test Complete

# 4) Check results
retVal=$?
if [ $retVal -ne 0 ]; then
  echo "ERROR icdbg return code"
  exit $retVal
fi

grep "$PSTR" ./$OUTFILE > /dev/null
retVal=$?
if [ $retVal -ne 0 ]; then
  echo "ERROR grep: $PSTR"
  exit $retVal
fi
echo


echo "PASS"
exit $retVal
