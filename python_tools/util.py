import re
import sys
import pandas as pd

from constants import *


def read_df(f):
    """
    Helper to read our particular format of metrics files
    """
    try:
        df = pd.read_csv(f, sep='\t')
        return df
    except Exception as e:
        print >> sys.stderr, 'Exception reading data file {}: {}'.format(f, e)
        return pd.DataFrame({})


def to_csv(df, filename):
    """
    Helper to write in desired csv format
    """
    df.to_csv(filename, sep='\t', index=False)


def extract_sample_name(has_a_sample, sample_names):
    """
    Useful for matching sample names in larger strings such as fastq file names

    Ex:
    ('somestuff_sampleid_somestuff', [list, of, sampleid]) --> sampleid
    """
    sample_name_search = r'|'.join(sample_names)
    sample_name_search = r'.*(' + sample_name_search + ').*'
    return re.sub(sample_name_search, r'\1', has_a_sample)


def merge_files_across_samples(files, cols, sample_ids=None):
    """
    Helper to merge sample files and add in sample name as a new column
    """
    all_dataframes = []
    for f in files:
        new = read_df(f)

        if new.empty:
            pass

        # Attempt to extract sample ID if list of ids provided
        if sample_ids is not None:
            sample_id = extract_sample_name(f, sample_ids)
        else:
            sample_id = f
        new.insert(0, SAMPLE_ID_COLUMN, sample_id)

        all_dataframes.append(new)

    final = pd.concat([d for d in all_dataframes])

    if final.empty:
        return pd.DataFrame(columns=cols)

    return final
