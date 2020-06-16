#!/usr/bin/env rake
require "bundler/gem_tasks"

print("rakefile line 4\n")

task :default => :test

# ==========================================================
# Packaging
# ==========================================================

print("rakefile line 12\n")
GEMSPEC = eval(File.read('pygments.rb.gemspec'))

print("rakefile line 15\n")
require 'rubygems/package_task'

# ==========================================================
# Testing
# ==========================================================

print("rakefile line 22\n")
require 'rake/testtask'
print("rakefile line 24\n")
Rake::TestTask.new 'test' do |t|
  print("rakefile line 26\n")
  t.test_files = FileList['test/test_*.rb']
end

# ==========================================================
# Benchmarking
# ==========================================================

task :bench do
  sh "ruby bench.rb"
end

# ==========================================================
# Cache lexers
# ==========================================================

# Write all the lexers to a file for easy lookup
task :lexers do
  sh "set PYTHONIOENCODING=UTF-8 && ruby --trace cache-lexers.rb"
end

task(:test).enhance([:lexers])
task(:build).enhance([:lexers])

# ==========================================================
# Vendor
# ==========================================================

namespace :vendor do
  file 'vendor/pygments-main' do |f|
    sh "hg clone https://bitbucket.org/birkenfeld/pygments-main #{f.name}"
    sh "hg --repository #{f.name} identify --id > #{f.name}/REVISION"
    rm_rf Dir["#{f.name}/.hg*"]
    rm_rf Dir["#{f.name}/tests"]
  end

  task :clobber do
    rm_rf 'vendor/pygments-main'
  end

  # Load all the custom lexers in the `vendor/custom_lexers` folder
  # and stick them in our custom Pygments vendor
  task :load_lexers do
    LEXERS_DIR = 'vendor/pygments-main/pygments/lexers'
    lexers = FileList['vendor/custom_lexers/*.py']
    lexers.each { |l| FileUtils.copy l, LEXERS_DIR }
    FileUtils.cd(LEXERS_DIR) { sh "python _mapping.py" }
  end

  desc 'update vendor/pygments-main'
  task :update => [:clobber, 'vendor/pygments-main', :load_lexers]
end
