#!/usr/bin/env python

import mmap

def portals(dbfile):
    db = open(dbfile, 'rb')
    mm = mmap.mmap(db.fileno(), 0, prot=mmap.PROT_READ)
    i, l = 0, set()
    while True:
        i = mm.find(b'\xea\x91|)', i)
        if i == -1:
            break
        l.add(mm[i+5:i+5+mm[i+4]].decode())
        i += 5 + mm[i+4]
    return l

print(portals("/home/abdul/.local/share/Steam/userdata/872408678/892970/remote/worlds/dtomicsworld.db"))

