# Make Configuration (YAML) files for use with fidibus

This project is an extension of the [IntervalLoci](https://github.com/timlai4/IntervalLoci) project, which itself is an application of [AEGeAn](https://github.com/BrendelGroup/AEGeAn). The goal is to automate the creation of the YAML files described in https://github.com/standage/genhub/blob/master/docs/DEVELOP.md allowing faster analysis of a large group, up to an entire branch, of genomes from NCBI. 

## Retrieving directory hierarchical structure for a branch

The project hinges on retrieving all the species genomic information within a branch in NCBI. I will describe this here and leave it to the user to filter further based on their interests. For illustrative purposes, I focus on the invertebrate branch. For other branches, it is a simple matter of replacing invertebrate with the appropriate branch name. 

We first retrieve the hierarchical directory structure for our desired branch of interest (in this case, invertebrate). 

```bash
lftp -e "find;quit" ftp://ftp.ncbi.nlm.nih.gov/genomes/refseq/invertebrate/ > invertebrate.txt
```

This will include all the main directories, including all genome versions. Although this information may be useful, I am only seeking one genome annotation per species here, the latest version. 

```bash
grep -E "latest_assembly_versions/\w" invertebrate.txt > invertebrate_latest.txt
```

The invertebrate_latest.txt file is the one on which the [code](https://github.com/timlai4/Make_CFG/blob/master/make_cfg.py) is written to search. Note that it fulfills the initially stated goal of pulling one (the latest) genome annotation per species. Then, the script will make one YAML file per species so that when run with fidibus, we will have all YAML files for all species in the branch, as well as a convenient batch script to execute the fidibus tasks simultaneously. 
