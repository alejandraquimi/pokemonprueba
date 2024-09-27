from flask_sqlalchemy import SQLAlchemy

db = SQLAlchemy()

from .user import Usuario
from .pokemon import Pokemons
from .user_pokemon import user_pokemon
