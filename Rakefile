require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "metajp"
    gem.summary = %Q{Shared functionality for rails apps}
    gem.description = %Q{These tools help setup and install plugins}
    gem.email = "jnarowski@gmail.com"
    gem.homepage = "http://github.com/jnarowski/metajp"
    gem.authors = ["John Paul Narowski"]
    gem.files = [
      ".document",
       ".gitignore",
       "LICENSE",
       "README.rdoc",
       "Rakefile",
       Dir["{test,lib}/**/*"],
       "test/helper.rb",
       "test/test_metastrano.rb"
    ]
  end
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: sudo gem install jeweler"
end

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
end

begin
  require 'rcov/rcovtask'
  Rcov::RcovTask.new do |test|
    test.libs << 'test'
    test.pattern = 'test/**/test_*.rb'
    test.verbose = true
  end
rescue LoadError
  task :rcov do
    abort "RCov is not available. In order to run rcov, you must: sudo gem install spicycode-rcov"
  end
end

task :test => :check_dependencies
task :default => :test

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "metajp #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
