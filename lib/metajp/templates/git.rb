if yes?("Do you want to add this project to git?")
  git :init

  file ".gitignore", <<-END
  .DS_Store
  log/*.log
  tmp/**/*
  config/database.yml
  db/*.sqlite3
  END

  run "touch tmp/.gitignore log/.gitignore vendor/.gitignore"
  run "cp config/database.yml config/example_database.yml"
  
  git :rm => "public/index.html"
  git :add => ".", :commit => "-m 'initial commit'"
end