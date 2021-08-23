#!/usr/bin/env sh

echo "Starting fpm"
if [[ -f "/usr/local/bin/berglas" && $APP_ENV == "production" ]]; then
  berglas exec -- php-fpm8 -F
else
  php-fpm8 -F
fi
