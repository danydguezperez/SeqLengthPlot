# SeqLengthPlot v2.0.2: An All-in-One, Easy-to-Use Tool for Visualizing and Retrieving Sequence Lengths from FASTA Files

**SeqLengthPlot** is an all-in-one, easy-to-use Python-based tool for visualizing and retrieving sequence lengths from FASTA files. It splits sequences by length threshold, generates distribution plots, and provides detailed statistics. The new **SeqLengthPlot v2.0.2** (`SeqLengthPlot_v2.0.2.py`) allows users to fully take advantage of its functionalities through simple and customizable command-line flags.

<div align="center">
<img src=https://github.com/danydguezperez/SeqLengthPlot/blob/main/figures/Picture1.jpg width=40%>
</div>

## New Features in SeqLengthPlot v2.0.2:

- **Command-line flexibility**: You can now specify input files, output directories, sequence types (nucleotide or protein), and backend plotting options via command-line flags.
  
- **Default behavior**: The tool defaults to handling nucleotide sequences (`.bp` extension) unless the `--prot` flag is specified for protein sequences. If no input is provided for certain parameters, the tool will use the following defaults:

## Command-line Flag Update in SeqLengthPlot v2.0.2:
- Changed from `-t` (threshold) to `--cutoff` (current).

### Mandatory Flags:

- `-i` (input file): The path to the input FASTA file (this is required).

### Optional Flags:

- `-o` (output directory): If not provided, a folder is automatically generated in the input file’s directory based on the input FASTA file's name, sequence type, and threshold.
- `--cutoff` (cutoff): The default sequence length cutoff is 200. You can adjust this with the `--cutoff` flag.
- `--nt`: Specifies nucleotide sequences (default behavior).
- `--prot`: Specifies protein sequences (changes file extensions to `.aa`).
- `--showplot`: If this flag is used, plots will be displayed interactively. Otherwise, they are saved but not shown.
- `--backend`: Specify the plotting backend for matplotlib (`TkAgg` for Linux/Windows or `MacOSX` for macOS). The default is `TkAgg`.

## Dependencies:
- **Python 3.x**
- **Matplotlib**
- **Biopython**

## How to Run:
1. After downloading it, 
[SeqLengthPlot_v2.0.2.zip](https://github.com/user-attachments/files/17356697/SeqLengthPlot_v2.0.2.zip)

2. Navigate to the directory where `SeqLengthPlot_v2.0.2.py` is located:
```
   cd /path/to/SeqLengthPlot_v2.0.2.py
```

3. Run the script with the required input file:

``` 
python SeqLengthPlot_v2.0.2.py -i input.fasta
```

>The `-i` flag and the corresponding input.fasta is the only mandatory parameter. If it's not provided, the script will return the following error message:

```
usage: SeqLengthPlot_v2.0.2py [-h] -i INPUT [-o OUTPUT] --cutoff CUTOFF] [--nt] [--prot] [--showplot] [--backend BACKEND]
SeqLengthPlot_v2.0.2.py: error: the following arguments are required: -i/--input
```

## For Help or Command-Line Flags Information:
To get more information on available flags and options, use the `-h` flag:

  ```
python SeqLengthPlot_v2.0.2.py -h
```

This will display the following help message:

``` 
usage: SeqLengthPlot_v2.0.2.py [-h] -i INPUT [-o OUTPUT] [--cutoff CUTOFF] [--nt] [--prot] [--showplot] [--backend BACKEND]

SeqLengthPlot: Tool for sequence length analysis and visualization.

options:
  -h, --help            show this help message and exit
  -i INPUT, --input INPUT
                        Path to the input FASTA file.
  -o OUTPUT, --output OUTPUT
                        Directory for output files. Defaults to input file's directory.
  --cutoff CUTOFF       Length cutoff to split sequences. Default is 200.
  --nt                  Specify if the input file contains nucleotide sequences (default).
  --prot                Specify if the input file contains protein sequences.
  --showplot            Display plots interactively (default is disabled).
  --backend BACKEND     Set the backend for plotting (default is TkAgg, use 'MacOSX' for Mac users).
```

## Example of full command line, including various options you might use when running **SeqLengthPlot v2.0.2**:

```
python SeqLengthPlot_v2.0.2.py -i DeTox_output_Ss_SE_candidate_toxins.fasta -o /path/to/output_directory --cutoff 100 --prot --showplot --backend MacOSX 
```

### Explanation:

- **`-i` input.fasta**: Specifies the input FASTA file (mandatory parameter).
- **`-o` /path/to/output_directory**: Specifies the directory where output files (FASTA, plots, stats) will be saved. If omitted, the files will be saved in the input file's directory.
- **`--cutoff 100`**: Sets the cutoff for sequence length. Sequences will be split based on a length of `100 aa` (amino acids), instead of `200 bp` (base pairs) for nucleotide sequences (default cutoff), since `--prot` is specified in the command line for protein sequences in the input FASTA file.
- **`--prot`**: Specifies that the input file contains **protein sequences**. When this flag is used, output files, plots, legends, and stats will be generated with `.aa` (amino acids) as the unit. If omitted, the default is nucleotide sequences (`--nt`), and the output will use `.bp` (base pairs).
- **``--showplot`**: Displays the plots interactively. If this flag is not included, the plots will be saved but not shown.
- **`--backend MacOSX`**: Specifies the backend for plotting. Use `MacOSX` for macOS users, instead of default `TkAgg`, for Linux/Windows.

### Files Generated:

1.	**FASTA Files:**
-	**seq_above99aa.fasta**: Contains sequences with a length greater than or equal to 100 amino acids.
-	**seq_below100aa.fasta**: Contains sequences with a length less than 100 amino acids.
2.	**Distribution Plots:**
-	**seq_length_distribution_above99aa.png**: A histogram plot showing the distribution of sequence lengths greater than or equal to 100 amino acids.
-	**seq_length_distribution_below100aa.png**: A histogram plot showing the distribution of sequence lengths less than 100 amino acids.
-	**seq_length_distribution_above99aa_log.png**: A log-scale plot showing the distribution of sequence lengths greater than or equal to 100 amino acids.
-	**seq_length_distribution_below100aa_log.png**: A log-scale plot showing the distribution of sequence lengths less than 100 amino acids.
3.	**Statistics File:**
-	**seq_length_stats_by_threshold_100aa.txt**: A text file containing statistics about the sequences, including the total number of sequences, and minimum and maximum sequence lengths for those above and below the threshold.

> Please find enclosed the plots and output files generated as Example_SeqLengthPlot_v2.0.2.zip.
[Example_SeqLengthPlot_v2.0.2.zip](https://github.com/user-attachments/files/17356731/Example_SeqLengthPlot_v2.0.2.zip)

## Key Improvements:

- The introduction of **user-friendly and accessible command-line flags** allows for seamless customization of parameters for specific sequence manipulation tasks—eliminating the need for users to manually modify the code.
- The term `--cutoff` has replaced `-t` (threshold) for a more intuitive and proper description of the sequence length splitting process.
- Improved clarity and organization, particularly in the distinction between **mandatory** and **optional** flags, making the tool easier to navigate.
- The **help section** has been restructured for better readability and ease of understanding, providing users with clear guidance on available options.

### Please Cite as: 

Dany Domínguez-Pérez, Guillermin Agüero-Chapin, Serena Leone, Maria Vittoria Modica, SeqLengthPlot v2.0: an all-in-one, easy-to-use tool for visualizing and retrieving sequence lengths from FASTA files, Bioinformatics Advances, Volume 5, Issue 1, 2025, vbae183, [https://doi.org/10.1093/bioadv/vbae183](https://doi.org/10.1093/bioadv/vbae183)
