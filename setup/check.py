import nextcord
from pyboy import PyBoy

print(nextcord.version_info)
pyboy = PyBoy("rom.gb")

while pyboy.tick():
    pass

pyboy.stop()
