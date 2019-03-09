import nltk, math, codecs
from gensim.models.doc2vec import Doc2Vec, TaggedDocument
from sklearn.cluster import KMeans
from nltk.tokenize import word_tokenize
import re
import numpy as np
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
        data = read.readData()
        #print(data)
        docs = []
        print("coucou3")
        #print(data)
        title = dict()
        for x in data:
            print(x.keys())
        #    print(x)
        #    docs.append(str(x))
        #for  x in data['_source']['titre']:
        #    print(str(x))

        print(title)
        
        vectors = []
        print("inferring vectors")
        for i, t in enumerate(docs):
                self.used_lines.append(t)
                vec = model.infer_vector(self.preprocess_document(t))
                vectors.append(vec)

        print("done")

        kclusterer = KMeans(self.NUM_CLUSTERS, random_state=0)
        kclusterer.fit(vectors)
        # Nice Pythonic way to get the indices of the points for each corresponding cluster
        mydict = {i: np.where(kclusterer.labels_ == i)[0] for i in range(kclusterer.n_clusters)}

        # Transform this dictionary into list (if you need a list as result)
        self.dictlist = []
        temp = []
        print(mydict)
        
        
        
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