# -*- coding: utf-8 -*-
"""
Created on Sun Sep 29 22:00:07 2019

@author: Tim
"""

import re

batch = [] # Initiate a batch txt file at the end to facilitate fidibus
branch = 'invertebrate' 
p = re.compile("\d{3}.\d_")
f = open(branch + '_latest.txt', 'r')
for line in f:
    yaml = {}
    entry = line.strip().split('/')
    name = entry[1].split('_')
    info = entry[-1]
    match = p.search(info)

    yaml['file_name'] = name[0][0] + name[1][:3]
    yaml['species'] = name[0] + ' ' + name[1]
    yaml['accession'] = info[:match.start()+5]
    yaml['build'] = info[match.start()+6:]
    L = [yaml['file_name'] + ':\n', "    species: " + yaml['species'] + '\n',
         "    source: refseq \n","    branch: " + branch + '\n',
         "    accession: " + yaml['accession'] + '\n',
         "    build: " + yaml['build']]
    batch.append(yaml['file_name'] + '\n')
    with open(yaml['file_name'] + ".yml",'w') as y:
        y.writelines(L) 
f.close()

# Create the batch text file.
with open(branch + '.txt','w') as b:
    b.writelines(batch)
