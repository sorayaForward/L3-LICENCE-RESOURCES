import re,sys

#select from 80jours.txt all two words that starts with Uppercase + turn to lowercase
#txt = open(sys.argv[1],encoding='utf-16').read()
#x = re.findall("[A-Z][a-z]{3,} [A-Z][a-z]+", txt)
#for i in x:
#    print(i.lower())
 
#select from dlf all the cummon words (what's before ,)
#txt1 = open('dlf',encoding='utf-16').read()
#xx = re.findall(".+(?=,)", txt1)
#for i in xx:
#    print(i)
    
    

txt = open('res.txt',encoding='utf-16').readlines()
txt1 = open('dlf.txt',encoding='utf-16').read()

for i in txt:
    print(i)

for i in txt:
    for j in txt1:
        if(i == j):
            print('---',i)
            i = ''