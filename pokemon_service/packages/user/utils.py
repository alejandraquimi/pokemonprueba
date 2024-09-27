import bcrypt
import random
import string

from config import general_settings

SALT = general_settings.SALT


def get_password_hash(password):
    salted_password = password + SALT
    return bcrypt.hashpw(salted_password.encode(), bcrypt.gensalt()).decode()


def verify_password(plain_password, hashed_password):
    salted_password = plain_password + SALT
    return bcrypt.checkpw(salted_password.encode(), hashed_password.encode())
