import numpy as np
import tensorflow as tf
from math import ceil
class PointNet(tf.keras.Model):
    def __init__(self):
        super(PointNet, self).__init__()
        self.TLayer = T_Net()
        self.layer1 = tf.keras.layers.Dense(64, activation="relu")
        self.layer2 = tf.keras.layers.Dense(128, activation="relu")
        self.layer3 = tf.keras.layers.Dense(1024, activation="relu")
        self.layer4 = tf.keras.layers.Dense(512, activation="relu")
        self.layer5 = tf.keras.layers.Dense(256, activation="relu")
        self.outlayer = tf.keras.layers.Dense(2)
    def call(self, input):
        tout = self.TLayer(input)
        points = tf.reshape(tout, [-1,3])
        points = self.layer1(points)
        points = self.layer2(points)
        points = self.layer3(points)
        points = tf.reshape(points, [input.shape[0], 1024, -1, 1])
        points = tf.reshape(tf.nn.max_pool(points, ksize=(1,points.shape[2]), strides=1, padding="VALID"),[-1,1024])
        points = self.layer4(points)
        points = self.layer5(points)
        points = self.outlayer(points)
        return tf.nn.softmax(points)

class T_Net(tf.keras.layers.Layer):
    def __init__(self):
        super(T_Net, self).__init__()
        self.layer1 = tf.keras.layers.Dense(64, activation="relu")
        self.layer2 = tf.keras.layers.Dense(128, activation="relu")
        self.outlayer = tf.keras.layers.Dense(9)
    def call(self, input):
        points = tf.reshape(input, [-1,3])
        layer1out = self.layer1(points)
        layer2out = self.layer2(layer1out)
        pool = tf.reshape(layer2out, [input.shape[0], 128, -1, 1])
        pool = tf.reshape(tf.nn.max_pool(pool, ksize=(1,pool.shape[2]), strides=1, padding="VALID"),[-1,128])
        matrices = tf.reshape(self.outlayer(pool),[-1,3,3])
        transformed = tf.linalg.matmul(input, matrices)
        return transformed

X_train = np.load("models.npy")
y_train = np.load("classes.npy")
y_train = tf.one_hot(y_train,2).numpy()


model = PointNet()
shuffle = np.random.permutation(len(X_train))
X_train = X_train[shuffle]
y_train = y_train[shuffle]
X_testing = X_train[-10:]
y_testing = y_train[-10:]
X_train = X_train[:-10]
y_train = y_train[:-10]
loss = tf.keras.losses.BinaryCrossentropy()
optimizer = tf.keras.optimizers.Adam(learning_rate=1e-5)
epochs = 3
batch_size = 16
m = tf.keras.metrics.Accuracy()
for i in range(epochs):
    print("Epoch " + str(i))
    for j in range(ceil(len(X_train)/batch_size)):
        print(j)
        X = X_train[j*batch_size:(j+1)*batch_size]
        y = y_train[j*batch_size:(j+1)*batch_size]
        with tf.GradientTape() as tape:
            pred = model(X)
            curloss = loss(y, pred)
        gradients = tape.gradient(curloss, model.trainable_variables)
        optimizer.apply_gradients(zip(gradients, model.trainable_variables))
        print("Loss: ")
        print(curloss)
    m.update_state(np.argmax(y_testing, axis=1), np.argmax(model(X_testing),axis=1))
    print("Accuracy: ")
    print(m.result().numpy())
