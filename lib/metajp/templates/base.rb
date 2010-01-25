#----------------------------------------------------------------
# install plugins
#----------------------------------------------------------------

plugin "asset_packager", :git => "git://github.com/sbecker/asset_packager.git"
plugin "jrails", :git => "git://github.com/aaronchi/jrails.git"
plugin "paperclip", :git => "git://github.com/thoughtbot/paperclip.git"

#----------------------------------------------------------------
# install gems
#----------------------------------------------------------------

gem 'will_paginate', :version => '~> 2.2.2'
gem 'whenever' if yes?("Do you want to add cronjobs to this app?")
rake "gems:install", :sudo => true

#----------------------------------------------------------------
# cleanup files
#----------------------------------------------------------------

# Remove unnecessary Rails files
run 'rm README'
run 'rm public/index.html'
run 'rm public/favicon.ico'
run 'rm public/images/rails.png'
run "rm public/robots.txt"
run "rm -f public/javascripts/*"

#----------------------------------------------------------------
# load additional options from templates
#----------------------------------------------------------------

load_template "/templates/rspec"
load_template "/templates/newgit"
load_template "/templates/authlogic"
load_template "/templates/capistrano"

#----------------------------------------------------------------
# create and migrate the database
#----------------------------------------------------------------
