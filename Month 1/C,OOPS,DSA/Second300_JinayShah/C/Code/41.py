def lis(arr):
   n = len(arr)
   lis = [1]*n
   for i in range(1, n):
       for j in range(0, i):
           if arr[i] > arr[j] and lis[i] < lis[j] + 1:
               lis[i] = lis[j] + 1
   maximum = max(lis)
   return maximum
print("Length of lis is", lis([10, 22, 9, 33, 21, 50, 41, 60]))