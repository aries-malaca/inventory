## How To install

1. install dependencies issue command at root/ with: composer install
2. install node_modules in public/app using: npm install
3. build vuejs budle script inside public/app using: npm run build
4. import inventory.sql in your phpmyadmin
5. check if .env has correct configuration/connection string
6. run http server inside root/ folder using: php artisan serve
7. go to http://localhost:8000
8. Login with admin@test.com password: 12345

## Thanks




download composer and install
cmd directory: cd Desktop
run command: install composer
download and install nodejs
cmd directory: cd \Desktop\inventory\public\app
run command: npm install
build vuejs budle script inside public/app using: npm run build
import inventory.sql in your phpmyadmin
check if .env has correct configuration/connection string
cmd directory: cd \Desktop\inventory
run command: php artisan serve
go to http://localhost:8000
Login with admin@test.com password: 12345



migration (uploading of modifation made in the DB)
open another cmd
cmd directory: cd \Desktop\inventory
run command: php artisan migrate 
run command: git pull origin master  --for updating


editing
cmd directory: cd \Desktop\inventory
run command: git add.
run command: Git commit -ma
run command: git push origin master