# API-POKEMON

## Clonar el proyecto

Debe ejecutar los siguientes comandos:

```
git clone https://github.com/alejandraquimi/pokemonprueba.git
```

## Configuración del backend

Se utiliza Flask con base de datos sqllite.
se debe crear un entorno virtual, luego instalar las dependencias ubicadas en pokemon_service/requirements/requeriments.txt
se debe tener un .env
Los comandos para generar las migraciones son:

```
cd pokemon_service
flask db migrate -m "mensaje de la migración"
flask db upgrade
```

Para levantar el servidor ejecute:

```
python app.py
```

## Configuración de la aplicación movil

Los comandos son los siguientes:

```
cd pokemon_app
flutter pub get
flutter run
```

Cabe mencionar que debe configurar un emulador android o en un dispositivo movil.

```

```
