# Development of a High-Affinity Peptidomimetic Inhibitor Targeting SARS-CoV Main Protease (Mpro)

<img width="1450" height="621" alt="Screenshot 2026-06-29 112708" src="https://github.com/user-attachments/assets/98692676-68b7-4cd2-80be-07fddd747ec0" />
<img width="1000" height="624" alt="Screenshot 2026-06-29 113038" src="https://github.com/user-attachments/assets/6b6aa200-e0f0-47fd-8ac5-c0edd73cc786" />
<img width="1563" height="627" alt="Screenshot 2026-06-29 114458" src="https://github.com/user-attachments/assets/f2bf078e-5b36-41b8-866c-dade29a898d0" />


Our multi-stage pipeline successfully identified and optimized an advanced peptidomimetic lead candidate derived from the parent scaffold CHEMBL5565685:
CC1(C)[C@@H]2[C@@H](C(=O)N[C@H](C=O)C[C@@H]3CCNC3=O)N(C(=O)C3(c4cccc(C(F)(F)F)c4)CC3)C[C@@H]21



> **An end-to-end computational drug discovery pipeline integrating cheminformatics, QSAR machine learning, molecular docking, and automated bioisosteric optimization for SARS-CoV Main Protease (Mpro).**

---

# Project Overview

This project presents a computational workflow for discovering and optimizing a novel peptidomimetic inhibitor targeting the **SARS-CoV Main Protease (Mpro / 3CLpro)**.

The pipeline combines:

* ChEMBL bioactivity mining
* Molecular descriptor generation
* QSAR machine learning
* Structure-based virtual screening
* Automated bioisosteric optimization
* ADMET filtering

to identify candidates with improved predicted binding affinity while maintaining drug-like properties.

---

# Disease Background

SARS-CoV relies on its **Main Protease (Mpro)** to process viral polyproteins into functional non-structural proteins required for viral replication.

```
Viral RNA
      │
      ▼
Polyproteins (pp1a / pp1ab)
      │
      ▼
      Mpro
      │
      ▼
Functional Viral Proteins
      │
      ▼
Virus Replication
```

Unlike human proteases, Mpro specifically recognizes peptide substrates containing **Glutamine at the P1 position**, making it an attractive antiviral drug target with reduced risk of host toxicity.

---

# Current Clinical Standard

Current oral antiviral therapy is based on **Paxlovid**, consisting of:

```
Paxlovid
├── Nirmatrelvir
│      Active SARS-CoV Mpro inhibitor
│
└── Ritonavir
       CYP3A4 inhibitor
       Metabolic booster
```

## Current Cost

| Market          | Approximate Cost |
| --------------- | ---------------: |
| United States   |      ~$1,400 USD |
| India (Generic) |    ₹5,000–₹8,000 |

Although generic formulations have reduced costs, treatment remains financially challenging for many populations.

---

# Lead Candidate

The computational pipeline identified an optimized peptidomimetic derived from the parent scaffold:

**CHEMBL5565685**

```
Peptidomimetic Backbone
        │
        ├── Aldehyde Warhead
        │
        ├── Pyrrolidone Ring
        │
        └── meta-CF3 Phenyl Group
```

## Key Structural Features

### Aldehyde Warhead

* Covalent interaction with catalytic cysteine
* Increased binding affinity

---

### Pyrrolidone Ring

Acts as a **P1 glutamine mimic**, reproducing the natural substrate recognition of Mpro.

---

### meta-Trifluoromethyl Phenyl Ring

Obtained through automated bioisosteric optimization.

```
Parent

meta-Cl

↓

Bioisosteric Replacement

↓

meta-CF3
```

The CF3 substitution produced the strongest predicted affinity.

---

# Why This Design Could Reduce Treatment Cost

## 1. Simplified Chemical Synthesis

Unlike Nirmatrelvir, which requires construction of a rigid bicyclic scaffold, the proposed molecule uses a more linear peptidomimetic framework.

Advantages include:

* Modular synthesis
* Solid-Phase Peptide Synthesis (SPPS)
* Convergent fragment coupling
* Commercially available building blocks

Estimated reduction in API manufacturing cost:

> **60–70%**

---

## 2. Potential Ritonavir Independence

The CF3 substitution improved predicted binding energy from

```
−6.32 kcal/mol

↓

−7.32 kcal/mol
```

The increased hydrophobicity and electron-withdrawing character may also improve metabolic stability.

Potential advantages include:

* Reduced CYP-mediated metabolism
* Longer target residence time
* Elimination of Ritonavir co-administration
* Reduced drug–drug interactions
* Simplified formulation

---

## 3. Ambient Stability

Unlike biologics requiring cold-chain logistics, this molecule is a conventional small molecule.

**Properties**

| Property         | Value               |
| ---------------- | ------------------- |
| Molecular Weight | 471.99 g/mol        |
| Formulation      | Oral Tablet         |
| Storage          | Ambient Temperature |

This substantially lowers distribution and storage costs.

---

# Computational Workflow

```
            ChEMBL Bioactivity Mining
                     │
                     ▼
          Molecular Standardization
                     │
                     ▼
          Lipinski / ADMET Filtering
                     │
                     ▼
     Morgan Fingerprint Generation
                     │
                     ▼
       LightGBM QSAR Model Training
                     │
                     ▼
        Structure-Based Docking
                     │
                     ▼
      Automated Bioisosteric Search
                     │
                     ▼
         Optimized Lead Candidate
```

---

# Methodology

## 1. ChEMBL Data Mining

* Bioactivity retrieval using `chembl_webresource_client`
* IC50 extraction
* SMILES standardization
* Duplicate removal
* Invalid structure detection

---

## 2. Drug-Likeness Filtering

Compounds were filtered using:

* Lipinski Rule of Five
* Molecular weight
* Hydrogen bond donors
* Hydrogen bond acceptors
* Rotatable bonds
* Structural validity

---

## 3. QSAR Machine Learning

Molecules were encoded using:

```
RDKit Morgan Fingerprints

Radius = 2

Bits = 2048
```

Model:

```
LightGBM Regressor
```

Training split:

```
80%

↓

Training

20%

↓

Testing
```

Target variable:

[
pIC_{50}=-\log_{10}(IC_{50}\times10^{-9})
]

The trained QSAR model ranked compounds based on predicted potency prior to docking.

---

## 4. Protein Preparation

Protein structure:

```
PDB ID: 6LU7
```

Preparation steps:

* Remove crystallographic water
* Remove ions
* Remove co-crystallized ligands
* Add polar hydrogens
* Assign Gasteiger charges
* Convert to PDBQT

Tools:

* Open Babel
* Meeko

---

## 5. Dynamic Docking

To eliminate manual bias, docking grids were generated automatically.

Grid center:

[
Center_i=\frac{Max_i+Min_i}{2}
]

Grid size:

[
Size_i=(Max_i-Min_i)+12\AA
]

Docking engine:

```
AutoDock Vina
```

Exhaustiveness:

```
8
```

---

## 6. Automated Bioisosteric Optimization

SMARTS reaction templates generated systematic substitutions.

Evaluated substituents:

* Fluorine
* Methyl
* Hydroxyl
* Nitrile
* Trifluoromethyl

Pipeline:

```
Parent Molecule
       │
       ▼
SMARTS Mutation
       │
       ▼
3D Embedding
       │
       ▼
MMFF94 Optimization
       │
       ▼
AutoDock Vina
       │
       ▼
Binding Energy Ranking
```

---

# Results

| Variant          | Docking Score (kcal/mol) |
| ---------------- | -----------------------: |
| Parent (meta-Cl) |                    -6.32 |
| meta-F           |                Evaluated |
| meta-CH3         |                Evaluated |
| meta-OH          |                Evaluated |
| meta-CN          |                Evaluated |
| **meta-CF3**     |                **-7.32** |

**Predicted improvement:** **1.0 kcal/mol**

The **meta-CF3** analogue emerged as the top-performing bioisosteric replacement.

---

# Technologies Used

### Cheminformatics

* RDKit
* ChEMBL API

### Machine Learning

* LightGBM
* Scikit-learn

### Molecular Docking

* AutoDock Vina
* Meeko
* Open Babel

### Scientific Computing

* Python
* NumPy
* Pandas

---

# Repository Structure

```text
.
├── data/
│   ├── chembl_dataset.csv
│   └── processed_data.csv
│
├── models/
│   └── lightgbm_qsar.pkl
│
├── docking/
│   ├── receptor.pdbqt
│   ├── ligands/
│   └── vina_results/
│
├── notebooks/
│   └── Computational_Drug_Discovery.ipynb
│
├── scripts/
│   ├── data_mining.py
│   ├── qsar.py
│   ├── docking.py
│   └── bioisostere.py
│
└── README.md
```

---

# Key Findings

* Automated discovery of a high-affinity peptidomimetic SARS-CoV Mpro inhibitor.
* Bioisosteric optimization identified a **meta-CF3 substitution** as the best-performing analogue.
* Predicted docking affinity improved from **−6.32** to **−7.32 kcal/mol**.
* Linear peptidomimetic architecture may reduce synthetic complexity compared with Nirmatrelvir.
* The workflow demonstrates an integrated AI-assisted computational drug discovery pipeline combining QSAR, virtual screening, and automated molecular optimization.

---

# Limitations

This work is **computational only**. Docking scores and QSAR predictions are hypothesis-generating and **do not establish efficacy, safety, pharmacokinetics, or clinical benefit**. Experimental validation—including biochemical enzyme inhibition assays, cell-based antiviral studies, ADME profiling, toxicity evaluation, and ultimately in vivo testing—would be required before any therapeutic conclusions can be drawn.
