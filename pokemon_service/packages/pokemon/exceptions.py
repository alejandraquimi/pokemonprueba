from utils.exceptions import CustomException


class UserNotFoundException(CustomException):
    def __init__(self, func: str):
        super().__init__(
            status_code=404,
            message="Usuario no encontrado",
            func=func,
        )


class PokemonFound(CustomException):
    def __init__(self, func: str):
        super().__init__(
            status_code=400,
            message="Este Pokemon ya está en la lista del usuario",
            func=func,
        )
