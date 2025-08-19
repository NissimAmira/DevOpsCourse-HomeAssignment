SECRET_KEY = "QkcCahkZ37E6NxRkfLwVjtb0HjMbmhkXfcplxZ0qCBlWJZAYmW5h8BSB"

# PostgreSQL database configuration
SQLALCHEMY_DATABASE_URI = 'postgresql://postgres:postgres@postgres-service:5432/superset'

# Additional configuration for better performance with PostgreSQL
SQLALCHEMY_ENGINE_OPTIONS = {
    'pool_pre_ping': True,
    'pool_recycle': 300,
    'echo': False
}
