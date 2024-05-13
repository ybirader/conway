# frozen_string_literal: true

require_relative "lib/conway/version"

Gem::Specification.new do |spec|
  spec.name = "conway"
  spec.version = Conway::VERSION
  spec.authors = ["Yusuf Birader"]
  spec.email = ["yusuf.birader@hotmail.com"]

  spec.summary = "An implementation of conway's game of life."
  # spec.homepage = "TODO: Put your gem's website or public repo URL here."
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"
  spec.files = Dir["lib/**/*", "README.md"]
  spec.bindir = "bin"
  spec.executables = %w[ conway ]
  spec.require_paths = ["lib"]

  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency "rake", "~> 13.0"
end
