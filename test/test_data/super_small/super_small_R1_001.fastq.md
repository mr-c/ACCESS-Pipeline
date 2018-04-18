# UMI Test data for Simplex, Duplex & Unfiltered Bams

### Reads 1 and 2 (with UMIs) from
### Pan_Cancer_M2_IGO_05500_DY_39_S40_R1_001.fastq.gz
### Pan_Cancer_M2_IGO_05500_DY_39_S40_R2_001.fastq.gz


##########################
### DUPLEX 2-2 FRAGMENTS #
##########################

Simplex Read, 2 reads on one strand
```
TCCTCAGGCTGCCGTCCCGCAGGAGCGAGTCCCGAGGCGCCGTGCGCATCAAGGTGCTGGACGTGCTGTCCTTTGTGCTGCTCATCAACAGGCAGTTCTATGAGGTGCGTGTCCAGGCGGCCGCAG
                         CGAGTCCCGAGGCGCCGTGCGCATCAAGGTGCTGGACGTGCTGTCCTTTGTGCTGCTCATCAACAGGCAGTTCTATGAGGTGCGTGTCCAGGCGGCCGCAGCTGGGGGCTCAGGGCTATTTACTCG
```
The full insert (with UMIs):
```
TCCTCAGGCTGCCGTCCCGCAGGAG CGAGTCCCGAGGCGCCGTGCGCATCAAGGTGCTGGACGTGCTGTCCTTTGTGCTGCTCATCAACAGGCAGTTCTATGAGGTGCGTGTCCAGGCGGCCGCAG CTGGGGGCTCAGGGCTATTTACTCG
```
The (manually generated) 2nd Strand (from reversecomp()):
```
CGAGTAAATAGCCCTGAGCCCCCAG CTGCGGCCGCCTGGACACGCACCTCATAGAACTGCCTGTTGATGAGCAGCACAAAGGACAGCACGTCCAGCACCTTGATGCGCACGGCGCCTCGGGACTCG CTCCTGCGGGACGGCAGCCTGAGGA
```

The First Strand:
```
@K00217:101:HL5KNBBXX:7:1111:1111:1111 1:N:0:TCTAGGAG+CTCCTAGA
TCC TCAGGCTGCCGTCCCGCAGGAGCGAGTCCCGAGGCGCCGTGCGCATCAAGGTGCTGGACGTGCTGTCCTTTGTGCTGCTCATCAACAGGCAGTTCTATGAGGTGCGTGTCCAGGCGGCCGCAG
+
JJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJ

@K00217:101:HL5KNBBXX:7:2222:2222:2222 1:N:0:TCTAGGAG+CTCCTAGA
TCC TCAGGCTGCCGTCCCGCAGGAGCGAGTCCCGAGGCGCCGTGCGCATCAAGGTGCTGGACGTGCTGTCCTTTGTGCTGCTCATCAACAGGCAGTTCTATGAGGTGCGTGTCCAGGCGGCCGCAG
+
JJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJ
```

The Other Strand:
```
@K00217:101:HL5KNBBXX:7:3333:3333:3333 1:N:0:TCTAGGAG+CTCCTAGA
CGA GTAAATAGCCCTGAGCCCCCAGCTGCGGCCGCCTGGACACGCACCTCATAGAACTGCCTGTTGATGAGCAGCACAAAGGACAGCACGTCCAGCACCTTGATGCGCACGGCGCCTCGGGACTCG
+
JJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJ

@K00217:101:HL5KNBBXX:7:4444:4444:4444 1:N:0:TCTAGGAG+CTCCTAGA
CGA GTAAATAGCCCTGAGCCCCCAGCTGCGGCCGCCTGGACACGCACCTCATAGAACTGCCTGTTGATGAGCAGCACAAAGGACAGCACGTCCAGCACCTTGATGCGCACGGCGCCTCGGGACTCG
+
JJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJ
```

######################
# SIMPLEX 3 FRAGMENT #
######################
```
GTAGTCTTTAGGCCAAGAGAAGCCATAGGGATACTGTGACCTTTGTCTAGAGTTGATGGGGGTGTGATTTGGGAAATAAAACAGGACCGTACTGCGTGGAAGAAGGAAACGGAAGCTGACATAATG
                                                            GGTGTGATTTGTGAAATAAAACAGGACCGTACTGCTTGGAAGAAGGAAACGGAAGCTGACATAATGGGGATTAATTAGTTGATTGCTGTTGAGATGGTAACCGATTTGCTCCTAAACCATTGACAT
```
The Full Insert (no second strand in this case):
```
GTAGTCTTTAGGCCAAGAGAAGCCATAGGGATACTGTGACCTTTGTCTAGAGTTGATGGG GGTGTGATTTGGGAAATAAAACAGGACCGTACTGCGTGGAAGAAGGAAACGGAAGCTGACATAATG GGGATTAATTAGTTGATTGCTGTTGAGATGGTAACCGATTTGCTCCTAAACCATTGACAT
```
```
@K00217:101:HL5KNBBXX:7:5555:5555:5555 1:N:0:TCTAGGAG+CTCCTAGA
GTA GTCTTTAGGCCAAGAGAAGCCATAGGGATACTGTGACCTTTGTCTAGAGTTGATGGGGGTGTGATTTGGGAAATAAAACAGGACCGTACTGCGTGGAAGAAGGAAACGGAAGCTGACATAATG
+
JJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJ

@K00217:101:HL5KNBBXX:7:6666:6666:6666 1:N:0:TCTAGGAG+CTCCTAGA
GTA GTCTTTAGGCCAAGAGAAGCCATAGGGATACTGTGACCTTTGTCTAGAGTTGATGGGGGTGTGATTTGGGAAATAAAACAGGACCGTACTGCGTGGAAGAAGGAAACGGAAGCTGACATAATG
+
JJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJ

@K00217:101:HL5KNBBXX:7:6666:6666:6666 1:N:0:TCTAGGAG+CTCCTAGA
GTA GTCTTTAGGCCAAGAGAAGCCATAGGGATACTGTGACCTTTGTCTAGAGTTGATGGGGGTGTGATTTGGGAAATAAAACAGGACCGTACTGCGTGGAAGAAGGAAACGGAAGCTGACATAATG
+
JJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJ
```

#############
# SINGLETON #
#############
```
TCGTTACCACTTTTACAGAAACAGCTGTTATACCCATTAATGGTTCACCTCGAACACCCAGGCGAGGTCAGAACAGGAGTGCACGGATAGCAAAACAACTAGAAAATGATACAAGAATTATTGAAG
                                                                                             AACAACTAGAAAATGATACAAGAATTATTGAAGTTCTCTGTAAAGAACATGAATGTAATATAGATGAGGTAATTTAACTTCATGATTTCTTTAAAACAGTTAAAGTAGATTTAGATGTAAGACTCG
```
The Full Insert:
```
TCGTTACCACTTTTACAGAAACAGCTGTTATACCCATTAATGGTTCACCTCGAACACCCAGGCGAGGTCAGAACAGGAGTGCACGGATAGCAAAACAACTAGAAAATGATACAAGAATTATTGAAGTTCTCTGTAAAGAACATGAATGTAATATAGATGAGGTAATTTAACTTCATGATTTCTTTAAAACAGTTAAAGTAGATTTAGATGTAAGACTCG

@K00217:101:HL5KNBBXX:7:7777:7777:7777 1:N:0:TCTAGGAG+CTCCTAGA
TCG TTACCACTTTTACAGAAACAGCTGTTATACCCATTAATGGTTCACCTCGAACACCCAGGCGAGGTCAGAACAGGAGTGCACGGATAGCAAAACAACTAGAAAATGATACAAGAATTATTGAAG
+
JJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJ
```