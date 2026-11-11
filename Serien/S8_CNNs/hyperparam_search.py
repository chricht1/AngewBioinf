import numpy as np
import os
import json
import matplotlib.pyplot as plt

# from keras.utils import plot_model

from sklearn.model_selection import KFold, train_test_split
from sklearn.utils import shuffle
from cnn import *


def main():
    rand_state = 89523

    train_files = ['HSF1_train.txt_onehot.tsv', 'MAX_train.txt_onehot.tsv', 'VSX1_train.txt_onehot.tsv']
    train_files = [os.path.join("Data", "SELEX", f) for f in train_files]
    # HSF1_train_shape: 15464, 56
    # MAX_train_shape: 1605, 48
    # VSX1_train_shape: 10740, 56

    full_seq_len=56

    # shape = [[] for _ in range(len(train_files))]
    # X_train_all, y_train_all, X_test_all, y_test_all = shape.copy(), shape.copy(), shape.copy(), shape.copy()
    n_splits = 5

    X_train_parts = [[] for _ in range(n_splits)]
    y_train_parts = [[] for _ in range(n_splits)]
    X_test_parts  = [[] for _ in range(n_splits)]
    y_test_parts  = [[] for _ in range(n_splits)]

    for f in train_files:
        data = np.loadtxt(f, delimiter="\t")
        y = data[:, 0]
        X = data[:, 1:]
        X = X[..., np.newaxis]   # shape: (n_samples, seq_len, 1)

        seq_len = X.shape[1]
        if seq_len != full_seq_len:
            pad_l = (full_seq_len - seq_len) // 2
            pad_r = full_seq_len - seq_len - pad_l
            X = np.pad(X, ((0, 0), (pad_l, pad_r), (0, 0)), mode="constant")

        kf = KFold(n_splits=n_splits, shuffle=True, random_state=rand_state)

        for fold_idx, (train_idx, test_idx) in enumerate(kf.split(X)):
            X_train_parts[fold_idx].append(X[train_idx])
            y_train_parts[fold_idx].append(y[train_idx])
            X_test_parts[fold_idx].append(X[test_idx])
            y_test_parts[fold_idx].append(y[test_idx])

    # concatenate the 3 datasets fold-wise
    X_train_all = [np.concatenate(parts, axis=0) for parts in X_train_parts]
    y_train_all = [np.concatenate(parts, axis=0) for parts in y_train_parts]
    X_test_all  = [np.concatenate(parts, axis=0) for parts in X_test_parts]
    y_test_all  = [np.concatenate(parts, axis=0) for parts in y_test_parts]


    hyp = {
        "architecture": [6],#[0, 1, 2, 3, 4, 5, 6],
        "batch_size": [100, 128, 256],
        "epochs": [10], # more epochs will produce better results, but will take longer
        "optimizer": ["Adam", "SGD"],
        "lr": [1e-4, 3e-4, 5e-5]
        # "l1_reg": [0, 0.001, 0.01, 0.1],
        # "l2_reg": [0, 0.001, 0.01, 0.1],
    }

    hyp_idxs = {k: 0 for k in hyp.keys()}
    val_losses = np.zeros(n_splits)

    res_fname = 'hyp_search.tsv'
    f = open(res_fname, "a")
    f.write('Hyperparameter Search:\n')
    f.write('\t'.join(hyp.keys())+"\tmean_val_loss\n")

    for hyp_change_key in list(hyp.keys())[1:]:
        hyp_change_vals = hyp[hyp_change_key]
        for hyp_change_idx, hyp_change_val in enumerate(hyp_change_vals):  
            print(f'testing {hyp_change_key} with val: {hyp_change_val}')
            hyp_idxs[hyp_change_key] = hyp_change_idx

            val_loss_list = []
            for fold in range(n_splits):

                model = define_cnn(hyp, hyp_idxs, input_shape=(full_seq_len, 1))

                # shuffle is true per default
                print()
                history = model.fit(X_train_all[fold], y_train_all[fold],
                                    epochs=hyp["epochs"][hyp_idxs["epochs"]],
                                    batch_size=hyp["batch_size"][hyp_idxs["batch_size"]],
                                    validation_data=(X_test_all[fold], y_test_all[fold]))
                train_losses = history.history['loss']
                val_losses = history.history['val_loss']
                plt.plot(train_losses)
                plt.plot(val_losses)
            plt.legend([f'train fold {fold}' for fold in range(n_splits)]+[f'val fold {fold}' for fold in range(n_splits)])
            plt.ylabel('loss')
            plt.xlabel('epochs')
            plt.title(f'{hyp_change_key} = {hyp_change_val}')
            os.makedirs('Plots', exist_ok=True)
            plt.savefig(f'Plots/{hyp_change_key}_{hyp_change_val}_val_loss.png')
            plt.close()

            val_loss = np.mean(val_losses)
            print(f'mean val loss: {val_loss}')
            hyp_vals = []
            for key in hyp.keys():
                if key == "optimizer":
                    hyp_vals.append(get_optimizer_str(model))
                else:
                    hyp_vals.append(str(hyp[key][hyp_idxs[key]]))
            f.write("\t".join(hyp_vals) + "\t" + str(val_loss) + "\n")

    f.close()


def get_optimizer_str(model):
    opt = model.optimizer
    optimizer_str = f'{opt} {opt.learning_rate}'# {opt.weight_decay}'
    return optimizer_str


if __name__ == "__main__":
    main()
