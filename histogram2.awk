{
for (i=0;i<=100;i+= 10)
if (i <= $1 && $1 <= i+9) {f[i]++; break}
}
END {
for (i=0;i<=90;i+= 10)
{
percentage = f[i]/NR*100
t = 1
s = ""
while (t++ <= percentage) {s=s "*"}
printf "%2d - %2d: %5.2f%% %-100s\n", i, i+9, percentage, s
}
percentage = f[100]/NR*100
t = 1
s = ""
while (t++ <= percentage) {s=s "*"}
printf "%7s: %5.2f%% %-100s\n", "100",  percentage, s
}
