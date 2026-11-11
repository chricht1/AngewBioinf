
from keras import Sequential, Input, Model
from keras.layers import Dense, Dropout, Conv1D, GlobalMaxPooling1D, GlobalAveragePooling1D, MaxPooling1D, AveragePooling1D
from keras.layers import Dropout, ActivityRegularization

from keras.optimizers import Adam, SGD


def define_cnn(hyp, hyp_idxs, input_shape):

    model = get_architecture(hyp, hyp_idxs, input_shape)

    opt_name = hyp["optimizer"][hyp_idxs["optimizer"]]
    lr = hyp["lr"][hyp_idxs["lr"]]
    if opt_name == "Adam":
        optimizer = Adam(learning_rate=lr)
    elif opt_name == "SGD":
        optimizer = SGD(learning_rate=lr)
    model.compile(optimizer=optimizer, loss="mean_absolute_error")
    return model


def get_architecture(hyp, hyp_idxs, input_shape):

    if hyp_idxs["architecture"] == 0:
        model = Sequential(
            [
                Input(shape=input_shape),
                Conv1D(4, 12, padding="same", activation="relu"),
                MaxPooling1D(4),
                Conv1D(16, 24, padding="same", activation="relu"),
                GlobalMaxPooling1D(),
                Dense(1, activation="linear")
            ]
        )
    elif hyp_idxs["architecture"] == 1:
        model = Sequential(
            [
                Input(shape=input_shape),
                Conv1D(4, 12, padding="same", activation="relu"),
                AveragePooling1D(4),
                Conv1D(16, 24, padding="same", activation="relu"),
                GlobalAveragePooling1D(),
                Dense(1, activation="linear")
            ]
        )
    elif hyp_idxs["architecture"] == 2:
        model = Sequential(
            [
                Input(shape=input_shape),
                Conv1D(4, 12, padding="same", activation="relu"),
                MaxPooling1D(4),
                Conv1D(16, 12, padding="same", activation="relu"),
                GlobalMaxPooling1D(),
                Dense(1, activation="linear")
            ]
        )
    elif hyp_idxs["architecture"] == 3:
        model = Sequential(
            [
                Input(shape=input_shape),
                Conv1D(4, 12, padding="same", activation="relu"),
                Conv1D(8, 12, padding="same", activation="relu"),
                MaxPooling1D(4),
                Conv1D(16, 12, padding="same", activation="relu"),
                GlobalMaxPooling1D(),
                Dense(1, activation="linear")
            ]
        )
    elif hyp_idxs["architecture"] == 4:
        model = Sequential(
            [
                Input(shape=input_shape),
                Conv1D(4, 12, padding="same", activation="relu"),
                Conv1D(8, 12, padding="same", activation="relu"),
                MaxPooling1D(4),
                Conv1D(16, 12, padding="same", activation="relu"),
                Conv1D(16, 12, padding="same", activation="relu"),
                GlobalMaxPooling1D(),
                Dense(1, activation="linear")
            ]
        )
    elif hyp_idxs["architecture"] == 5:
        model = Sequential(
            [
                Input(shape=input_shape),
                Conv1D(4, 16, padding="same", activation="relu"),
                Conv1D(8, 16, padding="same", activation="relu"),
                MaxPooling1D(4),
                Conv1D(16, 12, padding="same", activation="relu"),
                Conv1D(16, 12, padding="same", activation="relu"),
                GlobalMaxPooling1D(),
                Dense(1, activation="linear")
            ]
        )
    elif hyp_idxs["architecture"] == 6:
        model = Sequential(
            [
                Input(shape=input_shape),
                Conv1D(4, 16, padding="same", activation="relu"),
                Conv1D(8, 16, padding="same", activation="relu"),
                MaxPooling1D(4),
                Conv1D(16, 16, padding="same", activation="relu"),
                Conv1D(16, 16, padding="same", activation="relu"),
                GlobalMaxPooling1D(),
                Dense(1, activation="linear")
            ]
        )
    elif hyp_idxs["architecture"] == 6:
        model = Sequential(
            [
                Input(shape=input_shape),
                Conv1D(4, 16, padding="same", activation="relu"),
                Conv1D(8, 16, padding="same", activation="relu"),
                MaxPooling1D(4),
                Dropout(0.1),
                Conv1D(16, 16, padding="same", activation="relu"),
                Conv1D(16, 16, padding="same", activation="relu"),
                GlobalMaxPooling1D(),
                Dense(1, activation="linear")
            ]
        )
    elif hyp_idxs["architecture"] == 7:
        model = Sequential(
            [
                Input(shape=input_shape),
                Conv1D(4, 32, padding="same", activation="relu"),
                GlobalMaxPooling1D(),
                Dense(1, activation="linear")
            ]
        )
    elif hyp_idxs["architecture"] == 8:
        model = Sequential(
            [
                Input(shape=input_shape),
                Conv1D(4, 32, padding="same", activation="relu"),
                Conv1D(8, 32, padding="same", activation="relu"),
                MaxPooling1D(4),
                Dropout(0.1),
                Conv1D(8, 16, padding="same", activation="relu"),
                Conv1D(16, 16, padding="same", activation="relu"),
                GlobalMaxPooling1D(),
                Dense(1, activation="linear")
            ]
        )

    return model