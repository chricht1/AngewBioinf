import numpy as np
from numpy import genfromtxt
from keras.models import Sequential
from keras.layers import Dense, Activation, Dropout, Conv1D, Flatten, GlobalMaxPooling1D, GlobalAveragePooling1D,Reshape, LSTM, ActivityRegularization
import sys
from sklearn.metrics import roc_auc_score,accuracy_score
from sklearn.model_selection import KFold

def train_model(X,Y):
    model1 = Sequential()
    model1.add(Dense(10,activation="relu"))
    model1.add(Dense(30,activation="relu"))
    model1.add(Dropout(0.1))
    model1.add(Dense(20,activation="relu"))
    model1.add(Dense(1,activation="sigmoid"))
    model1.compile(loss="binary_crossentropy",optimizer="adam")
    hist = model1.fit(X,Y,epochs=500,batch_size=100)
    return model1

data = genfromtxt(sys.argv[1], delimiter="\t")

Y = data[:,0]

X = data[:,1:]


li_test = []
li_train = []
skf = KFold(n_splits=5, shuffle=True)
for train_index, test_index in skf.split(X, Y):
    X_train, X_test = X[train_index], X[test_index]
    Y_train, Y_test = Y[train_index], Y[test_index]
    model1 = train_model(X_train,Y_train)
    preds = model1.predict(X_test)[:,0]
    co = roc_auc_score(Y_test,preds)
    li_test.append(co)
    preds = model1.predict(X_train)[:,0]
    co = roc_auc_score(Y_train,preds)
    li_train.append(co)

print(li_train)
print(li_test)