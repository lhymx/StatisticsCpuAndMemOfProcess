# StatisticsCpuAndMemOfProcess
统计进程CPU和内存的小脚本

# createCSV
该函数携带2个参数

1.进程名 processName

2.统计周期 cycle

该函数作用是根据进程名获取进程pid，然后使用top命令实时获取进程的CPU，内存信息，`cycle`则是统计周期，如0.5s获取一次数据
然后获取到的数据会统计到`/tmp/cpu_mem_${processName}.csv`中，导出后可以使用excel打开。然后使用excel的图表绘制功能，可以把数据的折线图直观显示出来。

# DEMO
```
main() {
  echo "DEMO START..."
  createCSV processName1 0.5 &
  createCSV processName2 0.5 &
}
main
```

# 其他
- 若是需要停止统计进程，则`ps -ef | grep scriptName`，然后使用`kill -9`将相关进程停止即可。
- 若想重新开始统计，则`rm -rf /tmp/cpu_mem_${processName}.csv`，统计进程会自动重新生成统计文件。
- 统计进程启动后如果被统计的进程没有启动，则会等待启动，被统计进程启动后会自动开始统计CPU和内存的占用率。
