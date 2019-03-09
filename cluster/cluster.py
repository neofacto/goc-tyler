import nltk, math, codecs
from gensim.models.doc2vec import Doc2Vec, TaggedDocument
from nltk.cluster.kmeans import KMeansClusterer
from nltk.tokenize import word_tokenize
import re
from readXML import ReadXML
from nltk.corpus import stopwords

class Clustering():

    NUM_CLUSTERS = 20
    used_lines =[]
    def preprocess_document(self, text):
        return ''.join([x if x.isalnum() or x.isspace() else " " for x in text ]).split()


    def cluster_data(self):
        model = Doc2Vec.load("/cluster/d2v.model")
        read = ReadXML()
        data = read.transformData()
        docs = []
        for x in data['_source']['content']:
            docs.append(x)

        vectors = []
        print("inferring vectors")
        for i, t in enumerate(docs):
                self.used_lines.append(t)
                vec = model.infer_vector(self.preprocess_document(t))
                print(vec)
                vectors.append(vec)

        print("done")

        kclusterer = KMeansClusterer(self.NUM_CLUSTERS, distance=nltk.cluster.util.cosine_distance, repeats=25, avoid_empty_clusters=True)
        self.assigned_clusters = kclusterer.cluster(vectors, assign_clusters=True)


def get_titles_by_cluster(self, id):
    list = []
    for x in range(0, len(self.assigned_clusters)):
        if (self.assigned_clusters[x] == id):
            list.append(self.used_lines[x])
    return list

def get_topics(self, titles):
    from collections import Counter
    words = [self.preprocess_document(x) for x in titles]
    words = [word for sublist in words for word in sublist]
    filtered_words = [word for word in words if word not in stopwords.words('french')]
    count = Counter(filtered_words)
    print(count.most_common()[:5])


def cluster_to_topics(self, id):
    self.get_topics(self.get_titles_by_cluster(id))