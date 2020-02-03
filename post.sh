#!/bin/bash
set -u

batch=final_fungi.txt
species_list=($(cat "$batch"))

singularity exec -e -B `pwd` aegean.simg fidibus-ilocus-summary.py --outfmt=tsv ${species_list[@]} > fungi-ilocus-summaries.tsv
singularity exec -e -B `pwd` aegean.simg fidibus-pilocus-summary.py --outfmt=tsv ${species_list[@]} > fungi-pilocus-summaries.tsv
singularity exec -e -B `pwd` aegean.simg fidibus-milocus-summary.py --outfmt=tsv ${species_list[@]} > fungi-milocus-summaries.tsv
singularity exec -e -B `pwd` aegean.simg fidibus-compact.py --centroid=2.25  --length=1000000 --iqnt=0.95 --gqnt=0.05 ${species_list[@]} > phisigma_fungi.tsv
