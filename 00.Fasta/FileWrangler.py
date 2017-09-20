import os
import sys
import getopt
from datetime import datetime


def ReadList(arg1):
    """Reads in list of files to look for and returns a list of names

    :arg1: List of names in text file. 
    :returns: List of files

    """
    FilesToLookFor = []
    try:
        with open(arg1, 'r') as f:
            for line in f:
                Cleaned = line.strip()
                if Cleaned not in FilesToLookFor:
                    FilesToLookFor.append(Cleaned)
                else:
                    #Don't want mulitiple copes
                    pass
            
    except:
        print "Fle Doesnt exitst"
    return FilesToLookFor


def FindFiles(Extension, Directory):
    """TODO: Docstring for FindFiles.

    :arg1: TODO
    :returns: TODO

    """
    try:
        Check = os.path.exists("/home/el/myfile.txt")
    except:
        print "Directory does not exist"
        sys.exit(2)
    
    FinalList = []
    AllFiles = os.listdir(Directory)

    
    for item in AllFiles:
        if item.endswith(Extension):
            CleanedItem = item.replace(Extension, '')
            FinalList.append(CleanedItem)
    return FinalList

def ReportMissingFiles(LookingForFiles, FoundFiles):
    
    
    NotFound = []
    Found = []
    CreatedSet = set(FoundFiles)

    for item in LookingForFiles:
        if item not in CreatedSet:
            NotFound.append(item)
        elif item in CreatedSet:
            Found.append(item)
            

    print "\n"
    print "We are looking for %s file and didn't find %s missing files" % (len(LookingForFiles),len(NotFound))
    print 'press enter to continue'
    
    raw_input()
    print "The following files were not found in this Directory"
    for item in NotFound:
        print item
    
    print  "The following %s items were found though" % len(Found) 
    raw_input()
    for item in Found:
        print item

    
    

    #for item in FoundFiles:
    #    if item not in CreatedSet:
    #        NotFound.append(item)

    #print "The following items are Not found"
    #for item in NotFound:
    #    print item
    #    print '\n'



def Usage():
    print "The purpose of this program is to keep better track of files. In \n"
    "bioinformatics it is incredibly easy to lose a file here and there. The\n"
    "purpose of this script it to input a base name of all the files you are \n"
    "working with, as well as give an ending file extension. After this the \n"
    "program will rull through the directory structure and report any files with \n"
    "a given base name that are misisng \n"



def Main():

    ListFlag = None
    Extension = None
    Directory = None

    try:
        options, other_args = getopt.getopt(sys.argv[1:], "l:e:d:h", ["list","extension", "dir", "help"])

    except getopt.GetoptError:
        print "There was a command parsing error"
        Usage()
        sys.exit(1)


   
    for option, value in options:
        if option == "-l":
            ListFlag = value
        elif option == "-e" or option == "extension":
            Extension = value
        elif option == "-d" or option == "dir":
            Directory = value
        elif option == "-h":
            Usage()
            sys.exit(-2)
        else:
            print "Unhandeled options %s %s" % (options)

    if ListFlag == None:
        print "Need a list file to referance"
        Usage()
        exit(-1)
    elif Directory == None:
        print "Need a directory to check for files in "
        Usage()
        exit(-2)
    elif Extension == None:
        print "Input file extension to remove when looking for files"
        Usage()
        exit(-1)
    
    #print ListFlag
    #print Extension
    #print Directory
    LookingForFiles = ReadList(ListFlag)
    FoundList = FindFiles(Extension, Directory)
    ReportMissingFiles(LookingForFiles, FoundList)



if __name__ == "__main__":
    Main()
