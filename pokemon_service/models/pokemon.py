from models import db


class Pokemons(db.Model):
    __tablename__ = "pokemons"
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(300), unique=True, nullable=False)
    url = db.Column(db.String(300), unique=True, nullable=False)
