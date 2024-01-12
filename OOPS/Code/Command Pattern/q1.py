import zope.interface

class Command(zope.interface.Interface):
    def execute(self):
        pass

@zope.interface.implementer(Command)
class LightOnCommand:
    def __init__(self,light) :
        self.light = light
    
    def execute(self):
        self.light.switchOn()

@zope.interface.implementer(Command)
class LightOfCommand:
    def __init__(self,light):
        self.light = light

    def execute(self):
        self.light.switchOff()

class Light:
    def switchOn():
        print("Light is switched on")

    def switchOff():
        print("Light is switched off")

class Controller:
    def __init__(self) :
        self.command = None

    def setCommand(self,command):
        self.command = command

    def pressButton(self):
        self.command.execute()

light = Light()
