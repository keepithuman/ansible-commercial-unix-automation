#!/usr/bin/ksh
# Check LPAR resource allocation

echo "=== LPAR Resource Check ==="
echo

echo "LPAR Information:"
lparstat -i | grep -E "Partition Name|Partition Number|Type|Mode|Entitled Capacity|Online Memory|Number Of Processors"

echo "\nCPU Resources:"
lparstat 1 5

echo "\nMemory Usage:"
svmon -G

echo "\nI/O Adapters:"
lsdev -Cc adapter | grep -v Defined

echo "\nHDisk Mapping:"
for disk in $(lspv | awk '{print $1}')
do
    echo "\nDisk: $disk"
    lsattr -El $disk | grep -E "pvid|size_in_mb"
done
