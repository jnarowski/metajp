require 'metajp'

# setup variables
app_name = ask("What do you want your app to be called?")

@template = Metajp.get_template_path

# # install plugins
# plugin "asset_packager", :git => "git://github.com/sbecker/asset_packager.git"
# plugin "jrails", :git => "git://github.com/aaronchi/jrails.git"
# plugin "paperclip", :git => "git://github.com/thoughtbot/paperclip.git"
# 
# # install base gems
# gem 'will_paginate', :version => '~> 2.2.2'
# gem 'whenever' if yes?("Do you want to add cronjobs to this app?")

# cleanup files
run 'rm README'
run 'rm public/index.html'
run 'rm public/favicon.ico'
run 'rm public/images/rails.png'
run "rm public/robots.txt"
run "rm -f public/javascripts/*"
 
# load additional options from templates
load_template(@template + "/rspec.rb")
load_template(@template + "/git.rb")
load_template(@template + "/authlogic.rb")
load_template(@template + "/capistrano.rb")

# # install the gems
# rake "gems:install", :sudo => true
# 
# # create and migrate the database
# run "mysqladmin -u root create #{app_name.downcase.gsub(" ", '')}_dev"
# run "mysqladmin -u root create #{app_name.downcase.gsub(" ", '')}_test"
# rake "db:migrate"
# rake "db:test:clone"