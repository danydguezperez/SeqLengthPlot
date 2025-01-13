# Install Python and Dependencies for SeqLenPlot.py on Windows, Linux, and MacOS

## Installation Prerequisites:

- python 3.x

- matplotlib

- biopython

## Step 1: Install Python

## Step 1.1: Install Python on Windows

- Go to the official Python website: Python Downloads [https://www.python.org/downloads/](https://www.python.org/downloads/)

- Click on the "Downloads" tab.

- Scroll down to find the latest version of Python for Windows. It's recommended to choose Python version 3.x.

- Click on the "Download" button for the latest version of Python 3.x for Windows.

- Once the download is complete, double-click the downloaded file to launch the installer.

- In the installer, make sure to check the box that says "Add Python 3.x to PATH".

- Click "Install Now" to begin the installation process.

- Wait for the installation to complete. This may take a few minutes.

- Verify the installation by opening the command prompt and typing:

`python --version`

### Step 1.1.2: Install Required Libraries "matplotlib and Biopython" on Windows

- Once Python is installed:

- Open your command prompt by holding "Windows+R" on your keyboard. Then run:

`cmd`

### Execute the following commands:

`pip install matplotlib pip install biopython`

### Step 1.1.3: Verify Installation on Windows

- After installing the packages:

- Run these commands in your command prompt to verify:

`pip install matplotlib`

`pip install biopython`

### Step 1.1.4:  Verify Dependencies Installation on Windows

- Run these commands in your command prompt to verify dependencies were installed correctly:

`python -c "import matplotlib"`

`python -c "import Bio"`

### Step 1.1.5: Run the SeqLengthPlot.py script

- Change the directory to where you have the SeqLengthPlot.py script and .fasta file.

### Run the script with the following command in your command prompt:

`.\SeqLengthPlot.py`

## step 1.2: Installing on macOS

### 1.2.1: Install Homebrew (if you haven't already):

```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Verify the installation: `brew --version`

After running the above commands, check if Homebrew is now accessible. If return this error `command not found: brew`, then you must **Add Homebrew to your PATH** by running these commands in your terminal:

```
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> /Users/your_user/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"
```

check again the installation: `brew --version`

- Install Python using Homebrew:

`brew install python`

### Verify Installation on macOS
- Verify installation by typing:
`python3 --version`
- Alternatively:
  - Go to the [Python macOS download page](https://www.python.org/downloads/macos/)
  - Download and install Python following the on-screen instructions.

### 1.2.2: Installing Dependencies on macOS
- Open Terminal.
- Install `matplotlib` and `Biopython` using pip:
`pip3 install matplotlib biopython`

### Troubleshooting
- In case of the error: `error: externally-managed-environment...`
- You may restore the old behaviour of pip by passing the `--break-system-packages` flag to pip. For instance by typing:
 ```
 pip3 install matplotlib biopython --break-system-packages
 ```

## step 1.3: Installing on Linux (Ubuntu/Debian)
- Open the terminal.
- Update the package index:
`sudo apt update`

### 1.3.1: Install Python

`sudo apt install python3`

### Installing with Conda on Linux
Open your terminal.
Activate the base conda environment:

`conda activate base`

- Install Python using conda:

```
conda install python=3.x
```

### 1.3.2: Install Required Libraries on Linux
Using pip:
Open Terminal.
Install `matplotlib` and `Biopython`:

`pip3 install matplotlib biopython`

Or using conda:
Activate your conda environment:

`conda activate myenv`

Install libraries:

`conda install matplotlib biopython`

### 1.3.3: Verify Installation on Linux
Start the Python interpreter in the terminal:

`python3`

Import the libraries to check for successful installation. Type:

```
import matplotlib
import Bio
```
**Note**: For troubleshooting or additional installation options, consider searching online or consulting Python's documentation.
