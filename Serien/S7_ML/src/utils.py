from collections import defaultdict
import numpy as np

def nested_dd():
    return defaultdict(nested_dd)

def dfltdict_vals_to_arr(d):
    if isinstance(d, defaultdict):
        d = np.array([dfltdict_vals_to_arr(v) for k, v in d.items()])
    return d