from models import db

user_pokemon = db.Table(
    "user_pokemon",
    db.Column("user_id", db.Integer, db.ForeignKey("usuarios.id"), primary_key=True),
    db.Column("pokemon_id", db.Integer, db.ForeignKey("pokemons.id"), primary_key=True),
)
