# Description 

This toll is used to identify promoter regions using “Cap Analysis of Gene Expression” (CAGE) data. It involves multiple steps that are explained below. Data for testing the tools is provided in demodata folder.

## Identification of CTSS

All the unique 5' ends of the first read (R1) of the read pair represent a CAGE-defined TSS (CTSS). This tool generates a count for each position representing a number of unique tags starting from that position. This tool takes bed file generated using bamTobed as an input.

````
perl getCtss.pl <Input_sample1.bed> > <output_sample1.ctss>

For example

perl getCtss.pl test_sample1.bed > test_sample1.ctss
````

## Filter CTSS
A tool to filter CTSS positions based on minimum number of CAGE tags and the number of samples. For example, to extract the positions where minimum one tag was observed in at least three samples. 

```
perl filter.pl <input.ctss> > <output_flt.ctss>

For example

perl filter.pl test.ctss 1 3 > test_flt.ctss
```

## Identification of tag clusters (TC)

Tool to identify tag clusters using filtered CTSS data. 

````
perl generateTagCluster.pl <input_flt.ctss> > <output.tc>

For example

perl generateTagCluster.pl test_flt.ctss >  test.tc
````

## Normalisation to TPM

To convert raw tag counts to the TPM normalised tag counts 

````
perl normalise.pl <input.tc> > <output_norm.tc>

For example

perl normalise.pl test.tc > test_norm.tc
````

## Filtering normalised TC

A tool to filter TC based on TPM and the number of samples. For example, to extract the TCs with one TPM expression in at least three samples. 

````
perl filterNorm.pl <input.tc> <TPM> <number of samples> > <output_flt.tc>

For example

perl filterNorm.pl test_norm.tc 1 3 > test_norm_flt.tc
````


