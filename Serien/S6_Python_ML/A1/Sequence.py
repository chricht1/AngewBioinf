import re

class Sequence:
    def __init__(self, seqString):
        if not isinstance(seqString, str):
            raise TypeError("string of sequence must be given as argument!")
        self.seqString = seqString.upper()

    def __getitem__(self, key):
        return Sequence(self.seqString[key])

    def __len__(self):
        return len(self.seqString)

    def __add__(self, SubsequentSeq: Sequence):
        return Sequence(self.seqString + SubsequentSeq.seqString)

    def getRevCompl(self):
        complement = {"A": "T", "T": "A", "C": "G", "G": "C"}
        try:
            return Sequence("".join([complement[base] for base in self.seqString[::-1]]))
        except KeyError:
            print("reverse complement is only supported for DNA sequences!")
            return None
    
    def findPattern(self, pattern):
        matches = re.finditer(pattern, self.seqString)
        return [Sequence(self.seqString[match.start():match.end()]) for match in matches]