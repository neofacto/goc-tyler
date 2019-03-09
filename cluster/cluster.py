import nltk, math, codecs
from gensim.models import Doc2Vec
from nltk.cluster.kmeans import KMeansClusterer
import re

from nltk.corpus import stopwords

class Clustering():

    NUM_CLUSTERS = 20

    def preprocess_document(self, text):
        return ''.join([x if x.isalnum() or x.isspace() else " " for x in text ]).split()


    def cluster_data(self):
        model = Doc2Vec.load("d2v.model")

        corpus = codecs.open('/cluster/cyber-trend-index-dataset-small.txt', mode="r", encoding="utf-8")
        lines = corpus.read().lower().split("\n")
        count = len(lines)

        vectors = []

        print("inferring vectors")
        duplicate_dict = {}
        used_lines = []
        for i, t in enumerate(lines):
            if i % 2 == 0 and t not in duplicate_dict:
                duplicate_dict[t] = True
                used_lines.append(t)
                vectors.append(model.infer_vector(self.preprocess_document(t)))

        print("done")



        kclusterer = KMeansClusterer(self.NUM_CLUSTERS, distance=nltk.cluster.util.cosine_distance, repeats=25)
        assigned_clusters = kclusterer.cluster(vectors, assign_clusters=True)
        return assigned_clusters
