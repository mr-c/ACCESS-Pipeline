import os
import yaml
import argparse
from glob import glob
import numpy as np
import pandas as pd


def find_files(file_regex, data_dir):
    '''
    Recursively find files in folder with given search string
    '''
    files = [file for folder in os.walk(data_dir) for file in glob(os.path.join(folder[0], file_regex))]
    return files


def load_fastqs(data_dir):
    '''
    Todo: need to support multiple R1 / R2 fastqs per patient?
    :return:
    '''
    fastq1 = find_files('*_R1_001.fastq.gz', data_dir)
    fastq1 = [{'class': 'File', 'path': path} for path in fastq1]
    fastq2 = find_files('*_R2_001.fastq.gz', data_dir)
    fastq2 = [{'class': 'File', 'path': path} for path in fastq2]
    sample_sheet = find_files('SampleSheet.csv', data_dir)
    sample_sheet = [{'class': 'File', 'path': path} for path in sample_sheet]

    return fastq1, fastq2, sample_sheet


def write_inputs_file(title_file, title_file_path):
    # Start writing our inputs.yaml file
    out = open('inputs.yaml', 'wb')

    # Adapter sequences need to be tailored to include each sample barcode
    # GATCGGAAGAGCACACGTCTGAACTCCAGTCAC + bc_1 + ATATCTCGTATGCCGTCTTCTGCTTG
    adapter = 'GATCGGAAGAGCACACGTCTGAACTCCAGTCAC'
    adapter += title_file['Barcode_Index_1'].astype(str)
    adapter += 'ATATCTCGTATGCCGTCTTCTGCTTG'

    # AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT + bc_2 + AGATCTCGGTGGTCGCCGTATCATT
    adapter2 = 'AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT'
    adapter2 += title_file['Barcode_Index_2'].astype(str)
    adapter2 += 'AGATCTCGGTGGTCGCCGTATCATT'

    # Note: I put a lot of thought into whether to use a
    # Record type instead of parallel lists here,
    # but ended up not seeing the benefit because certain
    # later steps still require some of the original fields from
    # the record type after the fastqs have been converted to bams.
    # Todo: If there is a way to output a record type then this would be a cleaner option.
    out_dict = {
        'fastq1': fastq1,
        'fastq2': fastq2,
        'sample_sheet': sample_sheet,

        'adapter': adapter.tolist(),
        'adapter2': adapter2.tolist(),

        # Todo: what's the difference between ID & SM?
        'add_rg_ID': title_file['Sample_ID'].tolist(),
        'add_rg_SM': title_file['Sample_ID'].tolist(),
        'add_rg_LB': title_file['Lane'].tolist(),

        # Todo: should use one or two barcodes if they are different?
        'add_rg_PU': title_file['Barcode_Index_1'].tolist(),
    }

    # Load and write our default run parameters
    with open(run_params_path, 'r') as stream:
        other_params = yaml.load(stream)

    out.write(yaml.dump(other_params))
    out.write(yaml.dump(out_dict))

    # Include title_file in inputs.yaml
    title_file_obj = {'title_file': {'class': 'File', 'path': title_file_path}}
    out.write(yaml.dump(title_file_obj))
    out.close()


def contained_in(value, string):
    '''
    returns 1 if value contained in string, 0 otherwise
    '''
    return value.replace('_', '-') in string['path'].replace('_', '-')

def get_pos(title_file, filename):
    boolv = title_file['Sample_ID'].apply(contained_in, string=filename)
    pos = np.argmax(boolv)
    return pos


########
# Main #
########

if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument("-i", "--title_file_path", help="Title File (generated from create_title_file.py)", required=True)
    parser.add_argument("-d", "--data_dir", help="Directory with fastqs and samplesheets", required=True)
    parser.add_argument("-r", "--run_params_path", help=".yaml file that includes parameters to use for all tools, for this run of the pipeline", required=True)

    args = parser.parse_args()

    title_file_path = args.title_file_path
    data_dir = args.data_dir
    run_params_path = args.run_params_path

    # Read in run_params.yaml
    dir = os.path.dirname(__file__)
    run_params_path = os.path.join(dir, run_params_path)

    title_file = pd.read_csv(title_file_path, sep='\t')
    fastq1, fastq2, sample_sheet = load_fastqs(data_dir)

    # Sort based on title_file ordering
    fastq1 = sorted(fastq1, key=lambda x: get_pos(title_file, x))
    fastq2 = sorted(fastq2, key=lambda x: get_pos(title_file, x))
    sample_sheet = sorted(sample_sheet, key=lambda x: get_pos(title_file, x))

    # Check the title file matches input fastqs
    assert len(fastq1) == len(fastq2)
    assert len(sample_sheet) == len(fastq1)
    assert title_file.shape[0] == len(fastq1)

    write_inputs_file(title_file, title_file_path)