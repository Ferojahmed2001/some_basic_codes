# Welcome to my research repository
---
I created this repository to showcase some of the codes I have written and used throughout my research projects. Most of these scripts come from my own attempts to understand research methods, learn the underlying theories, and implement them in practice.

Some of my earlier scripts may require refactoring, contain repetitive code, or need adaptation before being applied to new datasets. Although I was less attentive to code organization in the early stages of my research, I developed a strong understanding of the underlying theories, analytical workflows, and rationale behind each step. This allows me to reproduce analyses, troubleshoot methodological issues, and adapt established pipelines to new research questions and datasets.

While developing FlexAutoDock, I started writing structured scripts following practical, team oriented paradigms so others can understand and use them easily. 


## This repository mainly covers two areas of my research:

 - **Transcriptomics and Machine Learning**: Identifying differentially expressed genes, finding potential biomarkers, and investigating molecular relationships between diseases.
 - **Immunoinformatics and Vaccine Design**: Identifying conserved regions and screening potential vaccine candidates against Human Rhinovirus C (HRV-C).
   
The scripts were developed during different research projects, so they are not necessarily designed to work as a single, fully automated pipeline. Please read the description here and understand your data before applying any of them to your own research.

### 1. Transcriptomics Analysis

This section contains scripts from some of my transcriptomics projects, including investigations into the molecular relationships between type 2 diabetes and triple-negative breast cancer (TNBC), as well as type 2 diabetes and hepatitis B virus (HBV) infection.

My work in this area involves collecting and preprocessing gene expression datasets, correcting batch effects, identifying differentially expressed genes, applying machine learning to prioritize important genes, and investigating potential biomarkers.

#### 1.1. Microarray Data Collection and Pre-processing 
##### `micro_array_part_1.ipynb`
This notebook focuses on collecting gene expression data from the Gene Expression Omnibus (GEO) using accession IDs and preparing the data for downstream analysis.
The main steps include:
•	Collecting expression datasets using GEO accession IDs.
•	Mapping probe IDs to official gene symbols.
•	Connecting samples with their corresponding conditions, such as case and control.
•	Handling missing or null values.
•	Managing duplicated gene symbols and combining expression values where necessary.
•	Preparing expression matrices and sample metadata for further analysis.

The exact preprocessing steps depend on the dataset. Different studies may use different probe annotations, sample labels, expression formats, or experimental designs. 
I have tried to automate several repetitive tasks to make the overall procedure easier, but some parts still require manual adjustments.
##### `PyComBat_micro_array_part_2.ipynb:`
This notebook conducts batch-effect correction using PyComBat, to account for variations when combining datasets of multiple studies.

#### 1.2. Differential Gene Expression Analysis
##### `micro_array_part_3.R`
This is another essential part of my transcriptomics pipeline. It uses the limma package in R to perform differential gene expression analysis.
The script is used to identify genes whose expression differs between the groups of interest, such as disease and control samples.
The general workflow includes preparing the expression matrix and experimental design, fitting the statistical model, performing differential expression testing, and obtaining the results for downstream interpretation.
The resulting differentially expressed genes (DEGs) can then be used for further analyses, including biomarker identification, functional enrichment, protein-protein interaction networks, and machine learning.
The design matrix, contrast, and statistical thresholds should be adapted to the specific research question and dataset.

##### `Bayesian_Robust_Inference_of_DEG_part_1.R:`
This script implements identifying differentially expressed genes using a Bayesian robust inference method.
I included this workflow to explore an alternative statistical approach to DEG identification rather than relying exclusively on the conventional limma pipeline.
##### `Bayesian_Robust_Inference_of_DEG_part_2.R:`
This is the second part of the Bayesian robust inference workflow.
It focuses on processing the results from Part 1 and identifying upregulated and downregulated genes according to the criteria used in the analysis.
You should run Part 1 first and ensure that its output files are available before running this script. The filtering criteria and column names may need to be adjusted to match the output format.

#### 1.3. Machine Learning for Important Gene Identification

##### `XGBoost_model_for_each_gene.ipynb:`
This notebook explores a machine-learning approach to identify genes that can distinguish disease samples from normal or control samples.

The idea behind this workflow is to evaluate genes individually and examine how effectively each gene separates the two conditions using an XGBoost-based model.

The general procedure involves preparing the expression data, training and evaluating models for individual genes, and comparing their predictive performance to identify potentially informative features. I used this approach to explore genes that may have diagnostic value.
##### `important_gene_identification_using_SHAP.ipynb:`
This notebook uses machine learning together with SHAP (SHapley Additive exPlanations) to identify important genes.

The main objectives are to:
•	Train a machine-learning model using the gene expression data.
•	Evaluate its ability to distinguish disease from control samples.
•	Calculate SHAP values to interpret feature contributions.
•	Rank genes according to their importance in the trained model.

I have used this general approach alongside limma-based differential expression analysis in my research on potential disease biomarkers, including work associated with my first-author publication.

One important lesson from this work is that finding an important gene in a trained model is only one step toward identifying a reliable biomarker. The findings should be evaluated using independent datasets, appropriate validation strategies, and biological evidence.

##### `key_genes_from_protein_protein_interaction_network_file.ipynb`
This notebook is used when a protein-protein interaction (PPI) network file is available and I want to identify genes that consistently rank highly across different network-topology measures.

### 2. Immunoinformatics and Vaccine Design
 Files under `./VACCINE DESIGN` contains scripts developed during my vaccine-design research targeting Human Rhinovirus C (HRV-C).
Compared with some of my earlier transcriptomics scripts, the codebase in this section are relatively more organized. I developed them to simplify the identification of consensus sequences and conserved regions across HRV-C proteins and to support the screening and evaluation of potential vaccine peptides.
The overall workflow involves processing viral polyprotein sequences, identifying conserved regions, screening candidate B-cell and T-cell epitopes, and evaluating selected peptides across different HRV-C strains.

#### 2.1. Vaccine Protein Sequence Extraction

##### `vaccine_sequence_analysis.ipynb:`
This script extracts individual vaccine-related proteins from HRV-C polyprotein sequences using the accompanying metadata.
Instead of manually identifying and cutting each protein from a polyprotein sequence, I developed this workflow to make the extraction process easier and more consistent.
The main purpose is to connect the protein information in the metadata with the corresponding sequence positions and extract the individual protein sequences for further analysis.
The metadata format, sequence identifiers, and residue coordinates must be checked before applying the script to another viral dataset.

### 2.2. Consensus Sequence and Conserved Region Identification

##### `consensus_to_conserve.ipynb:`

This script identifies consensus sequences and conserved regions across individual HRV-C proteins.
Conserved regions are important in vaccine research because they can help identify candidate epitopes that are shared across multiple viral strains rather than being restricted to a single strain.

The resulting conserved regions can then be used in downstream epitope screening and vaccine-candidate evaluation.

#### 2.3. B-Cell Epitope Screening
##### `beta_cell.ipynb:`
This script screens predicted B-cell epitopes to identify candidate peptides that overlap with the conserved regions identified in the previous steps.
The purpose is to prioritize B-cell epitope candidates that contain conserved sequence regions, which may be useful when designing a vaccine intended to target multiple HRV-C strains.


#### 2.4. Cytotoxic T-Lymphocyte Epitope Screening
##### `CTL.ipynb:`
This script screens cytotoxic T-lymphocyte (CTL) epitopes, also known as MHC class I-restricted T-cell epitopes.
It focuses on identifying candidate CTL peptides that contain or overlap with the conserved regions found in HRV-C proteins.
This step helps prioritize conserved candidates for subsequent immunoinformatics analyses and validation.

#### 2.5. Helper T-Lymphocyte Epitope Screening

##### `HTL.ipynb:`
This script performs a similar screening procedure for helper T-lymphocyte (HTL) epitopes, which are generally associated with MHC class II-restricted antigen presentation. The main goal is to identify candidate helper T-cell peptides that overlap with conserved regions across the selected HRV-C strains. The selected peptides can then be considered alongside other screening criteria during vaccine-candidate selection.

#### 2.6. Cross-Validation Across HRV-C Strains

##### `cross_validate_code.ipynb:`
This script evaluates selected peptide candidates against different HRV-C strains after the preceding screening and validation steps.
The main purpose is to examine whether the selected peptides remain conserved across the strains included in the analysis and to assess their potential relevance when considering viral sequence variation.
This step is particularly important when the objective is to design a vaccine candidate that may cover multiple strains rather than only one reference sequence.
However, sequence conservation alone does not establish vaccine effectiveness against emerging variants. Experimental validation and additional immunological evidence are needed to determine whether the selected candidates generate the intended immune responses.
