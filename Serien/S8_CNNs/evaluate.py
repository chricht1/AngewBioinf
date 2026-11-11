import numpy as np
import scipy.stats
import os

def main():
    tfs = ['HSF1', 'MAX', 'VSX1']
    for tf in tfs:
        pred_file = f"predictions_serie9_{tf}.txt"
        truth_file = os.path.join("Data", "SELEX-Zielwerte", f"{tf}_test.txt_labs.txt")
        
        if not os.path.exists(pred_file) or not os.path.exists(truth_file):
            print(f"Missing files for {tf}")
            continue
            
        preds = np.loadtxt(pred_file)
        truth = np.loadtxt(truth_file)
        
        corr = np.corrcoef(preds, truth)[0, 1]
        print(f"Pearson correlation for {tf}: {corr:.4f}")

if __name__ == '__main__':
    main()
