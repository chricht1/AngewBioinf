import numpy as np
import os
import json
import matplotlib.pyplot as plt
from tensorflow.keras.callbacks import ModelCheckpoint

from sklearn.model_selection import KFold, train_test_split
from sklearn.utils import shuffle
from cnn import *

def load_data(file_path, full_seq_len, has_target=True):
    data = np.loadtxt(file_path, delimiter="\t")
    if has_target:
        y = data[:, 0]
        X = data[:, 1:]
    else:
        y = None
        X = data
        
    X = X[..., np.newaxis] # reshape data to shape: (n_samples, seq_len, 1)

    seq_len = X.shape[1]
    if seq_len != full_seq_len:
        pad_l = (full_seq_len - seq_len) // 2
        pad_r = full_seq_len - seq_len - pad_l
        X = np.pad(X, ((0, 0), (pad_l, pad_r), (0, 0)), mode="constant")
        
    return X, y

def main():
    tfs = ['HSF1', 'MAX', 'VSX1']
    full_seq_len = 56
    
    hyp = {
        "architecture": [6],
        "batch_size": [100],
        "epochs": [10], 
        "optimizer": ["Adam"],
        "lr": [1e-4],
    }
    hyp_idxs = {k: 0 for k in hyp.keys()}

    for tf in tfs:
        print(f"Training and predicting for {tf}...")
        train_file = os.path.join("Data", "SELEX", f"{tf}_train.txt_onehot.tsv")
        test_file = os.path.join("Data", "SELEX_test", f"{tf}_test.txt_onehot.tsv")
        
        X_train, y_train = load_data(train_file, full_seq_len, has_target=True)
        X_test, _ = load_data(test_file, full_seq_len, has_target=False)
        
        model = define_cnn(hyp, hyp_idxs, input_shape=(full_seq_len, 1))
        
        # Train model
        model.fit(X_train, y_train,
                  epochs=hyp["epochs"][hyp_idxs["epochs"]],
                  batch_size=hyp["batch_size"][hyp_idxs["batch_size"]],
                  verbose=1)
                  
        # Predict on test data
        preds = model.predict(X_test)
        
        # Save predictions
        np.savetxt(os.path.join("Predictions", f"predictions_serie9_{tf}.txt"), preds.flatten(), fmt='%.6f')

if __name__ == '__main__':
    main()