
import json
import logging
import os
from functools import lru_cache

import boto3
import pymysql
from flask import Flask, render_template_string
from pymysql.cursors import DictCursor

app = Flask(__name__)
logging.basicConfig(level=logging.INFO)


@lru_cache(maxsize=1)
def get_database_credentials():
    """Retrieve and cache the RDS credentials from Secrets Manager."""

    secret_arn = os.environ["DB_SECRET_ARN"]
    aws_region = os.environ["AWS_REGION"]

    client = boto3.client(
        "secretsmanager",
        region_name=aws_region
    )

    response = client.get_secret_value(
        SecretId=secret_arn
    )

    return json.loads(response["SecretString"])


def get_database_connection():
    """Connect to the private RDS MySQL database."""

    credentials = get_database_credentials()

    return pymysql.connect(
        host=credentials["host"],
        port=int(credentials.get("port", 3306)),
        user=credentials["username"],
        password=credentials["password"],
        database=credentials.get("dbname") or os.environ["DB_NAME"],
        connect_timeout=5,
        cursorclass=DictCursor,
        autocommit=True
    )


@app.route("/health")
def health():
    """Application health check for the load balancer."""

    return {"status": "healthy"}, 200


@app.route("/")
def index():
    """Display the application and record website visits."""

    connection = None

    try:
        connection = get_database_connection()

        with connection.cursor() as cursor:
            cursor.execute("""
                CREATE TABLE IF NOT EXISTS app_stats (
                    id TINYINT PRIMARY KEY,
                    visit_count BIGINT NOT NULL DEFAULT 0,
                    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
                    ON UPDATE CURRENT_TIMESTAMP
                )
            """)

            cursor.execute("""
                INSERT INTO app_stats (id, visit_count)
                VALUES (1, 1)
                ON DUPLICATE KEY UPDATE
                visit_count = visit_count + 1
            """)

            cursor.execute("""
                SELECT visit_count, updated_at
                FROM app_stats
                WHERE id = 1
            """)

            stats = cursor.fetchone()

        return render_template_string("""
            <!DOCTYPE html>
            <html>
            <head>
                <title>AWS Three-Tier Architecture</title>
                <style>
                    body {
                        font-family: Arial, sans-serif;
                        background: #eef2f7;
                        text-align: center;
                        padding: 60px 20px;
                    }
                    .container {
                        background: white;
                        max-width: 650px;
                        margin: auto;
                        padding: 35px;
                        border-radius: 12px;
                        box-shadow: 0 4px 15px rgba(0,0,0,0.08);
                    }
                    h1 { color: #172554; }
                    .status { color: #15803d; font-weight: bold; }
                    .count { font-size: 36px; color: #2563eb; }
                </style>
            </head>
            <body>
                <div class="container">
                    <h1>AWS Three-Tier Architecture</h1>
                    <h2>Highly Available Flask Application</h2>
                    <p class="status">Database connection successful</p>
                    <p>Website visits recorded in Amazon RDS MySQL:</p>
                    <div class="count">{{ stats.visit_count }}</div>
                    <p>Last updated: {{ stats.updated_at }}</p>
                    <hr>
                    <p>Application: Python Flask</p>
                    <p>Database: Amazon RDS MySQL</p>
                    <p>Infrastructure: Terraform on AWS</p>
                </div>
            </body>
            </html>
        """, stats=stats)

    except Exception:
        app.logger.exception("Application database operation failed")

        return (
            "The application is running, but the database is temporarily unavailable.",
            503
        )

    finally:
        if connection:
            connection.close()
