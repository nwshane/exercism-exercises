dnaToRnaMapping = {
    'C': 'G',
    'G': 'C',
    'T': 'A',
    'A': 'U'
}


def convertCharToRna(char):
    try:
        return dnaToRnaMapping[char]
    except KeyError:
        raise ValueError('No RNA complement for DNA nucleotide ' + char)


def to_rna(dna_strand):
    return ''.join(map(lambda char: convertCharToRna(char), list(dna_strand)))
