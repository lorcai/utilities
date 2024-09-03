# Just stock loops
##############################################################

# Create sample list to be iterated
# <manual>

# Delete empty lines just in case
sed -i '/^$/d' samplelist.txt

# Read into array
readarray -t samplelist < samplelist.txt 

##############################################################
# Reference: https://stackoverflow.com/questions/8880603/loop-through-an-array-of-strings-in-bash

# Basic
## declare an array variable
declare -a arr=("element1" "element2" "element3")

## now loop through the above array
for i in "${arr[@]}"
do
   echo "$i"
   echo ${arr[i]}
   echo "${arr[@]}"

   # or do whatever with individual element of the array
done

# You can access them using echo "${arr[0]}", "${arr[1]}" also
##############################################################

# Loop with counter
#!/bin/bash
## declare an array variable
declare -a array=("one" "two" "three")

# get length of an array
arraylength=${#array[@]}

# use for loop to read all values and indexes
for (( i=0; i<${arraylength}; i++ ));
do
  echo "index: $i, value: ${array[$i]}"
done
##############################################################

# Use
# Loop with counter
#!/bin/bash

## declare an array variable
readarray -t samplelist < samplelist.txt 

# get length of an array
arraylength=${#samplelist[@]}

# use for loop to read all values and indexes

for (( i=0; i<${#samplelist[@]}; i++ ));
do
  echo "index: $i, value: ${samplelist[$i]}"
done

# Note:
# Length of array:                   ${#samplelist[@]} 
# Lenght of string of the element 1: ${#samplelist[1]}
# Value of the element 1:            ${samplelist[1]}
#
##############################################################





