# SeqLengthPlot
An easy-to-use Python-based Tool for Visualizing and Retrieving Sequence Lengths from fasta files with a Tunable Splitting Point

## Authors
-	Dany Domínguez Pérez (danydguezperez@gmail.com)
-	Maria Vittoria Modica (mariavittoria.modica@szn.it)
-	Collaborators of the DEEPVEN project - Characterizing the Diversity and Activity of Venoms of deep-sea Anthozoans

## SeqLengthPlot.py

<div align="center">
<img src=https://github.com/danydguezperez/SeqLengthPlot/blob/main/figures/fig_1.png width=80%>
</div>

- **Tool Description**
SeqLengthPlot.py version 1.0 is a straightforward Python-based script tailored for enhancing sequence length profiling. This script processes sequence data from a FASTA file to categorize and analyze transcript lengths. It generates histograms for transcript lengths above and below a specified threshold, offering both linear and logarithmic views and provides statistical summaries of these distributions. The script also offers the flexibility to display or suppress plot pop-ups, making it suitable for both interactive analysis and automated pipelines.

- **Applications**
SeqLengthPlot is particularly valuable in scenarios where researchers need to verify the length distribution of assembled transcripts and translated ORFs for subsequent proteomic and peptidomic studies using the sequence length as a reference point, length-based filtering and splitting of a nucelotide or protein FASTA file, as well as the automatically recovering of the sequences contained in the resulting splitted FASTA files.

- **Compatibility**
This tool is compatible with Unix and Windows Operating System (OS).

## Installation Prerequisites to run SeqLenPlot.py on Windows, Linux, and MacOS

- To run SeqLengthPlot.py, ensure you have an updated version of Python installed: 
`python 3.x`
- Additional libraries: matplotlib, Biopython, and Pathlib for plotting and sequence manipulation:

`matplotlib`
`biopython`

For detailed instructions and tips on installing Python and dependencies in different configurations, refer to [Comprehensive_Installation_Prerequisites_Guide](https://github.com/danydguezperez/SeqLengthPlot/blob/main/Install_Prerequisites_Guide/Comprehensive_Installation_Prerequisites_Guide.md).

- Download the SeqLengthPlot.py script from https://github.com/danydguezperez/SeqLengthPlot and place it in a folder containing your input FASTA file. Open the script with a text editor and set the required parameters:
  
**Input files**

The script reads sequences from a specified nucleotide or protein FASTA file, which must be present in the directory where the script is run or provided via an absolute path. As an example, we provide an original nucleotide sample: [Assembly_Ss_SE.Trinity.fasta.zip](https://github.com/danydguezperez/SeqLengthPlot/blob/main/Assembly_Ss_SE.Trinity.fasta.zip). Download it and decompress it, in the same path of the SeqLengthPlot.py script.

**Statement**: The input file "**Assembly_Ss_SE.Trinity.fasta**" provided as an example data, constitutes original single-end transcriptome from broken reads of [*Savalia savaglia*](https://en.wikipedia.org/wiki/Savalia_savaglia), generated in the framework of the DEEPVEN project.

**Parameters**

-	**Define Path**: At **input_fasta = "Assembly_Ss_SE.Trinity.fasta"**, modify the path by replacing the default “**input_fasta**” file with "**your_path_or_your_input_fasta**".
-	**Define the Sequence length**: At **length_threshold = 200**  (default length), set the threshold for your desired length cutoff.
-	**Changing Output Path to home**: Users can comment out the defaults path output_folder = Path(input_fasta).parent / and uncomment (by removing the #) at the line **output_folder = Path.home() / "transcript_length_outputs"** to save the generated output-files in the home directory instead.

<div align="center">
<img src=https://github.com/danydguezperez/SeqLengthPlot/blob/main/figures/parameters_1.png width=80%>
</div>


-	**Interactive Plots**: Users can explore interactively the generated plots and save them into differents image formats

<div align="center"> 
<img src=https://github.com/danydguezperez/SeqLengthPlot/blob/main/figures/fig_2.png width=80%>
</div>


-	 **Pipeline integration**: Or instead, comment out the **plt.show()** line to prevent plots from popping up. This is especially useful when integrating the script into automated data processing pipelines where no user interaction is desired. Plots will be saved anyway in the selected output directory.


<div align="center">
<img src=https://github.com/danydguezperez/SeqLengthPlot/blob/main/figures/parameters_2.png width=70%>
</div>

## Running the script

Navigate to the folder containing **SeqLengthPlot.py** in the terminal or Command Prompt using the **cd** command. 
Then, execute the script in Unix systems by typing:

`python3 SeqLengthPlot.py`

and in Windows:

`.\SeqLengthPlot.py`

The script will generate files and plots automatically in a new folder named after your **input.fasta** file. If you encounter a "Warning: The system version of Tk is deprecated" message while plotting on MacOS, edit the script to switch the default backend from **matplotlib.use('TkAgg')** to **'MacOSX'** for interactive plots.

**Outputs files (using sequence length=200bp by default)**

-	Fasta Files: Two fasta files ([**seq_above199bp.fasta**](https://github.com/danydguezperez/SeqLengthPlot/blob/main/seq_length_Assembly_Ss_SE.Trinity/seq_above199bp.fasta.zip) and [**seqs_below200bp.fasta**](https://github.com/danydguezperez/SeqLengthPlot/blob/main/seq_length_Assembly_Ss_SE.Trinity/seq_below200bp.fasta)), splitted and retrieved from the orginal [input_fasta](https://github.com/danydguezperez/SeqLengthPlot/blob/main/Assembly_Ss_SE.Trinity.fasta.zip) file categorizing sequences based on the length threshold.

-	**Histogram Plots**: Four PNG files showing histograms of sequence lengths. Two are in linear scale ([**seq_length_distribution_above199bp.png**](https://github.com/danydguezperez/SeqLengthPlot/blob/main/seq_length_Assembly_Ss_SE.Trinity/seq_length_distribution_above199_log.png) and [**seq_length_distribution_below200bp.png**](https://github.com/danydguezperez/SeqLengthPlot/blob/main/seq_length_Assembly_Ss_SE.Trinity/seq_length_distribution_below200bp.png)), and two are in log scale ([**seq_length_distribution_above199bp_log.png**](https://github.com/danydguezperez/SeqLengthPlot/blob/main/seq_length_Assembly_Ss_SE.Trinity/seq_length_distribution_above199_log.png) and [**seqs_length_distribution_below200bp_log.png**](https://github.com/danydguezperez/SeqLengthPlot/blob/main/seq_length_Assembly_Ss_SE.Trinity/seq_length_distribution_below200_log.png)).

-	**Statistical Summary**: A text file ([**seq_length_stats_by_threshold_200.txt**](https://github.com/danydguezperez/SeqLengthPlot/blob/main/seq_length_Assembly_Ss_SE.Trinity/seq_length_stats_by_threshold_200.txt)) containing detailed statistics of the sequence lengths on the [input_fasta](https://github.com/danydguezperez/SeqLengthPlot/blob/main/Assembly_Ss_SE.Trinity.fasta.zip): Total number of input Sequences, Number of Sequences above 199 bp and below 200 bp, with the corresponding minimm and maximum lengths.
  
## Remarks

-	**Comprehensive Metrics and Output**: Unlike seqkit stats, or TrinityStats.pl, SeqLengthPlot offers in a single tool the total number of sequences, minimum, maximum, of the input and splitted files, as well as the resulting FASTA files, containing the corresponding sequences length below and above the cuttoff.
-	**Visual Analysis**: It generates intuitive plots for sequence length distributions, offering both linear and logarithmic views to accommodate a wide range of sequence lengths, enhancing data interpretation. 
-	**Flexible Threshold Settings**: The tool allows users to set custom length thresholds, crucial for tasks such as validating de novo transcriptome assemblies or analyzing protein-coding regions in ORFs, peptidomics and bioactive peptides biodiscovery which may require different length criteria.
-	**Ease of Integration**: Designed for flexibility, it can be seamlessly run independently as a standalone script, or incorporated into larger bioinformatics workflows, supporting both interactive explorations and automated pipelines.

