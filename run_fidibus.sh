#!/bin/bash

set -u

batch=invertebrate.txt
species_list=($(cat "$batch"))

for species in ${species_list[@]}
do
    singularity exec -e -B `pwd` aegean.simg fidibus -c=. --refr=$species download prep iloci breakdown stats
done
