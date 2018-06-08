{
for (i=0;i<=100;i+= 10)
if (i <= $1 && $1 <= i+9) {d[i]++; break}
}
END {
for (i=0;i<=90;i+= 10)
{
percentage = d[i]/NR*100
t = 0
s = ""
while (t++ <= percentage) {s=s "*"}
printf "%2d - %2d: %3d%% %-100s\n", i, i+9, percentage, s
}
printf "%7s: %3d%% %-100s\n", "100",  d[100], s
}
