import numpy as np

x = [[1,2,3],[4,5,6],[7,8,9]]
y = [[10,11,12],[13,14,15],[16,17,18]]
result = np.zeros([3,3])

for i in range(len(x)):
    for j in range(len(y[0])):
        for k in range(len(y)):
            result[i][j] +=  x[i][k] * y[k][j]

print(result)

print(np.dot(x,y))