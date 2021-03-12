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

def mylog(msg, islog):
  if islog:
    print("LOG "+msg)

def count_redup(words,islog):
	n_redup=0
	n_partial=0
	n_triple=0
	previous=False
	for i in range(0,len(words)-1):
	  dist=Levenshtein.distance(words[i],words[i+1])
	  if dist==0  and len(words[i])>1: # ignore single char reduplication (see TXB)
	    n_redup+=1
	    if previous:
	      n_triple+=1
	      mylog("triple_redup "+words[i-1]+"."+words[i]+"."+words[i+1]+" "+str(i),islog)
	    else:
	      mylog("redup "+words[i]+"."+words[i+1]+" "+str(i),islog)
	    previous=True
	  elif dist==1 and len(words[i])>3 and len(words[i+1])>3:
	    n_partial+=1
	    if previous:
	      n_triple+=1
	      mylog("triple_partial "+words[i-1]+"."+words[i]+"."+words[i+1]+" "+str(i),islog)
	    else:
	      mylog("partial "+words[i]+"."+words[i+1]+" "+str(i),islog)
	    previous=True
	  else:
	    previous=False
	return n_redup,n_partial,n_triple
	
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
    # '–' '·' '•' occur repeatedly in TXB and are not in string.punctuation
    with_spaces=re.sub('[•–·]',' ',with_spaces)

  lowercase_string=with_spaces.lower()
  mylog( "len_decoded: "+str(len(lowercase_string)),is_log)
  mylog(with_spaces[:200],is_log)

  msg=""
  for i in range(0,10):
    msg+= str(i)+":"+lowercase_string[i]+"  "
  mylog(msg,is_log)

  temp=lowercase_string.split(' ')
  words=list()
  for w in temp:
    if (len(w)>0):
      words.append(w)
  mylog(str(len(words)),is_log)
  #print(words)
  for i in range(0,2):
   w=words[i]
   msg1=""
   for j in range(0,len(w)):
     msg1=msg1+w[j]+':'+str(j)+' '
   mylog(msg1,is_log)
  mylog(" ",is_log)

  n_redup,n_partial,n_triple=count_redup(words,is_log)
  mylog( "ORIG "+infile+" "+str(n_redup)+" "+frmt(100.0*n_redup/float(len(words)-1))+\
     " "+str(n_partial)+" "+frmt(100.0*n_partial/float(len(words)-1))+\
     " "+str(n_triple)+" "+frmt(100.0*n_triple/float(len(words)-2)),is_log)

  #N_SCR=20
  N_SCR=3
  tot_red=0
  tot_partial=0
  tot_triple=0
  for i in range(0,N_SCR):
    scrambled=scramble(words)
    n_redup_s,n_partial_s,n_triple_s=count_redup(words, False)
    tot_red+=n_redup_s
    tot_partial+=n_partial_s
    tot_triple+=n_triple_s
    mylog( "scrambled: "+str(n_redup_s)+" "+str(n_partial_s),is_log)
  
  n_redup_s=float(tot_red)/N_SCR
  n_partial_s=float(tot_partial)/N_SCR
  return [infile, (len(words)-1), (n_redup), (100.0*n_redup/float(len(words)-1)), \
   (n_partial), (100.0*n_partial/float(len(words)-1)), \
   (n_triple), (100.0*n_triple/float(len(words)-2)), \
   (n_redup_s), (100.0*n_redup_s/float(len(words)-1)), \
   (n_partial_s), (100.0*n_partial_s/float(len(words)-1)),\
   (n_triple_s), (100.0*n_triple_s/float(len(words)-2))]

def print_res_list(result):
  sys.stdout.write(re.sub(".*/","",result[0]))
  for i in range(1,len(result)):
    if i in (1,2,4,6):
      sys.stdout.write(" "+str(result[i]))
    else:
      sys.stdout.write(" "+frmt(result[i]))
  print()
  
def scatter_plot(records,nx,ny,x_axis,y_axis,prefix):
  xs=list()
  ys=list()
  labels=list()
  colors=list()
  markers=list()
  for rec in records:
    if (rec[nx]+rec[ny])>0.2:
      fname=re.sub('.*/','',rec[0])
      labels.append(fname)
    else:
      labels.append('')
    if ('vms/EVA' in rec[0]):
      colors.append('#0088ff')
      markers.append('s')
    elif ('generated' in rec[0]):
      colors.append('#55ff55')
      markers.append('s')
    else:
      colors.append('#ff9933')
      markers.append('o')
    xs.append(rec[nx])
    ys.append(rec[ny])
  f = plt.figure()
  for i in range(0,len(xs)):
    scatter = plt.scatter(xs[i], ys[i], s=80, marker=markers[i], c=colors[i], edgecolors='w')
  plt.xlim(0)
  plt.ylim(0)
  texts = []
  for x, y, l in zip(xs, ys, labels):
    texts.append(plt.text(x, y, l))
  plt.xlabel(x_axis)
  plt.ylabel(y_axis)

  adjust_text(texts, force_points=0.2, force_text=0.2,
            expand_points=(1, 1), expand_text=(1, 1),
            arrowprops=dict(arrowstyle="-", color='#444477', lw=0.5))

  ts=time.time()
  timestr=datetime.fromtimestamp(ts).strftime('%Y%m%d%H%M%S')

  plt.savefig('out/'+prefix+"_"+timestr+'.png')


is_log=True
print( "_data_ couples red %red partial %partial triple %triple scr.red scr.%r scr.partial scr.%partial scr.triple scr.%triple")
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
mylog("tot "+str([tot_couples,tot_red,tot_partial]),is_log)
prefix=re.sub("/[^/]*$","",sys.argv[1]).replace('/','_')
scatter_plot(allres,3,5,"Full Reduplication %","Partial Reduplication %",prefix)
scatter_plot(allres,5,7,"Partial Reduplication %","Triple Reduplication %","triple"+prefix)



