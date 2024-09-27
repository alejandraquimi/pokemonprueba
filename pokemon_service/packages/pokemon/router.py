from flask import Blueprint, request, jsonify
from models import Pokemons, Usuario, db
from flask_jwt_extended import jwt_required, get_jwt_identity
from .schemas import PokemonAdd

pokemon_bp = Blueprint("pokemon_bp", __name__)


@pokemon_bp.route("/pokemons", methods=["GET"])
@jwt_required()
def get_pokemons():
    user_id = get_jwt_identity()
    user = Usuario.query.get(user_id)

    if not user:
        return jsonify({"message": "Usuario no encontrado"}), 404

    pokemons = [
        {"id": pokemon.id, "name": pokemon.name, "url": pokemon.url}
        for pokemon in user.pokemons
    ]
    return jsonify(pokemons=pokemons)


@pokemon_bp.route("/add_pokemon", methods=["POST"])
@jwt_required()
def add_pokemon():
    user_id = get_jwt_identity()
    data = request.get_json()
    pokemon_name = data.get("name")
    pokemon_url = data.get("url")
    pokemon_id = data.get("id")

    if not pokemon_name:
        return jsonify({"message": "El nombre del Pokémon es obligatorio"}), 400

    pokemon = Pokemons.query.filter_by(name=pokemon_name).first()

    if not pokemon:
        try:
            pokemon = Pokemons(name=pokemon_name, url=pokemon_url, id=pokemon_id)
            db.session.add(pokemon)
            db.session.commit()
        except Exception as e:
            db.session.rollback()
            return jsonify({"message": f"Error al crear el Pokemon: {str(e)}"}), 500

    user = Usuario.query.get(user_id)
    if not user:
        return jsonify({"message": "Usuario no encontrado"}), 404

    if pokemon in user.pokemons:
        return jsonify({"message": "Este Pokemon ya está en la lista del usuario"}), 400
    user.pokemons.append(pokemon)
    try:
        db.session.commit()
        return jsonify({"message": "Pokemon agregado exitosamente"}), 200
    except Exception as e:
        db.session.rollback()
        return jsonify({"message": f"Error al agregar el Pokemon: {str(e)}"}), 500
