#!/bin/bash
#EXT_TEST TEST_FILE_PARAM DEV
#EXT_TEST TEST_FILE_DESC "Tests interactive console shutdown command"
#EXT_TEST TIMEOUT 90
#
# 0) Set up pipe
# 1) launch the program in the background
# 2) issue commands in interactive consols
# 3) wait for completion
# 4) compare to expected results (offline?)
#set -m # enable job control

# Settings
IC=dbgsst15.ICDebugSST15
OUTFILE=test.ic.wp.out
REFFILE=test.ic.wp.ref
#CKPT="--checkpoint-simulation-period=12us"
CKPT=""
TEST="Test IC watch commands - complete"

# 0) Set up the pipe
pipe=/tmp/unsignedSetpipe
#mkfifo $pipe
if [[ ! -p $pipe ]]; then
  echo "Creating pipe: $pipe"
  mkfifo $pipe
fi


# 1) Launch the program in the background, running long enough to send signal
LAUNCH="sst --interactive-console=$IC --interactive-start=0 $CKPT dbgsst15.py"
echo $LAUNCH
$LAUNCH < $pipe > $OUTFILE &
exec 3>$pipe    # Opens pipe for writing

# 2) Send commands in interactive console
echo "cd cp0" > $pipe
echo "ls" > $pipe
echo "watch size > 0" > $pipe 
echo "run" > $pipe
echo "unwatch 0" > $pipe
echo "watch size changed" > $pipe
echo "run" > $pipe
echo "unwatch 0" > $pipe
echo "watch size > minData" > $pipe
echo "run" > $pipe
echo "unwatch 0" > $pipe
echo "watch size > minData && size < maxData || rCheck changed" > $pipe
echo "run" > $pipe
echo "shutdown" > $pipe

# 5) Wait for completion
wait
retVal=$?
exec 3>&- # close pipe
echo $TEST

# 6) Check results
if [ $retVal -ne 0 ]; then
  echo "ERROR: return code"
  rm $pipe
  exit $retVal
fi

# Grep for expected value
#grepstr="1 = 1235 (unsigned int)"
#retVal=$?
#if [ $retVal -ne 0 ]; then
#  echo "ERROR objmap unsignedSet grep $grepstr "
#  rm $pipe
#  exit $grepVal
#fi

diff $OUTFILE $REFFILE
retVal=$?
if [ $retVal -ne 0 ]; then
  echo "ERROR: diff with reference file"
  rm $pipe
  exit $retVal
fi


echo

# Cleanup output directories
#rm $OUTFILE
rm $pipe


echo "PASS"
exit $retVal







