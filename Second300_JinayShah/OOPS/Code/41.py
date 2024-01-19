import threading

class TransactionalMemory:
    def __init__(self):
        self.data = {}
        self.lock = threading.Lock()

    def read(self, key):
        with self.lock:
            return self.data.get(key, None)

    def write(self, key, value):
        with self.lock:
            self.data[key] = value

def transactional_function(memory, key, value):
    for _ in range(1000):  
        current_value = memory.read(key)
        new_value = current_value + value
        memory.write(key, new_value)

if __name__ == "__main__":
    memory = TransactionalMemory()

    def worker():
        for _ in range(100):
            transactional_function(memory, 'counter', 1)

    threads = [threading.Thread(target=worker) for _ in range(10)]

    for thread in threads:
        thread.start()

    for thread in threads:
        thread.join()

    print("Final counter value:", memory.read('counter'))
