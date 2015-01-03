#!/bin/bash
act=$1
SRV="/www"
PRJ="xietiao"
DST="$SRV/$PRJ"
DBPWD="dbroot"
DBNAME="prd_db"
TEST="mytest"
#ENV="production"
#export RAILS_ENV=$ENV
com="ACommon"
com=$(dirname $0)

rgs() { 
	rails g scaffold "$@" --skip-stylesheets --skip-assets;
	#rails g formtastic:form $1 -f
}

rgu() { 
	rails g scaffold "$@" user_id:integer --skip-stylesheets --skip-assets;
	#rails g formtastic:form $1 -f
} 
agu() { 
	rails g scaffold "admin::$@" user_id:integer --skip-stylesheets --skip-assets;
	rails g model "$@" user_id:integer --skip-stylesheets --skip-assets;
		
	#rails g formtastic:form $1 -f
} 

rg="rails g scaffold $@"

cfg_db_yml() {
fname="$DST/config/database.yml"
cat<<HERE1 > $fname
# SQLite version 3.x
#   gem install sqlite3
#
#   Ensure the SQLite 3 gem is defined in your Gemfile
#   gem 'sqlite3'
development:
  adapter: sqlite3
  database: db/test.sqlite3
  pool: 5
  timeout: 5000
# Warning: The database defined as "test" will be erased and
# re-generated from your development database when you run "rake".
# Do not set this db to the same as development or production.
test:
  adapter: sqlite3
  database: db/test.sqlite3
  pool: 5
  timeout: 5000

production:
  adapter: mysql2
  encoding: utf8
  reconnect: false
  database: $DBNAME
  pool: 5
  username: root
  password: $DBPWD
  socket: /var/run/mysqld/mysqld.sock
HERE1
}

install_gems(){
	cd  $DST
	cp -f $com/gem/Gemfile .
	#bundle install
	rails -v
	bundle install --without production
	rails g formtastic:install 	
	rails g devise:install
	rails g cancan:ability			
echo <<EOF
	#rails g bootstrap:install less
	#rails g bootstrap:install static
	#rails g bootstrap:layout application fluid
	rails g formtastic:install 	
	rails g nested_form:install
	rails g kaminari:config


	rails g mailer user_mailer
	rails g kaminari:config
	rails g kaminari:views default
	echo '===================install_gems end'
EOF
}


copy_templates(){
	cd $DST
	echo "copy_templates, database.yml, application.rb"
	cp -f  $com/config/application.rb    config/	
	cp -r  $com/lib .
	cp -f  $com/config/database.yml config/
}

cfg_route_old(){
	#Update routes.rb	
	#fname="$SRV/$PRJ/config/routes.rb"
	#sed "s/.*root :to =>.*/  root :to => '${TEST}s#index'/" $fname > ${fname}.tmp
	#cp ${fname}.tmp ${fname}
fname="$DST/config/routes.rb"
sed -i -e "/devise_for/d" $fname
sed -i "2iresources  :users" $fname
sed -i "2iroot :to => 'groups#index'" $fname
sed -i "2idevise_for :users, :path_prefix => 'd'" $fname
sed -i "get '/*url' => 'application/pages#show', as: :page" $fname
}

add_page_route(){
	#Update routes.rb	
	#fname="$SRV/$PRJ/config/routes.rb"
	#sed "s/.*root :to =>.*/  root :to => '${TEST}s#index'/" $fname > ${fname}.tmp
	#cp ${fname}.tmp ${fname}
fname="$DST/config/routes.rb"
sed -i '$iresources :tasks' $fname
sed -i '$inamespace :admin do resources :users end' $fname
sed -i '$i get "/*url" => "application/pages#show", as: :page' $fname
sed -i '$i root :to=>"application/pages#show",url:"index"' $fname
}

cfg_css_js(){
# bootstrap  css
fname="$DST/app/assets/stylesheets/application.css"
#sed -i '$i\ *= require twitter/bootstrap' $fname
#sed -i '$i\ *= require twitter/bootstrap-responsive' $fname
#sed -i '$i\ *= require formtastic' $fname
# bootstrap js
fname="$DST/app/assets/javascripts/application.js"
#sed -i '$i//= require twitter/bootstrap' $fname
# Formtastic error
fname="$DST/config/initializers/formtastic.rb"
sed -i '$iFormtastic::FormBuilder.inline_errors = :none' $fname
sed -i '$iFormtastic::Helpers::FormHelper.builder = FormtasticBootstrap::FormBuilder' $fname
}

cfg_data(){
	echo "com=$com"
	cd $DST
	echo "com=$com"
	echo "PWD=$(pwd)"			
	# Create database, mysql -u user -p -e 'SQL Query' database
	#mysql -uroot -p$DBPWD -e "drop database $DBNAME"
	#mysql -uroot -p$DBPWD -e "create database $DBNAME"
	#rake db:drop
	#rake db:create	
	#cp -f  $com/db/seeds.rb db/
	cp -f  $com/db/*.rb db/	
	rake db:migrate	
	#rake db:seed
	rake db:reset
	#rake db:migrate RAILS_ENV=$ENV
	#rake db:seed RAILS_ENV=$ENV
	echo "Created tables and inserted data"			
}

copy_files0(){
	cd $DST
	cp -f  $com/db/seeds.rb db/
	cp -f  $com/config/en.yml    config/locales/
	#cp -r  $com/config/routes.rb    config/
	cp -r  $com/assets      app/
	cp -r  $com/helpers     app/
	cp -r  $com/models      app/
	cp -r  $com/controllers app/
	#cp -r  $com/mailers     app/
	#cp -f  $com/gem/Gemfile.lock .
}
copy_files(){
	cd $DST
	#mkdir config/initializers
	#cp -f  $com/config/constants.rb config/initializers/	
	#cp -r  $com/assets      app/	
	cp -f  $com/config/zh-CN.yml    config/locales/
	cp -f  $com/config/devise.zh-CN.yml    config/locales/	
	cp -f  $com/config/routes.rb    config	
	cp -r  $com/app/*      app/
	#cp -r  $com/mailers     app/
	#cp -f  $com/gem/Gemfile.lock .
}


if [ "x$com" = "x." ];then
	com=$(pwd)
fi

if [ "x${act}x" = "xx" ];then
	clear
	echo "Copy file only"
	copy_templates
	copy_files
elif [ "x${act}x" = "xdbx" ]; then
	cfg_data	
elif [ "x${act}x" = "xallx" ]; then
	rm -rf $DST/*
	rm -rf $DST/*.*	
	#rails new $PRJ -d mysql -T
	cd $SRV
	echo "DST=$DST"
	#rvm 2.1.2@rails416
	rails -v
	rails new $PRJ -T
	#cfg_db_yml	
	rvm gemset list
	cp -f $com/rvmrc $DST
	install_gems	
	copy_templates
	#cfg_route # Let rails add more routes
	cd  $DST
	CRT="$com/crt_prj.sh"
	[ -f $CRT ] && . $CRT && create_project	
	#cfg_route # copy full routes
	add_page_route
	cfg_css_js
	#rails g dm:install	
	copy_files
	cfg_data
	echo "PWD=$(pwd)"		
	cd $DST
	echo "PWD=$(pwd)"	
	rm -rf $DST/public/index.html			
	#rake assets:precompile --trace RAILS_ENV=$ENV
	#chmod 0666 $SRV/$PRJ/log/$ENV.log	
	#mkdir -p   $SRV/$PRJ/public/jpg
	#cp -rp     $SRV/jpg $SRV/$PRJ/public	
fi 
#/etc/init.d/apache2 restart