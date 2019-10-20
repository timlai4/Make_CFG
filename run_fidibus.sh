#!/bin/bash

set -u

batch=invertebrate.txt
species_list=($(cat "$batch"))

for species in ${species_list[@]}
do
    if singularity exec -e -B `pwd` aegean.simg fidibus -c=. --refr=$species download prep iloci breakdown stats
    then
        echo $species >> final_${batch}
    fi
done
find species -type f -not -name "*.gff3" -and -not -name "*.tsv" -exec rm {} \;
