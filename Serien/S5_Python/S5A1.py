import math 

# a)
x = [math.sqrt(i) for i in range(1, 101) if i % 2 == 0]

# b)
x[-1] *= math.pi 

# c)
x[-1] = math.ceil(x[-1])
y = x[-1]
print(y)

# Aufruf:
# python S5A1.py

# Ausgabe : 32
