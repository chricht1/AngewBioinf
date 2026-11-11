from keras.models import Sequential
from keras.layers import Dense
import sys
from numpy import genfromtxt
from sklearn.metrics import roc_auc_score,accuracy_score

temp = genfromtxt(sys.argv[1], delimiter="\t")

Y = temp[:,0]
X = temp[:,1:]


model = Sequential()
model.add(Dense(10,activation="relu"))
model.add(Dense(5,activation="relu"))
model.add(Dense(1,activation="sigmoid"))

model.compile(loss="binary_crossentropy",optimizer="adam")

hist = model.fit(X,Y,epochs=500,batch_size=100)

temp = genfromtxt(sys.argv[2], delimiter="\t")

Ytest = temp[:,0]
Xtest = temp[:,1:]

preds = model.predict(Xtest)

print(preds)

auc = roc_auc_score(Ytest,preds)

print("AUC: {0}".format(auc))