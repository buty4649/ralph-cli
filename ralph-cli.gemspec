
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "ralph/cli/version"

Gem::Specification.new do |spec|
  spec.name          = "ralph-cli"
  spec.version       = Ralph::CLI::VERSION
  spec.authors       = ["Yuki Koya"]
  spec.email         = ["buty4649@gmail.com"]

  spec.summary       = %q{CLI Tool for Ralph.}
  spec.description   = %q{CLI Tool for Ralph (https://ralph.allegro.tech/).}
  spec.homepage      = "https://github.com/buty4649/ralph-cli/"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["homepage_uri"] = spec.homepage
    spec.metadata["source_code_uri"] = spec.homepage
    spec.metadata["changelog_uri"] = spec.homepage
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "hanami-cli", ">= 0.3.1"
  spec.add_dependency "faraday", ">= 0.15.4"
  spec.add_dependency "faraday_middleware", ">= 0.13.1"

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "minitest"
end
