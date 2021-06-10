from math import *

bt_size = 16
a = .6073

def toHex(x):
    return hex(floor(x*2**8))

def toVal(x):
    return floor(x*2**8)

def toHex(val, nbits):
    val = toVal(val)
    return hex((val + (1 << nbits)) % (1 << nbits))

ang = 30

x = [1*2**8]
y = [0]

z = [floor(ang*2**8)]

t = [atan(2**(-i)) for i in range(bt_size)] # arco tangente de 1/2^i
t = [i*360/(2*pi) for i in t] # em graus
t = [floor(i*(2**8)) for i in t] # multiplica por 256

print(t)

##---------------------------------------
for i in range(bt_size):
    d = 1 if(z[-1] > 0) else -1

    z.append(z[-1] - d*t[i])

    x.append(x[-1] - (y[-1]*d)//(2**i))
    y.append(y[-1] + (x[-2]*d)//(2**i))


#print('cos', a*x[-1]/256)
#print('sin', a*y[-1]/256)

##---------------------------------------
'''
import numpy as np
from matplotlib import pyplot as plt

v = list(range(len(z)))
plt.plot(v,z,v,a*np.array(x),v,a*np.array(y))
plt.show()


for i in range(len(x)):
    vx = [0,x[i]]
    vy = [0,y[i]]

    plt.plot(vx,vy, label = str(i))

plt.legend()
plt.grid()
plt.show()
'''