#!/bin/bash

# Test custom interactive console


# Settings
CLOCK=1060
LIBPATH="../../sstcomp/icdbg"
OUTFILE=test.icdbg.out
IC=icdbg.ICDebug

# 0) Set up the pipe
pipe=/tmp/icdbgpipe
if [[ ! -p $pipe ]]; then
  echo "Creating pipe: $pipe"
  mkfifo $pipe
fi

# 1) Launch the program in the background, running long enough to send signal
if [[ -f $OUTFILE ]]; then
  rm $OUTFILE
fi

# TEST 1: repeat run until simulation complete  ----------------------------------
LAUNCH="sst --add-lib-path=$LIBPATH --interactive-console=$IC --interactive-start=1us igrid2d.py"

echo $LAUNCH
$LAUNCH < $pipe > $OUTFILE &
exec 3>$pipe    # Opens pipe for writing
sleep 2


# 2) Send commands in interactive console
sleep 2
echo run > $pipe # runs to completion

# 3) Wait for completion
wait
exec 3>&- # close pipe
echo InteractiveConsole Break Test 1 Complete

# 4) Check results
retVal=$?
if [ $retVal -ne 0 ]; then
  echo "ERROR icdbg return code"
  exit $retVal
fi

echo "PASS"
exit $retVal
