from flask import Flask, jsonify, request
import psycopg2
from psycopg2.extras import RealDictCursor
from dotenv import load_dotenv
import os

app = Flask(__name__)

# Connect to PostgreSQL
def get_db_connection():
    load_dotenv()
    connection = psycopg2.connect(
        host="localhost",
        database=os.getenv("DB_NAME"),
        user=os.getenv("DB_USER"),
        password=os.getenv("DB_PASSWORD")
    )
    return connection

# Route to get food data
@app.route('/food/<name>', methods=['GET'])
def get_food(name):
    connection = get_db_connection()
    cursor = connection.cursor(cursor_factory=RealDictCursor)
    
    cursor.execute('SELECT * FROM foods WHERE name = %s;', (name,))
    food = cursor.fetchone()
    
    cursor.close()
    connection.close()

    if food:
        return jsonify(food)
    else:
        return jsonify({'error': 'Food not found'}), 404

# Route to log actions
@app.route('/log', methods=['POST'])
def add_log():
    log = request.json
    
    if not log:
        return jsonify({'error': 'Log is required'}), 400
    
    connection = get_db_connection()
    cursor = connection.cursor()
    
    try:
        cursor.execute('INSERT INTO logs (log) VALUES (%s);', (log,))
        connection.commit()
        response = jsonify({'status': 'Log added'}), 201
    except:
        connection.cancel()
        response = jsonify({'error': 'Failed to add log to database'}), 400
    
    cursor.close()
    connection.close()

    return response

if __name__ == '__main__':
    app.run(host= '0.0.0.0')
