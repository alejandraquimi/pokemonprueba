from flask import Flask
from config import Config
from models import db
from flask_migrate import Migrate  # Importar Flask-Migrate
from packages.user.router import user_bp
from packages.pokemon.router import pokemon_bp
from flasgger import Swagger
from flask_jwt_extended import JWTManager
from flask_cors import CORS

app = Flask(__name__)
CORS(app)
app.config.from_object(Config)

db.init_app(app)

# Configurar Flask-Migrate
migrate = Migrate(app, db)  # Inicializar Flask-Migrate

swagger = Swagger(app)
jwt = JWTManager(app)
# Registrar los Blueprints
app.register_blueprint(user_bp, url_prefix="/user")
app.register_blueprint(pokemon_bp, url_prefix="/pokemon")

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000, debug=True)
