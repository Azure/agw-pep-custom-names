import logging
import sys
from azure.identity import EnvironmentCredential
import psycopg2

credential = EnvironmentCredential()

conn = psycopg2.connect(
    host="postgreSQL custom endpoint",
    database="<database>",
    user="<username>@<postgreSQL Server Name>",
    password="<Password>",
    sslmode="verify-ca",
    sslrootcert="./<Azure PostgreSQL CA cert>")

print('Connected to PostgreSQL.')