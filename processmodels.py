import os, glob
import meshio
from pyntcloud import PyntCloud
import numpy as np
types = ["chair", "table"]
os.chdir("models")
X = []
y = []
for i, type in enumerate(types):
    os.chdir(type)
    models = []
    for file in glob.glob("*.stl"):
        mesh = meshio.read(file)
        newfile = file[:-4]+".obj"
        if newfile not in glob.glob("*.obj"):
            mesh.write(newfile)
        mesh = PyntCloud.from_file(newfile)
        pointcloud = np.expand_dims(np.array(mesh.get_sample("mesh_random", n=20000)), axis=0)
        n = 10
        rotarray = np.array([[np.cos(2*np.pi/n), -np.sin(2*np.pi/n), 0],
                             [np.sin(2*np.pi/n), np.cos(2*np.pi/n), 0],
                             [0, 0, 1]])
        for _ in range(n):
            models.append(pointcloud)
            pointcloud = np.matmul(pointcloud, rotarray)
    models = np.concatenate(models)
    X.append(models)
    y += [i]*len(models)
    os.chdir("..")
X = np.concatenate(X)
y = np.array(y)
os.chdir("..")
np.save("models.npy", X)
np.save("classes.npy",y)
