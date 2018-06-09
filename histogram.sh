### Our rand numbers are now saved in 'rand_nums_for_epam_sed_task_kirill_deyko.txt' file
### The file name is so long and ugly because we want to make sure that it wasn't exist before
### We will work with it from now on

### creating working dir, which we will safely delete later
file="rand_nums_for_epam_sed_task_kirill_deyko.txt"
dir="workdir_for_epam_sed_task"
mkdir $dir
mv $file $dir

### collecting temp files




### working with range 0 - 9
sed -n "s/^[0-9]$/\*/p" $dir/$file > $dir/temp
sed -n '{
$ i\
 0 -  9: 
$ =
$ i \
 
$ r $dir/temp
}' $dir/temp | sed ':a;N;$!ba;s/\n//g'


### working with range 10 - 19
sed -n "s/^1[0-9]$/\*/p" $dir/$file > $dir/temp
sed -n '{
$ i\
10 - 19: 
$ =
$ i \
 
$ r $dir/temp
}' $dir/temp | sed ':a;N;$!ba;s/\n//g'


### last: counting "100" matches
sed -n "s/100/\*/p" $dir/$file > $dir/temp
sed -n '{
$ i\
    100: 
$ =
$ i \
 
$ r $dir/temp
}' $dir/temp | sed ':a;N;$!ba;s/\n//g'


### cleaning...
rm -rf $dir
