
### creating working dir, which we will safely delete later
file="rand.txt"
dir="workdir_for_epam_sed_task_kirill_deyko"
mkdir $dir

### launching rand generator from the task...
awk '
BEGIN { for (i=1;i<200;i++)
print int (101*rand())
}' > $dir/$file

### working with range 0-9
sed -n "s/^[0-9]$/\*/p" $dir/$file > $dir/temp
sed -n -e "1 s/./ 0 -  9: /p" -e "$=" -e "$ a \ " -e "$ r $dir/temp" $dir/temp | sed ':a;N;$!ba;s/\n//g'

### working with ranges from 10 to 99
for N in {1..9}
do
sed -n "s/^$N[0-9]$/\*/p" $dir/$file > $dir/temp
sed -n -e "1 s/./"$N"0 - "$N"9: /p" -e "$=" -e "$ a \ " -e "$ r $dir/temp" $dir/temp | sed ':a;N;$!ba;s/\n//g'
done

### last: counting "100" matches
sed -n "s/100/\*/p" $dir/$file > $dir/temp
sed -n -e "1 s/./    100: /p" -e "1 a \ " -e "$=" -e "$ a \ " -e "$ r $dir/temp" $dir/temp | sed ':a;N;$!ba;s/\n//g'

### cleaning...
rm -r $dir
