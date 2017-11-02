BRANDS=('福特' '别克' '奔驰' '宝马')
SERSES=('嘉年华' '凯越' '奔驰C级' '宝马5系')

declare -i n
n=${#BRANDS[@]}
n=$n-1
echo $n
for i in $(seq 0 $n); do

 b=${BRANDS[$i]}
 s=${SERSES[$i]}

 # do something....
 sh -x test.sh $b $s
done

