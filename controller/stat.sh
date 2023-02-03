

echo "##############superpi/singlecore_test "
cat superpi/singlecore_test.log | awk -F 'm|s' '{print $2}' | awk '{sum += $1} END {printf "NR = %d,Average = %3.3f\n",NR,sum/NR}'
echo "##############superpi/multicore_test "
cat superpi/multicore_test.log | awk -F 'm|s' '{print $2}' | awk '{sum += $1} END {printf "NR = %d,Average = %3.3f\n",NR,sum/NR}'

echo "##############unix_bench/singlecore_test"
cat unix_bench/singlecore_test.log | grep 'System Benchmarks Index Score' | awk '{sum += $5} END {printf "NR = %d,Average = %3.3f\n",NR,sum/NR}'
echo "##############unix_bench/multicore_test"
cat unix_bench/multicore_test.log | grep 'System Benchmarks Index Score' | awk '{sum += $5} END {printf "NR = %d,Average = %3.3f\n",NR,sum/NR}' 

echo "##############stream"
cat stream/stream.log | grep ":"

echo "##############mlc"
cat mlc/mlc.log | grep -w 'frequency'

echo "##############fio"
cat fio/fio.log | grep -E -w 'IOPS|io'