from flask import Flask, jsonify, abort, request, make_response, url_for
from flask_cors import CORS, cross_origin
from doc2vec import TrainModel
from cluster import Clustering
from readXML import ReadXML
app = Flask(__name__)
CORS(app)



@app.errorhandler(400)
@cross_origin()
def bad_request(error):
    return make_response(jsonify({'error': 'Bad request'}), 400)


@app.errorhandler(404)
@cross_origin()
def not_found(error):
    return make_response(jsonify({'error': 'Not found'}), 404)


tweets = [
    {
        "author": "@lemondefr",
            "text": "#JO Trente-deux Russes non-invités font appel pour participer aux Jeux d’hiver à #Pyeongchang2018 http://lemde.fr/2C03lpF"
    }
]

@app.route('/')
@cross_origin()
def send_warnning():
    return "You must to specify a full address"

@app.route('/trend_topics', methods=['GET'])
@cross_origin()
def get_cluster():
    cl = Clustering()
    cl.cluster_data()
    return jsonify({'cluster': "clustering done!"})

@app.route('/train_model', methods=['GET'])
@cross_origin()
def train_model():
    tm = TrainModel()
    tm.loadData()
    return  jsonify({'cluster': tm.train() })

@app.route('/parse_text', methods=['GET'])
@cross_origin()
def parse_text():
    tm = ReadXML()
    tm.transformData()
    return  "DONE"


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5001, debug=True)
