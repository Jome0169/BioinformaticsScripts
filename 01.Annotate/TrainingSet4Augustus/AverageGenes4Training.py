from sys import argv
from operator import itemgetter
import time
import os


"""
Takes in a list of formatted GFF3s and only reports a list with an average
number of exons between 5-18 and with an averge lengtho of no greater than
3000.
These genes just make sense
cha feel
"""







def GroupGff3(GffGenomeFile):
    AssemblyGroupin = []
    with open(GffGenomeFile, 'r') as z:
        Group = []
        for line in z:
            X = len(line)
            if X != 1:
                Cleanline = line.strip('\n').split('\t')
                Group.append(Cleanline)
            elif X == 1:
                AssemblyGroupin.append(Group)
                Group = []
    return AssemblyGroupin



Freqs = {}
X = GroupGff3(argv[1])

for item in X:
    if len(item) not in Freqs:
        Freqs[len(item)] = 1
    else:
        Freqs[len(item)] += 1


for ky, val in Freqs.iteritems():
    print ky, val


OverNumv = len(X)
FindMeboi = []


HeavyStrictness =[]

for item in X:
    if len(item[0]) < 8:
        pass
    else:
        TotalLen = int(item[0][4]) - int(item[0][3])
        if TotalLen < 3000 and len(item) < 15:
            HeavyStrictness.append(item)


def mean(numbers):
    return float(sum(numbers)) / max(len(numbers), 1)

Counter1 = 0
for item in FindMeboi:
    if int(item) < 3000 and int(item) > 300:
        Counter1 += 1



try:
    os.remove("AvgMeanLenAndExonCOunt.gff3")
except OSError:
    pass


def WriteSeqTogff(ListofGff):
    with open("AvgMeanLenAndExonCOunt.gff3", 'a') as f:
        for item in ListofGff:
            for thing in item:
                Formated  = '\t'.join(thing)
                f.write(Formated)
                f.write('\n')
            f.write('\n')

WriteSeqTogff(HeavyStrictness)


