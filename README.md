### Innovation Pipeline

# Getting Started

Note: These steps are preliminary, and are waiting on consolidation of certain dependencies. Moving to docker containers is the long term solution for this. Some of these dependencies have been aggregated in the `/vendor_tools` folder, but for now these additional dependencies must be explicitly installed:
  - Samtools
  - Trimgalore
  - Java 7
  - Java 8
  - Python
  - BWA
```
If on mac, can be installed with homebrew:
> brew install homebrew/science/bwa/versions/0.7.12
> brew install homebrew/science/bwa
```
  - Perl
```
> curl -L https://install.perlbrew.pl | bash
> perlbrew install perl-5.20.2 (might need to try with --notest if install fails)
> source ~/perl5/perlbrew/etc/bashrc
 ```
- HG19 Reference fasta + fai

Note 2: Paths to the tools that are used by the cwl files will need to be manually updated (relative paths aren't an option in `basecommand`)


# Setup

### 1. Set up a Virtual Environment
Make virtualenv with the name of your virtual environment for this project, e.g. innovation-pipeline
```
$ virtualenv ~/innovation_pipeline
$ source ~/innovation_pipeline/bin/activate
```

### 2. Copy the repository and Install the python tools
(Make sure your virtualenv is active)
(We hope to allow this repo to be cloned from Github once test data storage is confirmed)
```
(innovation_pipeline) ~/Innovation-Pipeline$ python setup.py install
```

### 3. Update the paths to the tool resources in `/resources/production`

### 4. Set the root directory of the project
```
ROOT_DIR = '/Users/johnsoni/Desktop/code/Innovation-Pipeline'
```

### 5. Create a run title file from a sample manifest (example manifest exists in /test/test_data)
```
(innovation_pipeline) ~/Innovation-Pipeline$ create_title_file_from_manifest -i ./manifest.xls -o title_file.txt
```

### 6. Create an inputs file from the title file
This step will create a file `inputs.yaml`, and pull in the run parameters (-t for test params) and paths to run files from step 5.
```
(innovation_pipeline) ~/Innovation-Pipeline$ create_inputs_from_title_file -i ./test_title_file.txt -d test-data/start -t
```

### 7. Run the test pipeline
To run with the CWL reference implementation (faster for testing purposes):
```
(innovation_pipeline) ~/Innovation-Pipeline$ cwltool ../workflows/standard_pipeline.cwl inputs.yaml
```
To run with Toil batch system runner:
```
(innovation_pipeline) ~/Innovation-Pipeline$ toil-cwl-runner workflows/innovation_pipeline.cwl runs/inputs_pipeline_test.yaml
```
or use:
```
(innovation_pipeline) ~/Innovation-Pipeline$ test/run-pipeline-test.sh ~/output_dir
```
Have a look inside `pipeline_runner.sh` to see some useful arguments for Toil & cwltool
