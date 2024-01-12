class Hash:
    def __init__(self,key,value):
        self.key = key
        self.value = value
        self.next = None

    def insert(self,key,value):
        pass

inputs = list(map(int,input().split()))
hashTable = Hash()
for i in range(len(inputs)):
    hashTable.insert(inputs[i])