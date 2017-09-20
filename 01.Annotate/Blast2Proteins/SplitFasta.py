import itertools
import time 
import getopt
import os, sys






def GenomeReader(GenomeFile):
    """
    Arg: Takes in Genome File
    Rtrns: Returns a dictionary, Genome Scaffolds. 
    
    Keys genomic scaffold names being the
    keys - and the actual sequence being the value. 
    """
    GenomeScaffolds = {}
    with open(GenomeFile, 'r') as f:
        for line in f:
            line = line.strip()
            if line.startswith(">"):
                NamedSeq = line.replace('>', '>')
                GenomeScaffolds[NamedSeq] = ""
            else:
                GenomeScaffolds[NamedSeq] += line
        return GenomeScaffolds


def SplitDictionary(FullGenomeDict, Number):
    """
    Spits dict into Number of equal sized dicts
    """
    Dictlen = len(FullGenomeDict)
    RunThisMany = xrange(1,int(Number) + 1)
    Slices = Dictlen/int(Number)
    MiniatureDicts = []

    for item in RunThisMany:
        if int(item) == int(Number):
            IterStart = (item - 1) * Slices
            Z = dict(FullGenomeDict.items()[IterStart:])
            MiniatureDicts.append(Z)

        else:
            IterStart = (item - 1) * Slices
            IterEnd = int(item) * Slices
            Z = dict(FullGenomeDict.items()[IterStart:IterEnd])
            MiniatureDicts.append(Z)

    return MiniatureDicts

    

def WriteMiniDicts(MiniDicts, BaseName):
    Counter = 1
    for item in MiniDicts:
        FileName = str(BaseName) + '_' + "000" + str(Counter) + ".fasta"
        try:
            os.remove(FileName)
        except OSError:
            pass

        with open(FileName, 'a+') as f:
            for key, value in item.iteritems():
                f.write(key)
                f.write('\n')
                f.write(value)
                f.write('\n')
            Counter += 1




    


def Usage():
    print "\n Application %s [options] -i <input fasta file>  -n <Number fields to output> -b <base file name > \n" \
        "-i    FASTA file to be split into N number of files     \n" \
        "-n     The numbr of files to output   \n" \
        "-b     Base filename to outpout  \n" % (sys.argv[0])

def Main():

    global oflag
    Iflag = None
    Nflag = None
    Bflag = None

    try:
        options, other_args = getopt.getopt(sys.argv[1:], "i:n:h:b:", ["help"])

    except getopt.GetoptError:
        print "There was a command parsing error"
        Usage()
        sys.exit(1)

    for option, value in options:
        if option == "-i":
            Iflag = value
        elif option == "-n":
            Nflag = value
        elif option == "-b":
            Bflag = value
        elif option == "--help":
            Usage()
        else:
            print "Unhandeled options %s" % (options)

    if Iflag == None:
        print " Need a FASTA File to split"
        Usage()
        exit(-1)
    elif Nflag == None:
        print "Need a number of files to split"
        Usage()
        exit(-1)
    elif Bflag == None:
        print "Need BASENAME to use for output"
        Usage()
        exit(-1)

    MultiFasta = GenomeReader(Iflag)
    ChunkedDicts = SplitDictionary(MultiFasta, Nflag)
    WriteMiniDicts(ChunkedDicts, Bflag)



if __name__ == '__main__':
    Main()

