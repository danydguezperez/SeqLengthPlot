# 📊 SeqLengthPlot v2.0 — Shiny App (R Version)

This folder contains the **interactive R Shiny implementation** of [SeqLengthPlot v2.0](https://doi.org/10.1093/bioadv/vbae183), a tool originally developed as a Python CLI for FASTA sequence analysis and visualization.

> ✅ This version replicates the Python tool's features with an intuitive graphical interface, making it accessible for users with little or no coding experience.
> 
🌐 Running Online (ShinyApps.io) 
You can also explore the app hosted online 👉 [https://danysaurio.shinyapps.io/seqlengthplot/](https://danysaurio.shinyapps.io/seqlengthplot/)

---

## 🔍 Overview

The **Shiny version** allows users to:

- Upload **DNA or protein FASTA** files
- Set a **length cutoff** to split sequences into:
  - Above cutoff
  - Below cutoff
- Visualize sequence length distributions as:
  - Histograms (linear and log scale)
  - Exportable in **PNG**, **PDF**, and **SVG**
- Download:
  - Summary statistics (.txt)
  - Split FASTA files (above/below cutoff)
  - Plot bundles (.zip)
- Customize histogram **color palette**

---

## 🚀 Running the App Locally

To launch the app locally from R or RStudio:

1. Clone or download the repository:

```
git clone https://github.com/danydguezperez/SeqLengthPlot.git
```

Open R or RStudio and set the working directory to the SeqLengthPlot.shiny/ folder.

- Run the app using:

```
shiny::runApp("SeqLengthPlot.shiny")
```

💡 The example FASTA file DeTox_output_Ss_SE_candidate_toxins.fasta is included for demo purposes.

📎 Notes
The Shiny app is equivalent in logic and output to the Python CLI version.


>It is especially useful for educational or demo use cases where interactivity is desired.

>Processing large FASTA files may be better suited for the command-line tool.

🔗 Related Resources
🐍 Python CLI version: github.com/danydguezperez/SeqLengthPlot

📄 Original publication: Bioinformatics Advances (2025)

### Please Cite as: 

Dany Domínguez-Pérez, Guillermin Agüero-Chapin, Serena Leone, Maria Vittoria Modica, SeqLengthPlot v2.0: an all-in-one, easy-to-use tool for visualizing and retrieving sequence lengths from FASTA files, Bioinformatics Advances, Volume 5, Issue 1, 2025, vbae183, [https://doi.org/10.1093/bioadv/vbae183](https://doi.org/10.1093/bioadv/vbae183)

💬 Contact: [LinkedIn](https://www.linkedin.com/in/dany-dominguez-perez/) or [X (Twitter)](https://x.com/danydguezperez)
