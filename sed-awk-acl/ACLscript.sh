### defining constants
devs=5
projects=3
imanagers=3
analytics=4


### creating devs
for ((dev=1; dev<=$devs; dev++))
do
sudo useradd "R$dev"
done

### creating projects
for ((project=1; project<=$projects; project++))
do
sudo mkdir "/Proj$project"
sudo chmod o=x "/Proj$project"
done

### creating imanagers
for ((iman=1; iman<=$imanagers; iman++))
do
sudo useradd "I$iman"
done

### creating analytics
for ((anal=1; anal<=$analytics; anal++))
do
sudo useradd "A$anal"
done


### setting RW rights arrays
p1rw=(R2 R3 R5 A1)
p2rw=(R1 R5 A1)
p3rw=(R1 R2 R4 A2)

### setting R rights arrays
p1r=(A4)
p2r=(A2 A3)
p3r=(A1 A4)


### granting RW permissions for Proj1
for i in ${p1rw[*]}
do
sudo setfacl -m u:$i:rwx /Proj1
sudo setfacl -dm u:$i:rwx /Proj1
done

### granting RW permissions for Proj2
for i in ${p2rw[*]}
do
sudo setfacl -m u:$i:rwx /Proj2
sudo setfacl -dm u:$i:rwx /Proj2
done

### granting RW permissions for Proj3
for i in ${p3rw[*]}
do
sudo setfacl -m u:$i:rwx /Proj3
sudo setfacl -dm u:$i:rwx /Proj3
done


### granting R permissions for Proj1
for i in ${p1r[*]}
do
sudo setfacl -m u:$i:r-x /Proj1
sudo setfacl -dm u:$i:r-x /Proj1
done

### granting R permissions for Proj2
for i in ${p2r[*]}
do
sudo setfacl -m u:$i:r-x /Proj2
sudo setfacl -dm u:$i:r-x /Proj2
done

### granting R permissions for Proj3
for i in ${p3r[*]}
do
sudo setfacl -m u:$i:r-x /Proj3
sudo setfacl -dm u:$i:r-x /Proj3
done


## granting special permissions for iManagers
for ((iman=1; iman<=$imanagers; iman++))
do
# sudo chmod +t /Proj$i
sudo setfacl -m u:I$iman:-wx /Proj1
sudo setfacl -m u:I$iman:-wx /Proj2
sudo setfacl -m u:I$iman:-wx /Proj3
sudo setfacl -dm u:I$iman:-wx /Proj1
sudo setfacl -dm u:I$iman:-wx /Proj2
sudo setfacl -dm u:I$iman:-wx /Proj3
done
