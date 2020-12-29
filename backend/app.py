from flask import Flask, jsonify, abort, request
from flask_cors import CORS
import pymysql

from datetime import datetime, date
from flask.json import JSONEncoder
class CustomJSONEncoder(JSONEncoder):
    def default(self, obj):
        if isinstance(obj, datetime):
            return obj.strftime('%Y-%m-%d %H:%M:%S')
        elif isinstance(obj, date):
            return obj.strftime('%Y-%m-%d')
        else:
            return JSONEncoder.default(self, obj)

app = Flask(__name__)
app.json_encoder = CustomJSONEncoder
CORS(app,supports_credentials=True)

class MyDB:
    def __init__(self, h='47.104.160.30', u='lab_user', p="lab123", db=None):
        self.db = pymysql.connect(host=h, user=u, password=p, database=db,
                                  cursorclass=pymysql.cursors.DictCursor)
        self.cursor = self.db.cursor()

    def selectAllCus(self):
        self.cursor.execute("SELECT * FROM customer")
        self.db.commit()
        return self.cursor.fetchall()
    	# 增删改操作
    def selectAllFur(self):
        self.cursor.execute("SELECT fur_id,fur_name,fur_price,fur_amount,type_name,sup_name FROM furnit a,ftype b,support c WHERE a.type_id = b.type_id and a.sup_id = c.sup_id")  # 执行sql语句
        self.db.commit()
        return self.cursor.fetchall()
    def selectCusOb(self,cus_id):
        sql = "SELECT ob_order,fur_name,ob_price,ob_amount,ob_date,ob_price*ob_amount AS ob_pay FROM outbound a,furnit b WHERE a.fur_id=b.fur_id AND a.cus_id="+str(cus_id)
        self.cursor.execute(sql) 
        self.db.commit()
        return self.cursor.fetchall()
    def selectAllIb(self):
        self.cursor.execute("SELECT * FROM inbound")  # 执行sql语句
        self.db.commit()
        return self.cursor.fetchall()
    def selectAllOb(self):
        self.cursor.execute("SELECT * FROM outbound")  # 执行sql语句
        self.db.commit()
        return self.cursor.fetchall()
    def selectSup(self):
        self.cursor.execute("SELECT * FROM support")  # 执行sql语句
        self.db.commit()
        return self.cursor.fetchall()
    def selectType(self):
        self.cursor.execute("SELECT * FROM ftype")  # 执行sql语句
        self.db.commit()
        return self.cursor.fetchall()
    def getToIO(self,st_io_date,ed_io_date):
        self.cursor.execute("CALL period_io(%s,%s)",[st_io_date,ed_io_date])
        self.db.commit()
        return self.cursor.fetchall()

    def insertFur(self,fur_id,fur_name,fur_price,fur_amount,type_id,sup_id):
        sql = 'INSERT INTO furnit VALUES(%s,%s,%s,%s,%s,%s)'
        self.cursor.execute(sql,[fur_id,fur_name,fur_price,fur_amount,type_id,sup_id])
        data = self.cursor.fetchall()
        self.db.commit()
        return data
    def insertIb(self,ib_order,sup_id,fur_id,ib_amount,ib_price,ib_date):
        sql = 'INSERT INTO inbound(ib_order,sup_id,fur_id,ib_amount,ib_price,ib_date) VALUES(%s,%s,%s,%s,%s,%s)'
        self.cursor.execute(sql,[ib_order,sup_id,fur_id,ib_amount,ib_price,ib_date])
        data = self.cursor.fetchall()
        self.db.commit()
        return data
    def insertOb(self,ob_order,cus_id,fur_id,ob_amount,ob_price,ob_date):
        sql = 'INSERT INTO outbound(ob_order,cus_id,fur_id,ob_amount,ob_price,ob_date) VALUES(%s,%s,%s,%s,%s,%s)'
        self.cursor.execute(sql,[ob_order,cus_id,fur_id,ob_amount,ob_price,ob_date])
        data = self.cursor.fetchall()
        self.db.commit()
        return data
    # def insertOb(self,ob_order,cus_id,fur_id,ob_amount,ob_price):
    #     sql = ''
    #     self.cursor.execute(sql)
    #     self.db.commit()
    #     return self.cursor.fetchall()
    # def getIOAmount(self,date1,date2):
    #     sql = 'EXEC'
    #     self.cursor.execute(sql)
    #     self.db.commit()
    #     return self.cursor.fetchall()


@app.route('/getCus', methods=['GET'])
def get_cus():
    result = my.selectAllCus()
    return jsonify(result)

@app.route('/getFur', methods=['GET'])
def get_fur():
    result = my.selectAllFur()
    return jsonify(result)
    
@app.route('/type', methods=['GET'])
def get_type():
    result = my.selectType()
    return jsonify(result)
    
@app.route('/sup', methods=['GET'])
def get_sup():
    result = my.selectSup()
    return jsonify(result)

@app.route('/selectCusOb', methods=['GET'])
def get_cus_ob():
    cus_id = request.args.get("cusId")
    result = my.selectCusOb(cus_id)
    return jsonify(result)

@app.route('/ib', methods=['GET'])
def get_ib():
    result = my.selectAllIb()
    return jsonify(result)
    
@app.route('/ob', methods=['GET'])
def get_ob():
    result = my.selectAllOb()
    return jsonify(result)

@app.route('/getTotalIO',methods=['GET'])
def get_to_io():
    st_date = request.args.get("stDate")
    ed_date = request.args.get("edDate")
    result = my.getToIO(st_date,ed_date)
    return jsonify(result)

@app.route('/insertIb',methods=['POST'])
def insert_ib():
    fur_id = request.json.get("furId")
    ib_amount = request.json.get("ibAmount")
    ib_price = request.json.get("ibPrice")
    ib_date = request.json.get("ibDate")
    sup_id = request.json.get("supId")
    ib_order = request.json.get("ibOrder")
    result = my.insertIb(ib_order,sup_id,fur_id,ib_amount,ib_price,ib_date)
    return jsonify(result)
@app.route('/insertOb',methods=['POST'])
def insert_ob():
    fur_id = request.json.get("furId")
    ob_amount = request.json.get("obAmount")
    ob_price = request.json.get("obPrice")
    ob_date = request.json.get("obDate")
    cus_id = request.json.get("cusId")
    ob_order = request.json.get("obOrder")
    result = my.insertOb(ob_order,cus_id,fur_id,ob_amount,ob_price,ob_date)
    return jsonify(result)
@app.route('/insertFur',methods=['POST'])
def insert_fur():
    fur_id = request.json.get("furId")
    fur_amount = request.json.get("furAmount")
    fur_price = request.json.get("furPrice")
    type_id = request.json.get("typeId")
    sup_id = request.json.get("supId")
    fur_name = request.json.get("furName")
    result = my.insertFur(fur_id,fur_name,fur_price,fur_amount,type_id,sup_id)
    return jsonify(result)

if __name__ == '__main__':
    my = MyDB(db='furniture')
    app.run(host='0.0.0.0')



