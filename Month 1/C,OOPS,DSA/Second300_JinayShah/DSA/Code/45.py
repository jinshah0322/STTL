from collections import defaultdict

class Graph:

	def __init__(self, vertices):
		self.V = vertices 
		self.graph = defaultdict(list) 

	
	def addEdge(self, u, v):
		self.graph[u].append(v)
		self.graph[v].append(u)

	
	def DFSUtil(self, v, visited):
		
		visited[v] = True

		
		for i in self.graph[v]:
			if visited[i] == False:
				self.DFSUtil(i, visited)

	'''Method to check if all non-zero degree vertices are
	connected. It mainly does DFS traversal starting from 
	node with non-zero degree'''

	def isConnected(self):

		
		visited = [False]*(self.V)

		
		for i in range(self.V):
			if len(self.graph[i]) != 0:
				break

		
		if i == self.V-1:
			return True

		
		self.DFSUtil(i, visited)

		
		for i in range(self.V):
			if visited[i] == False and len(self.graph[i]) > 0:
				return False

		return True

	'''The function returns one of the following values
	0 --> If graph is not Eulerian
	1 --> If graph has an Euler path (Semi-Eulerian)
	2 --> If graph has an Euler Circuit (Eulerian) '''

	def isEulerian(self):
		
		if self.isConnected() == False:
			return 0
		else:
			
			odd = 0
			for i in range(self.V):
				if len(self.graph[i]) % 2 != 0:
					odd += 1

			'''If odd count is 2, then semi-eulerian.
			If odd count is 0, then eulerian
			If count is more than 2, then graph is not Eulerian
			Note that odd count can never be 1 for undirected graph'''
			if odd == 0:
				return 2
			elif odd == 2:
				return 1
			elif odd > 2:
				return 0

	

	def test(self):
		res = self.isEulerian()
		if res == 0:
			print("graph is not Eulerian")
		elif res == 1:
			print("graph has a Euler path")
		else:
			print("graph has a Euler cycle")



g1 = Graph(5)
g1.addEdge(1, 0)
g1.addEdge(0, 2)
g1.addEdge(2, 1)
g1.addEdge(0, 3)
g1.addEdge(3, 4)
g1.test()

g2 = Graph(5)
g2.addEdge(1, 0)
g2.addEdge(0, 2)
g2.addEdge(2, 1)
g2.addEdge(0, 3)
g2.addEdge(3, 4)
g2.addEdge(4, 0)
g2.test()

g3 = Graph(5)
g3.addEdge(1, 0)
g3.addEdge(0, 2)
g3.addEdge(2, 1)
g3.addEdge(0, 3)
g3.addEdge(3, 4)
g3.addEdge(1, 3)
g3.test()

g4 = Graph(3)
g4.addEdge(0, 1)
g4.addEdge(1, 2)
g4.addEdge(2, 0)
g4.test()

g5 = Graph(3)
g5.test()