{
for (i=0;i<=100;i+= 10)
if (i <= $1 && $1 <= i+9) {s[i]=s[i] "*"; break}
}
END {
for (i=0;i<=90;i+= 10)
{printf "%2d - %2d: %3d %-100s\n", i, i+9, length(s[i]), s[i]}
printf "%7s: %3d %-100s\n", "100",  length(s[i]), s[i]
}
