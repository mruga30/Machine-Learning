import csv
import pandas as pd

url = []
length = []
dots = []
slash = []
dotcom = []
at = []
percent = []
ip = []
hostlen = []
dotsh = []
nou = 0

clength = []
cdots = []
cslash = []
cdotcom = []
chostlen = []
cdotsh = []

f = open("cdc.csv","r")
for x in f:
	nou = nou+1
	url.append(x) 
	length.append(len(x))  #calculate the length of url
	dots.append(x.count('.')) #calculate no. of dots in each url
	slash.append(x.count('/')) #calculate no. of slashes in url
	dotcom.append(x.count('.com')) #calculate no. of dots in url
	if x.find('@')!=-1:    #find if @ is present in url
		at.append(1)
	else:
		at.append(0)

	if x.find('%40')!=-1:   #find if %40 in url
		percent.append(1)
	else:
		percent.append(0)

	#check if IP address in hostname
	if x.find('https://')!=-1:  #check if url starts with the "https"
		if x[8].isdigit():
			ip.append(1)
		else:
			ip.append(0)
	else:			    		#check for "http"
		if x[7].isdigit():
			ip.append(1)
		else:
			ip.append(0)

	#length of url host name
	lh = 0
	if x.find('https://')!=-1:  #if url starts with the "https"
		for i in range(8, len(x)):
			if i == len(x):
				break
			elif x[i].find('/')!=-1:
				break
			else:
				lh = lh+1
		hostlen.append(lh)
	else:			    		#check for "http"
		for i in range(8, len(x)):
			if i == len(x):
				break
			elif x[i].find('/')!=-1:
				break
			else:
				lh = lh+1
		hostlen.append(lh)

	#no of dots in host name
	ndh = 0
	if x.find('https://')!=-1:  #if url starts with the "https"
		for i in range(8, len(x)):
			if i == len(x):
				break
			elif x[i].find('/')!=-1:
				break
			else:
				if x[i].find('.')!=-1:
					ndh = ndh+1
		dotsh.append(ndh)
	else:			    		#check for "http"
		for i in range(8, len(x)):
			if i == len(x):
				break
			elif x[i].find('/')!=-1:
				break
			else:
				if x[i].find('.')!=-1:
					ndh = ndh+1
		dotsh.append(ndh)

for i in range(nou):
	if length[i] < 55:
		clength.append(1)
	else:
		clength.append(0)

	if dots[i] < 10:
		cdots.append(1)
	else:
		cdots.append(0)

	if slash[i] < 4:
		cslash.append(1)
	else:
		cslash.append(0)

	if dotcom[i] < 2:
		cdotcom.append(1)
	else:
		cdotcom.append(0)

	if hostlen[i] < 50:
		chostlen.append(1)
	else:
		chostlen.append(0)

	if dotsh[i] < 4:
		cdotsh.append(1)
	else:
		cdotsh.append(0)

dict={'url':url,'length of url':length,'No. of dots(URL)':dots,'No. of slashes':slash, 'No. of .com in URL':dotcom,'@ in URL':at,'%40 in URL':percent,'Is hostname an IP address?':ip,'Length of hostname':hostlen,'No. of dots(hostname)':dotsh}
df = pd.DataFrame(dict) 
df.to_csv('Complete_dataset_features3.csv')

dicts={'url':url,'length of url':clength,'No. of dots(URL)':cdots,'No. of slashes':cslash, 'No. of .com in URL':cdotcom,'@ in URL':at,'%40 in URL':percent,'Is hostname an IP address?':ip,'Length of hostname':chostlen,'No. of dots(hostname)':cdotsh}
dfs = pd.DataFrame(dicts)
dfs.to_csv('Complete_dataset_classes3.csv')

