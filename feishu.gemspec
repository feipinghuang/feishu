require_relative 'lib/feishu/version'

Gem::Specification.new do |spec|
  spec.name          = "feishu"
  spec.version       = Feishu::VERSION
  spec.authors       = ["feipinghuang"]
  spec.email         = ["feipinghuang@gmail.com"]

  spec.summary       = %q{Feishu ruby sdk}
  spec.description   = %q{A api for feishu}
  spec.homepage      = "https://guanyun.cn"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/feipinghuang/feishu'
  spec.metadata['changelog_uri'] = 'https://github.com/feipinghuang/feishu/CHANGELOG.md'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'httparty'
  spec.add_dependency 'anyway_config'
  spec.add_dependency 'redis'
end
