import sys
from math import sqrt
args_count = len(sys.argv)

if args_count != 4:
    print('Please specify 3 parameters')
    sys.exit()

try:
    a = int(sys.argv[1])
    b = int(sys.argv[2])
    c = int(sys.argv[3])

    if (a + b > c) and (a + c > b) and (b + c > a):
        p = (a + b + c) / 2
        s = sqrt(p * (p - a) * (p - b) * (p - c))
        print("S = ", s)
    else:
        print('Impossible triangle, every side must be less than summ of 2 others')

except ValueError:
    print('Please type only integers!')

