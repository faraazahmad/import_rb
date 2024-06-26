# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name = "import_rb"
  spec.version = "0.1.6"
  spec.authors = ["Syed Faraaz Ahmad"]
  spec.email = ["faraaz98@live.com"]

  spec.summary = "Gem to experiment with Namespace on Read semantics"
  spec.description = "Import specific constants from a file, into the global namespace or into another constant."
  spec.homepage = "https://github.com/faraazahmad/import_rb"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.0.0"

  spec.metadata["allowed_push_host"] = "https://rubygems.org"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/faraazahmad/import_rb"
  spec.metadata["changelog_uri"] = "https://github.com/faraazahmad/import_rb"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .github appveyor Gemfile])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "prism", "~> 0.29.0"
end
