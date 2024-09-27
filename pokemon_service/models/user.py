from sqlalchemy import Column, Integer, String
from models import db
from .user_pokemon import user_pokemon


class Usuario(db.Model):
    __tablename__ = "usuarios"

    id = Column(Integer, primary_key=True)
    username = Column(String(80), unique=True, nullable=False)
    password = Column(String(80), nullable=False)

    pokemons = db.relationship(
        "Pokemons",
        secondary=user_pokemon,
        backref=db.backref("usuarios", lazy="dynamic"),
    )

    def __repr__(self):
        return f"<Usuario {self.username}>"
