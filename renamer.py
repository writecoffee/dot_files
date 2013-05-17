import re, glob, os

def renamer(files, pattern, replacement):
    print pattern, replacement
    
    for pathname in glob.glob(files):
        basename = os.path.basename(pathname)
        new_filename = re.sub(pattern, replacement, basename)
        if new_filename != basename:
            print "mv %s %s" % (basename, new_filename)
            os.rename(pathname, os.path.join(os.path.dirname(pathname), new_filename))
