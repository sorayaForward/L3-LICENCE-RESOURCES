import sys,re
t=[]
for ligne in open('80jours_mod.txt','r',encoding="utf-16"):
  ligne=re.sub("\n","",ligne)
  t+=re.split("(?<![Mrs|Mr])[?\.] (?!,)",ligne)
print("\n".join(["PHRASE  "+str(c+1)+" ==> "+i for c,i in enumerate(t)]))