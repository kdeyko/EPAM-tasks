### Our rand numbers are now saved in 'rand_nums_for_epam_sed_task_kirill_deyko.txt' file
### The file name is so long and ugly because we want to make sure that it wasn't exist before
### We will work with it from now on

### creating working dir, which we will safely delete later
file="rand_nums_for_epam_sed_task_kirill_deyko.txt"
dir="workdir_for_epam_sed_task"
mkdir $dir
mv $file $dir

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
