from abc import ABC , abstractmethod

class Phone(ABC):
    
    @abstractmethod
    def createPhone(self,model):
        pass

class Iphone14(Phone):
    def __init__(self,brand,model) :
        self.brand = brand
        self.model = model

class Iphone15(Phone):
    def __init__(self,brand,model) :
        self.brand = brand
        self.model = model

class SamsungNote(Phone):
    def __init__(self,brand,model) :
        self.brand = brand
        self.model = model

class SamsungS(Phone):
    def __init__(self,brand,model) :
        self.brand = brand
        self.model = model