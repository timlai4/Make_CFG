# -*- coding: utf-8 -*-
"""
Created on Sun Sep 29 22:00:07 2019

@author: Tim
"""

import re

branch = 'invertebrate'
p = re.compile("\d{3}.\d_")
f = open(branch + '_latest.txt', 'r')
for line in f: # Compare against IMD
    yaml = {}
    entry = line.strip().split('/')
    name = entry[1].split('_')
    info = entry[-1]
    match = p.search(info)

    yaml['file_name'] = name[0][0] + name[1][:3]
    yaml['species'] = name[0] + ' ' + name[1]
    yaml['accession'] = info[:match.start()+5]
    yaml['build'] = info[match.start()+6:]
    L = [yaml['file_name'] + '\n', "    species: " + yaml['species'] + '\n',
         "    source: refseq \n","    branch: " + branch + '\n',
         "    accession: " + yaml['accession'] + '\n',
         "    build: " + yaml['build']]
    with open(yaml['file_name'] + ".yml",'w') as f:
        f.writelines(L) 

f.close()