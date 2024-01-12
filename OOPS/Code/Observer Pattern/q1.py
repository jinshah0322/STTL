import zope.interface

class observer(zope.interface.Interface):
    def update(self,msg):
        pass

@zope.interface.implementer(observer)
class user1:
    def update(self,msg):
        print("user 1",msg)

@zope.interface.implementer(observer)
class user2:
    def update(self,msg):
        print("user 2",msg)

class subject(zope.interface.Interface):
    def registerObserver(self,observer):
        pass
    def unregisterObserver(self,observer):
        pass
    def notifyObserver(self):
        pass

@zope.interface.implementer(subject)
class channel1:
    def registerObserver(self,observer):
        pass
    def unregisterObserver(self,observer):
        pass
    def notifyObserver(self):
        pass

@zope.interface.implementer(subject)
class channel2:
    def registerObserver(self,observer):
        pass
    def unregisterObserver(self,observer):
        pass
    def notifyObserver(self):
        pass