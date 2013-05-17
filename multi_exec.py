import sys, re, glob, os, subprocess

def multiExec(cmd, filePattern, times):
    print cmd, filePattern, times
    for i in range(times):
        theFile = filePattern + str(i)
        subprocess.call([cmd, theFile])

multiExec("cat", "tmp", 3)
