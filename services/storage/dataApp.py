from flask import Flask, jsonify, request
import psycopg2
from psycopg2.extras import RealDictCursor
import os

app = Flask(__name__)

# Connect to PostgreSQL
def get_db_connection():
    connection = psycopg2.connect(
        os.getenv('DB_URL')
    )
    return connection

# Route to get food data
@app.route('/food/<name>', methods=['GET'])
def get_food(name):
    connection = get_db_connection()
    cursor = connection.cursor(cursor_factory=RealDictCursor)
    
    try:
        cursor.execute('SELECT * FROM foods WHERE name = %s;', (name,))
        food = cursor.fetchone()
        if food:
            return jsonify({'name': food['name'], 'calories_per_100g': food['calories_per_100g']})
        else:
            return jsonify({'error': 'Food not found'}), 404
    except:
        return jsonify({'error': 'Failed to fetch info'}), 400
    finally:
        cursor.close()
        connection.close()
    

# Route to get average calories by category
@app.route('/category/<category_name>', methods=['GET'])
def get_average_calories(category_name):
    connection = get_db_connection()
    cursor = connection.cursor()

    try:
        cursor.execute("""
            SELECT AVG(calories_per_100g) AS average_calories
            FROM foods
            WHERE category = %s;
        """, (category_name,))

        result = cursor.fetchone()
        if result and result[0] is not None:
            return jsonify({'category': category_name, 'average_calories': result['average_calories']})
        else:
            return jsonify({'error': 'Category not found'}), 404
    except:
        return jsonify({'error': 'Failed to fetch info'}), 400
    finally:
        cursor.close()
        connection.close()


# Route to log actions
@app.route('/log', methods=['POST'])
def add_log():
    log = request.json
    if not log:
        return jsonify({'error': 'Log is required'}), 400
    
    connection = get_db_connection()
    cursor = connection.cursor()
    
    try:
        cursor.execute("INSERT INTO logs (log) VALUES (%s);", (log,))
        connection.commit()
        return jsonify({'status': 'Log added'}), 201
    except:
        connection.cancel()
        return jsonify({'error': 'Failed to add log to database'}), 400
    finally:
        cursor.close()
        connection.close()

if __name__ == '__main__':
    app.run(host= '0.0.0.0')
