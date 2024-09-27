from pydantic import BaseModel


class PokemonAdd(BaseModel):
    name: str
    url: str
