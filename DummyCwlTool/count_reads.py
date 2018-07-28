#!/usr/bin/env python

import subprocess
import argparse
import gzip
import json
from Bio import SeqIO

def main():
    parser = argparse.ArgumentParser(description='Count the number of records in a read pair')
    parser.add_argument('--R1', dest='r1', required=True)
    parser.add_argument('--R2', dest='r2', required=True)
    args = parser.parse_args()

    fastq_record_count = 0
    for rx in (args.r1, args.r2):
        with open(rx) as infile:
            fastq_record_count += sum(1 for record in SeqIO.parse(infile, 'fastq'))

    with open('output.json', 'w') as outfile:
        json.dump({'record_count': fastq_record_count}, outfile)

if __name__ == '__main__':
    main()
