import re
import sys
import Levenshtein
import random
import string
import time
from datetime import datetime
from matplotlib import pyplot as plt
from adjustText import adjust_text


def frmt(myfloat,dec=3):
  form="{:."+str(dec)+"f}"
  return form.format(myfloat)

def mylog(msg):
  if is_log:
    print("LOG "+msg)

def count_redup(words,is_log):
	n_redup=0
	n_partial=0
	for i in range(0,len(words)-1):
	  dist=Levenshtein.distance(words[i],words[i+1])
	  if dist==0:
	    n_redup+=1
	    #print words[i]
	    #print words[i-2]+" "+words[i-1]+" len:"+str(len(words[i]))
	    #print words[i+1]
	    mylog("redup "+words[i]+"."+words[i+1]+" "+str(i))
	  elif dist==1 and len(words[i])>3 and len(words[i+1])>3:
	    n_partial+=1
	    mylog( "partial "+words[i]+"."+words[i+1]+" "+str(i))
	return n_redup,n_partial
	
def scramble(mylist):
  newlist=mylist
  for i in range(0,len(newlist)):
    #j=(i*11+19)%(len(newlist)-1)
    j=random.randint(0,len(newlist)-1)
    temp=newlist[j]
    newlist[j]=newlist[i]
    newlist[i]=temp
  return newlist


def proc_file(infile):
  with_spaces=''
  with open(infile, 'r') as myfile:
    text=myfile.read()
    if text.startswith('<f'):  # ivtt VMS file
      text=re.sub('<[^>]*>',' ',text)
    with_spaces=' '+text.replace('\n', ' ').replace('\r', ' ')
    translator = with_spaces.maketrans(string.punctuation, ' '*len(string.punctuation))
    # replace punctuation with spaces
    with_spaces=with_spaces.translate(translator)

  #unicode_string = with_spaces.decode("utf-8")
  unicode_string=with_spaces
  mylog( "len_decoded: "+str(len(unicode_string)))
  mylog(with_spaces[:200])

  msg=""
  for i in range(0,10):
    msg+= str(i)+":"+unicode_string[i]+"  "
  mylog(msg)

  temp=unicode_string.split(' ')
  words=list()
  for w in temp:
    if (len(w)>0):
      words.append(w)
  mylog(str(len(words)))
  #print(words)
  for i in range(0,2):
   w=words[i]
   msg1=""
   for j in range(0,len(w)):
     msg1=msg1+w[j]+':'+str(j)+' '
   mylog(msg1)
  mylog(" ")

  n_redup,n_partial=count_redup(words,is_log)
  fname=re.sub('.*/','',infile)
  mylog( "ORIG "+infile+" "+str(n_redup)+" "+frmt(100.0*n_redup/float(len(words)-1))+\
     " "+str(n_partial)+" "+frmt(100.0*n_partial/float(len(words)-1)))

  #N_SCR=20
  N_SCR=3
  tot_red=0
  tot_partial=0
  for i in range(0,N_SCR):
    scrambled=scramble(words)
    n_redup_s,n_partial_s=count_redup(words, False)
    tot_red+=n_redup_s
    tot_partial+=n_partial_s
    mylog( "scrambled: "+str(n_redup_s)+" "+str(n_partial_s))
  
  n_redup_s=float(tot_red)/N_SCR
  n_partial_s=float(tot_partial)/N_SCR
  return [fname, (len(words)-1), (n_redup), (100.0*n_redup/float(len(words)-1)), \
   (n_partial), (100.0*n_partial/float(len(words)-1)), \
   (n_redup_s), (100.0*n_redup_s/float(len(words)-1)), \
   (n_partial_s), (100.0*n_partial_s/float(len(words)-1))]


def print_res_list(result):
  sys.stdout.write(re.sub(".*/","",result[0]))
  for i in range(1,len(result)):
    if i in (1,2,4):
      sys.stdout.write(" "+str(result[i]))
    else:
      sys.stdout.write(" "+frmt(result[i]))
  print()
  
def scatter_plot(records,nx,ny,x_axis,y_axis,prefix):
  xs=list()
  ys=list()
  labels=list()
  colors=list()
  for rec in records:
    labels.append(rec[0])
    if (rec[0].startswith('EVA')):
      colors.append('#2222ff')
    else:
      colors.append('#ff8800')
    xs.append(rec[nx])
    ys.append(rec[ny])
  f = plt.figure()
  scatter = plt.scatter(xs, ys, s=50, c=colors, edgecolors='w')
  plt.xlim(0)
  plt.ylim(0)
  texts = []
  for x, y, s in zip(xs, ys, labels):
    texts.append(plt.text(x, y, s))
  plt.xlabel(x_axis)
  plt.ylabel(y_axis)

  adjust_text(texts, force_points=0.2, force_text=0.2,
            expand_points=(1, 1), expand_text=(1, 1),
            arrowprops=dict(arrowstyle="-", color='black', lw=0.5))
  #plt.show()
  #img=(x_axis+'_'+y_axis).replace(' ','')
  ts=time.time()
  timestr=datetime.fromtimestamp(ts).strftime('%Y%m%d%H%M%S')

  plt.savefig('out/'+prefix+"_"+timestr+'.png')


is_log=True
print( "_data_ couples red %red partial %partial scr.red scr.%r scr.partial scr.%partial")
tot_couples=0
tot_red=0
tot_partial=0
allres=list()
for f in sys.argv[1:]:
  res=proc_file(f)
  tot_couples+=res[1]
  tot_red+=res[2]
  tot_partial+=res[4]
  allres.append(res)
  print_res_list(res)
mylog("tot "+str([tot_couples,tot_red,tot_partial]))
prefix=re.sub("/[^/]*$","",sys.argv[1]).replace('/','_')
scatter_plot(allres,3,5,"Full Reduplication %","Partial Reduplication %",prefix)



