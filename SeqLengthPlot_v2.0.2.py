import matplotlib
import matplotlib.pyplot as plt
from Bio import SeqIO
from pathlib import Path
import argparse
import sys

def main():
    # Parse command-line arguments
    parser = argparse.ArgumentParser(description="SeqLengthPlot: Tool for sequence length analysis and visualization.")
    parser.add_argument("-i", "--input", required=True, help="Path to the input FASTA file.")
    parser.add_argument("-o", "--output", help="Directory for output files. Defaults to input file's directory.")
    parser.add_argument("--cutoff", type=int, default=200, help="Length cutoff to split sequences. Default is 200.")
    parser.add_argument("--nt", action="store_true", help="Specify if the input file contains nucleotide sequences (default).")
    parser.add_argument("--prot", action="store_true", help="Specify if the input file contains protein sequences.")
    parser.add_argument("--showplot", action="store_true", help="Display plots interactively (default is disabled).")
    parser.add_argument("--backend", default="TkAgg", help="Set the backend for plotting (default is TkAgg, use 'MacOSX' for Mac users).")

    args = parser.parse_args()

    # Set default to nucleotide sequences if neither --nt nor --prot is provided
    if not args.nt and not args.prot:
        args.nt = True  # Default to --nt

    # Set matplotlib backend
    try:
        matplotlib.use(args.backend)  # Use the backend provided by the user
    except Exception as e:
        print(f"Warning: Could not set the backend to {args.backend}. Using default TkAgg.")
        matplotlib.use("TkAgg")  # Fallback to TkAgg if the provided backend fails

    # Define the input FASTA file and output directory
    input_fasta = args.input
    if args.output:
        output_folder = Path(args.output)
    else:
        output_folder = Path(input_fasta).parent / f"seq_length_{Path(input_fasta).stem}"

    output_folder.mkdir(parents=True, exist_ok=True)

    length_cutoff = args.cutoff  # Set the cutoff for sequence length

    # Adjust file extensions and units based on sequence type
    file_extension = "bp" if args.nt else "aa"  # Defaults to .bp unless --prot is specified
    unit = "bp" if args.nt else "aa"  # Defaults to bp unless --prot is specified
    
    # Output file naming based on the cutoff
    output_file_above = output_folder / f"seq_above{length_cutoff-1}{file_extension}.fasta"
    output_file_below = output_folder / f"seq_below{length_cutoff}{file_extension}.fasta"
    plot_file_above = output_folder / f"seq_length_distribution_above{length_cutoff-1}{file_extension}.png"
    plot_file_below = output_folder / f"seq_length_distribution_below{length_cutoff}{file_extension}.png"
    
    # Corrected file naming for log-scale plots
    plot_log_file_above = output_folder / f"seq_length_distribution_above{length_cutoff-1}{file_extension}_log.png"
    plot_log_file_below = output_folder / f"seq_length_distribution_below{length_cutoff}{file_extension}_log.png"
    
    stats_file = output_folder / f"seq_length_stats_by_cutoff_{length_cutoff}{file_extension}.txt"

    try:
        # Read and process sequences
        length_above_cutoff, length_below_cutoff = [], []
        with open(output_file_above, 'w') as file_above, open(output_file_below, 'w') as file_below:
            for record in SeqIO.parse(input_fasta, "fasta"):
                if len(record.seq) >= length_cutoff:
                    SeqIO.write(record, file_above, "fasta")
                    length_above_cutoff.append(len(record.seq))
                else:
                    SeqIO.write(record, file_below, "fasta")
                    length_below_cutoff.append(len(record.seq))

        # Generate plots and write stats
        plot_length(length_above_cutoff, f'Seq Length Distribution Above {length_cutoff-1} {file_extension}', plot_file_above, args.showplot)
        plot_length(length_below_cutoff, f'Seq Length Distribution Below {length_cutoff} {file_extension}', plot_file_below, args.showplot)
        plot_log_length(length_above_cutoff, f'Log-Scale Distribution Above {length_cutoff-1} {file_extension}', plot_log_file_above, args.showplot)
        plot_log_length(length_below_cutoff, f'Log-Scale Distribution Below {length_cutoff} {file_extension}', plot_log_file_below, args.showplot)
        
        write_stats(stats_file, length_above_cutoff, length_below_cutoff, length_cutoff, unit)

    except Exception as e:
        print(f"An error occurred: {e}")
        sys.exit(1)

def plot_length(data, title, output_path, show_plot):
    plt.figure()
    plt.hist(data, bins=50, color='blue', edgecolor='black', alpha=0.7)
    plt.xlabel('Sequence Length')
    plt.ylabel('Frequency')
    plt.title(title)
    plt.savefig(output_path)
    if show_plot:
        plt.show()  # Show popup if --showplot flag is set
    plt.close()

def plot_log_length(data, title, output_path, show_plot):
    plt.figure()
    plt.hist(data, bins=50, color='green', edgecolor='black', alpha=0.7, log=True)
    plt.xlabel('Sequence Length')
    plt.ylabel('Log Frequency')
    plt.title(title)
    plt.savefig(output_path)
    if show_plot:
        plt.show()  # Show popup if --showplot flag is set
    plt.close()

def write_stats(stats_file, length_above_cutoff, length_below_cutoff, length_cutoff, unit):
    with open(stats_file, 'w') as f:
        f.write(f"Total number of input Sequences = {len(length_above_cutoff) + len(length_below_cutoff)}\n")
        f.write(f"Number of Sequences above {length_cutoff-1} {unit} = {len(length_above_cutoff)}, Min Length = {min(length_above_cutoff, default='N/A')}, Max Length = {max(length_above_cutoff, default='N/A')}\n")
        f.write(f"Number of Sequences below {length_cutoff} {unit} = {len(length_below_cutoff)}, Min Length = {min(length_below_cutoff, default='N/A')}, Max Length = {max(length_below_cutoff, default='N/A')}\n")

if __name__ == "__main__":
    main()
