Welcome to my research repository!

I created this repository to showcase some of the codes I have written and used throughout my research projects. Most of these scripts come from my own attempts to understand research methods, learn the underlying theories, and implement them in practice.

I want to be honest about something: I am not an organized coder. Some of my scripts may look messy, contain repetitive steps, or require adjustments before they can be used with another dataset. However, I understand the theories and analytical pipelines behind the methods I use, and I can reproduce the analyses because I know how the different steps work and why they are necessary.

While developing FlexAutoDock, I started writing code in a more organized way so that other people could easily follow and understand it. Since then, I have been continuously trying to make my workflows easier to follow and reproduce. I am sharing these codes to give others a glimpse of my coding skills and how I translate theoretical knowledge into practical implementations through coding.

This repository mainly covers two areas of my research:
   Transcriptomics and machine learning: Identifying differentially expressed genes, finding potential biomarkers, and investigating molecular relationships between diseases.
   Immunoinformatics and vaccine design: Identifying conserved regions and screening potential vaccine candidates against Human Rhinovirus C (HRV-C).
The codes were developed during different research projects, so they are not necessarily designed to work as a single, fully automated pipeline. Please read the descriptions and understand your data before applying any of them to your own research.

1. Transcriptomics Analysis
This section contains scripts from some of my transcriptomics projects, including investigations into the molecular relationships between type 2 diabetes and triple-negative breast cancer (TNBC), as well as type 2 diabetes and hepatitis B virus (HBV) infection.
My work in this area involves collecting and preprocessing gene expression datasets, correcting batch effects, identifying differentially expressed genes, applying machine learning to prioritize important genes, and investigating potential biomarkers.

1.1. Microarray Data Collection and Preprocessing

micro_array_part_1.ipynb:

Start here if you want to understand how I collect and prepare microarray datasets.
This is one of the essential scripts in my transcriptomics workflow. It focuses on collecting gene expression data from the Gene Expression Omnibus (GEO) using accession IDs and preparing the data for downstream analysis.
The main steps include:
•	Collecting expression datasets using GEO accession IDs.
•	Mapping probe IDs to official gene symbols.
•	Connecting samples with their corresponding conditions, such as case and control.
•	Handling missing or null values.
•	Managing duplicated gene symbols and combining expression values where necessary.
•	Preparing expression matrices and sample metadata for further analysis.

The exact preprocessing steps depend on the dataset. Different studies may use different probe annotations, sample labels, expression formats, or experimental designs. Therefore, it is important to understand the structure of your data before applying these codes.
I have tried to automate several repetitive tasks to make the overall procedure easier, but some parts still require manual adjustments.

PyComBat_micro_array_part_2.ipynb:

This script focuses on batch-effect correction using PyComBat.
When combining microarray datasets from different studies, technical differences between experiments can introduce unwanted variation. Batch correction helps reduce these technical differences so that datasets can be analyzed together more appropriately.
The main purpose of this script is to:
•	Combine expression matrices from different datasets.
•	Apply batch-effect correction using PyComBat.
•	Maintain sample information and condition labels.
•	Prepare the corrected expression data for downstream statistical analysis.

Although the general procedure is similar across projects, the dataset names, batch labels, sample metadata, and expression matrices need to be adjusted according to the data being analyzed.
Important: Batch correction does not automatically eliminate every source of bias. The study design, batch structure, and possible confounding between batch and biological condition must be considered before applying it.

1.2. Differential Gene Expression Analysis

micro_array_part_3.R:

This is another essential part of my transcriptomics pipeline. It uses the limma package in R to perform differential gene expression analysis.
The script is used to identify genes whose expression differs between the groups of interest, such as disease and control samples.
The general workflow includes preparing the expression matrix and experimental design, fitting the statistical model, performing differential expression testing, and obtaining the results for downstream interpretation.
The resulting differentially expressed genes (DEGs) can then be used for further analyses, including biomarker identification, functional enrichment, protein–protein interaction networks, and machine learning.
The design matrix, contrast, and statistical thresholds should be adapted to the specific research question and dataset.

Bayesian_Robust_Inference_of_DEG_part_1.R:

This script implements another approach to identifying differentially expressed genes using a Bayesian robust inference method.
I included this workflow to explore an alternative statistical approach to DEG identification rather than relying exclusively on the conventional limma pipeline.
The script contains the main steps needed to perform the analysis. Please check the code and its associated method carefully to understand the assumptions, inputs, and outputs before applying it to another dataset.

Bayesian_Robust_Inference_of_DEG_part_2.R:

This is the second part of the Bayesian robust inference workflow.
It focuses on processing the results from Part 1 and identifying upregulated and downregulated genes according to the criteria used in the analysis.
You should run Part 1 first and ensure that its output files are available before running this script. The filtering criteria and column names may need to be adjusted to match the output format.


1.3. Machine Learning for Important Gene Identification

XGBoost_model_for_each_gene.ipynb:

This script explores a machine-learning approach to identify genes that can distinguish disease samples from normal or control samples.
The idea behind this workflow is to evaluate genes individually and examine how effectively each gene separates the two conditions using an XGBoost-based model.
The general procedure involves preparing the expression data, training and evaluating models for individual genes, and comparing their predictive performance to identify potentially informative features.
I used this approach to explore genes that may have diagnostic value. However, a gene's ability to distinguish two groups does not automatically mean that it causes the disease or is a reliable biomarker in other populations.
If you want to use another machine-learning algorithm, you will need to modify the modeling and evaluation steps accordingly.

important_gene_identification_using_SHAP.ipynb:

This script uses machine learning together with SHAP (SHapley Additive exPlanations) to identify important genes.
Unlike the previous script, where genes are evaluated individually, this approach trains a model using multiple genes together and uses SHAP to investigate how individual features contribute to the model's predictions.
The main objectives are to:
•	Train a machine-learning model using the gene expression data.
•	Evaluate its ability to distinguish disease from control samples.
•	Calculate SHAP values to interpret feature contributions.
•	Rank genes according to their importance in the trained model.
I have used this general approach alongside limma-based differential expression analysis in my research on potential disease biomarkers, including work associated with my first-author publication.
One important lesson from this work is that finding an important gene in a trained model is only one step toward identifying a reliable biomarker. The findings should be evaluated using independent datasets, appropriate validation strategies, and biological evidence.
key_genes_from_protein_protein_interaction_network_file.ipynb
This script is used when a protein–protein interaction (PPI) network file is available and I want to identify genes that consistently rank highly across different network-topology measures.
The general idea is to rank genes using multiple topological metrics and identify genes that perform consistently across those measures.
This can help prioritize candidate genes for further investigation rather than relying on a single network metric.
The input file format, network structure, and available topological measures may differ between projects, so the code may require adjustments.

2. Immunoinformatics and Vaccine Design
   
This folder contains codes developed during my vaccine-design research targeting Human Rhinovirus C (HRV-C).
Compared with some of my earlier transcriptomics scripts, the codes in this section are relatively more organized. I developed them to simplify the identification of consensus sequences and conserved regions across HRV-C proteins and to support the screening and evaluation of potential vaccine peptides.
The overall workflow involves processing viral polyprotein sequences, identifying conserved regions, screening candidate B-cell and T-cell epitopes, and evaluating selected peptides across different HRV-C strains.

2.1. Vaccine Protein Sequence Extraction

vaccine_sequence_analysis.ipynb:
This script extracts individual vaccine-related proteins from HRV-C polyprotein sequences using the accompanying metadata.
Instead of manually identifying and cutting each protein from a polyprotein sequence, I developed this workflow to make the extraction process easier and more consistent.
The main purpose is to connect the protein information in the metadata with the corresponding sequence positions and extract the individual protein sequences for further analysis.
The metadata format, sequence identifiers, and residue coordinates must be checked before applying the script to another viral dataset.
2.2. Consensus Sequence and Conserved Region Identification

consensus_to_conserve.ipynb:
This script identifies consensus sequences and conserved regions across individual HRV-C proteins.
Conserved regions are important in vaccine research because they can help identify candidate epitopes that are shared across multiple viral strains rather than being restricted to a single strain.
The script was developed to support the identification of these regions from aligned protein sequences.
The resulting conserved regions can then be used in downstream epitope screening and vaccine-candidate evaluation.
Please make sure that the sequences are correctly aligned and that the strain identifiers are consistent before interpreting the results.

2.3. B-Cell Epitope Screening

beta_cell.ipynb:

This script screens predicted B-cell epitopes to identify candidate peptides that overlap with the conserved regions identified in the previous steps.
The purpose is to prioritize B-cell epitope candidates that contain conserved sequence regions, which may be useful when designing a vaccine intended to target multiple HRV-C strains.
The script depends on the format of the epitope prediction results and the representation of conserved regions, so those inputs should be checked before running the analysis.

2.4. Cytotoxic T-Lymphocyte Epitope Screening

CTL.ipynb:

This script screens cytotoxic T-lymphocyte (CTL) epitopes, also known as MHC class I-restricted T-cell epitopes.
It focuses on identifying candidate CTL peptides that contain or overlap with the conserved regions found in HRV-C proteins.
This step helps prioritize conserved candidates for subsequent immunoinformatics analyses and validation.

2.5. Helper T-Lymphocyte Epitope Screening

HTL.ipynb:

This script performs a similar screening procedure for helper T-lymphocyte (HTL) epitopes, which are generally associated with MHC class II-restricted antigen presentation.
The main goal is to identify candidate helper T-cell peptides that overlap with conserved regions across the selected HRV-C strains.
The selected peptides can then be considered alongside other screening criteria during vaccine-candidate selection.

2.6. Cross-Validation Across HRV-C Strains

cross_validate_code.ipynb:

This script evaluates selected peptide candidates against different HRV-C strains after the preceding screening and validation steps.
The main purpose is to examine whether the selected peptides remain conserved across the strains included in the analysis and to assess their potential relevance when considering viral sequence variation.
This step is particularly important when the objective is to design a vaccine candidate that may cover multiple strains rather than only one reference sequence.
However, sequence conservation alone does not establish vaccine effectiveness against emerging variants. Experimental validation and additional immunological evidence are needed to determine whether the selected candidates generate the intended immune responses.

3. A Few Things to Keep in Mind
   
Before using any of these scripts in your own research, please keep the following points in mind.
•	Understand your data first. The same code will not necessarily work for every dataset. Accession IDs, sample labels, probe annotations, sequence formats, and output columns may differ.
•	Read the pipeline, not just the code. I usually begin by understanding the method and then implement the steps. Knowing why a step is required makes it much easier to modify the script when something changes.
•	Check the assumptions of each method. Statistical models, batch correction, machine learning, and epitope screening all have their own assumptions and limitations.
•	Validate important findings. Genes prioritized by differential expression or machine learning should be assessed using independent data and biological evidence. Similarly, computational vaccine candidates require further immunological and experimental evaluation.
•	Treat these scripts as research workflows. Some files may need debugging, cleanup, or modification before they can be used directly. They are shared as a record of my research and as a starting point for others working on similar problems.
5. My Goal for This Repository
I am sharing these codes because I believe that learning research methods is not only about understanding the theory but also about implementing it, making mistakes, troubleshooting, and gradually improving the workflow.
I am still learning how to write cleaner, more modular, and more reproducible code. I hope to improve these scripts over time as I gain more experience.
If you are a student or researcher working on transcriptomics, machine learning, bioinformatics, or immunoinformatics, I hope you may find something useful here.
Thank you for visiting my repository!

