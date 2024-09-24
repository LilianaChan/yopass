# generate-env-js.sh
#!/bin/bash

# Define el archivo de salida
OUTPUT_FILE="env.js"

# Comienza a escribir el archivo JS
echo "env = {" > ./env.js

# Recorre todas las variables de entorno y añádelas al archivo JS
env | grep '^REACT_APP_' | while IFS= read -r line; do
  var_name=$(echo "$line" | cut -d '=' -f 1)
  var_value=$(echo "$line" | cut -d '=' -f 2-)
  echo "  $var_name: \"$var_value\"," >> ./env.js
done

# Cierra el objeto JS
echo "}" >> ./env.js
