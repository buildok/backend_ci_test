#!/bin/bash

php -v
echo "FastCGI is running..."

exec php-fpm -F


exit 0
