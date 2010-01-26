if yes?("Do you want to add capistrano?")
  
  capify!

  file 'Capfile', <<-FILE
    require 'metastrano'
    load 'deploy' if respond_to?(:namespace) # cap2 differentiator
    Dir['vendor/plugins/*/recipes/*.rb'].each { |plugin| load(plugin) }
    load 'config/deploy'
  FILE

  #file 'config/deploy.rb',
end
