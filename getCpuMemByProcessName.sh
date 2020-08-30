#!/bin/sh

createCSV() {
  if [ "$1" = "" ];then
    echo "First param input ProcessName"
    exit 1
  fi

  if [ "$2" = "" ];then
    echo "Second param input print cycle[0.5~10]"
    exit 1
  fi

  processName=$1
  cycle=$2

  while true; do
      if [ ! -f "/tmp/cpu_mem_${processName}.csv" ]; then
        touch /tmp/cpu_mem_${processName}.csv > /dev/null 2>&1
        chmod 777 /tmp/cpu_mem_${processName}.csv
        echo "TIME,CPU,MEM/M" > /tmp/cpu_mem_${processName}.csv
      fi

      processPid=$(ps -ef | grep $processName | grep -v grep | grep -v /bin/sh | awk '{print $2}')

      if [ $processPid = "" ]; then
        continue
      fi

      top -bn1 -n 1 -p $processPid | tail -1| awk '{now=strftime("%T",systime());print now,$9,$6/1024}' | sed 's/ /,/g' >> /tmp/cpu_mem_${processName}.csv
      sleep $cycle
  done
}

main() {
  echo "DEMO START..."
  createCSV processName1 0.5 &
  createCSV processName2 0.5 &
}
main
