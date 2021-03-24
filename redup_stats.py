import re
import sys
import Levenshtein
import random
import string
import time
import numpy as np
from datetime import datetime
from matplotlib import pyplot as plt
from adjustText import adjust_text
from collections import Counter



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
	previous_red=False
	previous_part=False
	redup_words=list()
	partial_words=list()
	for i in range(0,len(words)-1):
	  dist=Levenshtein.distance(words[i],words[i+1])
	  if dist==0  :#and len(words[i])>1: # ignore single char reduplication (see TXB)
	    n_redup+=1
	    redup_words.append(words[i+1])
	    if not(previous_red):
	      redup_words.append(words[i])
	    if previous_red or previous_part:
	      n_triple+=1
	      mylog("triple_redup "+words[i-1]+"."+words[i]+"."+words[i+1]+" "+str(i),islog)
	    else:
	      mylog("redup "+words[i]+"."+words[i+1]+" "+str(i),islog)
	    previous_red=True
	    previous_part=False
	  elif dist==1 and len(words[i])>2 and len(words[i+1])>2:
	    n_partial+=1
	    partial_words.append(words[i+1])
	    if not(previous_part):
	      partial_words.append(words[i])
	    if previous_red or previous_part:
	      n_triple+=1
	      mylog("triple_partial "+words[i-1]+"."+words[i]+"."+words[i+1]+" "+str(i),islog)
	    else:
	      partial_words.append(words[i])
	      mylog("partial "+words[i]+"."+words[i+1]+" "+str(i),islog)
	    previous_part=True
	    previous_red=False
	  else:
	    previous_part=False
	    previous_red=False
	return n_redup,n_partial,n_triple,redup_words,partial_words
	
def scramble(mylist):
  newlist=mylist
  for i in range(0,len(newlist)):
    #j=(i*11+19)%(len(newlist)-1)
    j=random.randint(0,len(newlist)-1)
    temp=newlist[j]
    newlist[j]=newlist[i]
    newlist[i]=temp
  return newlist
  
def read_words(infile):
  with_spaces=''
  with open(infile, 'r') as myfile:
    text=myfile.read()
    if 'vms/' in infile:  # ivtt VMS file
      text=re.sub('<[^>]*>',' ',text)
    else:
      text=text.lower() # v101 is case sensitive
    clean_string=' '+text.replace('\n', ' ').replace('\r', ' ')
    # TXB contains strings like "(yoka)l(l)e"
    clean_string=re.sub('[()]','',clean_string)
    translator = clean_string.maketrans(string.punctuation, ' '*len(string.punctuation))
    # replace punctuation with spaces
    clean_string=clean_string.translate(translator)
    # '–' '·' '•' occur repeatedly in TXB and are not in string.punctuation
    # '–' '·' apparently represent sounds or maybe unreadable characters?
    clean_string=re.sub('[•–]',' ',clean_string)

  mylog( "len_decoded: "+str(len(clean_string)),is_log)
  mylog(clean_string[:200],is_log)

  msg=""
  for i in range(0,10):
    msg+= str(i)+":"+clean_string[i]+"  "
  mylog(msg,is_log)

  temp=clean_string.split(' ')
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
  return words


def proc_file(infile, N_SCR):
  words=read_words(infile)
  n_redup,n_partial,n_triple,red_words,part_words=count_redup(words,is_log)
  mylog( "ORIG "+infile+" "+str(n_redup)+" "+frmt(100.0*n_redup/float(len(words)-1))+\
     " "+str(n_partial)+" "+frmt(100.0*n_partial/float(len(words)-1))+\
     " "+str(n_triple)+" "+frmt(100.0*n_triple/float(len(words)-2)),is_log)

  tot_red_s=tot_partial_s=tot_triple_s=n_redup_s=n_partial_s=n_triple_s=0
  for i in range(0,N_SCR):
    scrambled=scramble(words)
    n_redup_s,n_partial_s,n_triple_s,red_words,part_words=count_redup(words, False)
    tot_red_s+=n_redup_s
    tot_partial_s+=n_partial_s
    tot_triple_s+=n_triple_s
    mylog( "scrambled: "+str(n_redup_s)+" "+str(n_partial_s)+" "+str(n_triple_s),is_log)
  
  n_redup_s=float(tot_red_s)/max(1,N_SCR)
  n_partial_s=float(tot_partial_s)/max(1,N_SCR)
  n_triple_s=float(tot_triple_s)/max(1,N_SCR)
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
  
def scatter_plot(records,nx,ny,x_axis,y_axis,prefix,n_labels):
  xs=list()
  ys=list()
  for rec in records:
    xs.append(rec[nx])
    ys.append(rec[ny])
  min_x_lab=min_y_lab=-9999999
  if (len(xs)>n_labels):
    min_x_lab=sorted(xs, reverse=True)[n_labels]
    min_y_lab=sorted(ys, reverse=True)[n_labels]
  labels=list()
  colors=list()
  markers=list()
  for rec in records:
    if (rec[nx]>=min_x_lab or rec[ny]>min_y_lab):
      fname=re.sub('.*/','',rec[0])
      labels.append(fname)
    else:
      labels.append('')
    if ('vms/' in rec[0]):
      colors.append('#0088ff')
      markers.append('s')
    elif ('generated' in rec[0]):
      colors.append('#33ff33')
      markers.append('X')
    else:
      colors.append('#ff9933')
      markers.append('o')

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



  plt.savefig('out/'+prefix+"_"+get_time_str()+'.png')
  
def get_time_str():
  ts=time.time()
  return datetime.fromtimestamp(ts).strftime('%m%d%H%M%S')

def do_redup_by_rank(files):
  f = plt.figure()
  plt.ylim(-1,20)
  N_WORDS=30
  plt.xticks(np.arange(1, N_WORDS+1, step=2))
  nline=0
  styles=('ro-','bs-','go-')
  texts = []
  for f in files:
    words=read_words(f)
    cnt=Counter(words)
    print(cnt.most_common(N_WORDS))
    n_redup,n_partial,n_triple,red_words,part_words=count_redup(words,is_log)
    redcnt=Counter(red_words)
    xs=list()
    ys=list()
    labels=list()
    i=1
    for w,n in cnt.most_common(N_WORDS):
      mylog(w+" "+str(cnt[w])+" "+str(redcnt[w])+" "+frmt(100.0*redcnt[w]/cnt[w]),is_log)
      xs.append(i)
      ys.append(100.0*redcnt[w]/cnt[w])
      labels.append(w)
      i=i+1
    for x, y, l in zip(xs, ys, labels):
      texts.append(plt.text(x, y, l))
    print(styles)
    print(styles[0])
    plt.plot(xs, ys, styles[nline],alpha=0.5)
    nline+=1
  plt.xlabel(files[0])
  plt.ylabel("Full Reduplication %")
  fname=re.sub("/","_",files[0]).replace('texts_','')
  adjust_text(texts, force_points=0.2, force_text=0.2,
            expand_points=(1, 1), expand_text=(1, 1),
            arrowprops=dict(arrowstyle="-", color='#444477', lw=0.5))
  plt.savefig('out/rank_'+fname+'_'+get_time_str()+'.png')

def do_redup_scatter(files):
  print( "_data_ couples red %red partial %partial triple %triple scr.red scr.%r scr.partial scr.%partial scr.triple scr.%triple")
  tot_couples=0
  tot_red=0
  tot_partial=0
  allres=list()
  for f in files:
    res=proc_file(f,0)
    tot_couples+=res[1]
    tot_red+=res[2]
    tot_partial+=res[4]
    allres.append(res)
    print_res_list(res)
  mylog("tot "+str([tot_couples,tot_red,tot_partial]),is_log)
  prefix=re.sub("/[^/]*$","",files[0]).replace('/','_')
  scatter_plot(allres,3,5,"Full Reduplication %","Partial Reduplication %",prefix,15)
  scatter_plot(allres,5,7,"Partial Reduplication %","Triple Reduplication %","triple"+prefix,12)

def do_scramble(files):
  allres=list()
  for f in files:
    res=proc_file(f,20)
    allres.append(res)
  ratios=list()
  error=""
  for res in allres:
    mylog("RES "+str(res),is_log)
    red=0
    if (res[3]>0):
      red=res[3]/res[9]
    part=0
    if (res[5]>0):
      part=res[5]/res[11]
    triple=0
    if (res[7]>0):
      if (res[13]>0):
        triple=res[7]/res[13] 
      else: # Division by 0
        mylog("*** ZERO SCR TRIPLE "+str(res),is_log)
        error+="ERROR "+str(res)+"\n"
    ratios.append((res[0],red,part,triple))
  scatter_plot(ratios,1,2,"Full Reduplication Actual/Scrambled","Partial Reduplication Actual/Scrambled","scr_",20)
  scatter_plot(ratios,1,3,"Full Reduplication Actual/Scrambled","Triple Reduplication Actual/Scrambled","scr3_",20)
  print("CHECK: "+error)

is_log=True
if sys.argv[1]=='redup_scatter':
  do_redup_scatter(sys.argv[2:])
elif sys.argv[1]=='redup_by_rank':
  do_redup_by_rank(sys.argv[2:])
elif sys.argv[1]=='scramble':
  do_scramble(sys.argv[2:])
else:
  print("arg1: redup_scatter redup_by_rank")

