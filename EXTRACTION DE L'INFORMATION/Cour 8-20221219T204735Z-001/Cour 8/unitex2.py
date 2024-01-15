#----------------------unitex2.py---------------------------------------------------#
import os
from os import path
if path.exists("80jours_snt"):
	os.system("rd /s 80jours_snt")
os.mkdir("80jours_snt")
os.system("UnitexToolLogger Normalize 80jours.txt -r Norm.txt")
os.system("UnitexToolLogger Tokenize 80jours.snt")
os.system("UnitexToolLogger Compress cont.dic")
os.system("UnitexToolLogger Dico -t 80jours.snt Dela_fr.bin cont.bin")
os.system("UnitexToolLogger Grf2Fst2 cont.grf")
os.system("UnitexToolLogger Locate -t 80jours.snt cont.fst2 -L -I --all")
os.system("UnitexToolLogger Concord 80jours_snt/concord.ind -f \"Courrier new\" -s 12 -l 40 -r 55")
#----------------------unitex2.py---------------------------------------------------#