# frozen_string_literal: true

require "bundler/gem_tasks"
require "rake/testtask"

Rake::TestTask.new(:test) do |t|
  t.libs << "test"
  t.libs << "lib"
  t.libs << "bin"
  t.test_files = FileList["test/**/test_*.rb", "bin/**/test_*.rb"]
end

task default: :test
