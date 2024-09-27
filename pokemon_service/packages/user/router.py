from flask import Blueprint, request, jsonify
from models import Usuario, db
from flask_jwt_extended import create_access_token

from .utils import get_password_hash, verify_password
from .schemas import UserCreate

user_bp = Blueprint("user_bp", __name__)


@user_bp.route("/register", methods=["POST"])
def register():
    data = request.get_json()
    user_data = UserCreate(**data)  # Validación con Pydantic
    new_user = Usuario(
        username=user_data.username, password=get_password_hash(user_data.password)
    )
    db.session.add(new_user)
    db.session.commit()
    return jsonify({"message": "Usuario creado exitosamente"}), 201


@user_bp.route("/login", methods=["POST"])
def login():
    data = request.get_json()
    user = Usuario.query.filter_by(username=data["username"]).first()

    if not user or not verify_password(data["password"], user.password):
        return jsonify({"message": "Credenciales incorrectas"}), 401

    access_token = create_access_token(
        identity=user.id, additional_claims={"id": user.id, "username": user.username}
    )
    return jsonify(access_token=access_token)
