#Import all the dependencies
from gensim.models.doc2vec import Doc2Vec, TaggedDocument
from nltk.tokenize import word_tokenize
import nltk
from readXML import ReadXML

class TrainModel():
    
    data = []

    def loadData(self):
        read = ReadXML()
        self.data = read.transformData()
        self.tagged_data = [TaggedDocument(words=word_tokenize(_d.lower()), tags=[str(i)]) for i, _d in enumerate(self.data)]

    def train(self):
        iterations = []
        self.loadData()
        iterations.append(self.tagged_data)
        iterations.append('number of data {0}'.format(len(self.tagged_data)))
        max_epochs = 100
        vec_size = 20
        alpha = 0.025

        model = Doc2Vec(vector_size=vec_size,
                        alpha=alpha, 
                        min_alpha=0.00025,
                        min_count=1,
                        dm =1)
        
        model.build_vocab(self.tagged_data)
       
        for epoch in range(max_epochs):
            iterations.append('iteration {0}'.format(epoch))
            model.train(self.tagged_data,
                        total_examples=model.corpus_count,
                        epochs=model.iter)
            # decrease the learning rate
            model.alpha -= 0.0002
            # fix the learning rate, no decay
            model.min_alpha = model.alpha

        model.save("d2v.model")
        iterations.append("Model Saved")
        return iterations