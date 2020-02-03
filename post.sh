#!/bin/bash
set -u

batch=final_viral.txt
species_list=($(cat "$batch"))

singularity exec -e -B `pwd` aegean.simg fidibus-ilocus-summary.py --outfmt=tsv ${species_list[@]} > viral-ilocus-summaries.tsv
singularity exec -e -B `pwd` aegean.simg fidibus-pilocus-summary.py --outfmt=tsv ${species_list[@]} > viral-pilocus-summaries.tsv
singularity exec -e -B `pwd` aegean.simg fidibus-milocus-summary.py --outfmt=tsv ${species_list[@]} > viral-milocus-summaries.tsv
singularity exec -e -B `pwd` aegean.simg fidibus-compact.py --centroid=2.25  --length=1000000 --iqnt=0.95 ${species_list[@]} > phisigma_viral.tsv
