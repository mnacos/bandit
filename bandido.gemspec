$:.push File.expand_path("../lib", __FILE__)
require "bandit/version"

Gem::Specification.new do |s|
  s.name        = "bandido"
  s.version     = Bandit::VERSION
  s.authors     = ["Michael Nacos"] # original author is Brian Muller, this is a fork
  s.email       = ["m.nacos@gmail.com"]
  s.homepage    = "https://github.com/mnacos/bandit"
  s.summary     = "Multi-armed bandit testing in rails"
  s.description = "Bandit-clone, more options around cookies (simple/session/sticky)"
  s.rubyforge_project = "bandido"
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  s.add_dependency("rails", ">= 3.0.5")
  s.add_dependency("redis", "= 2.2.2")
  s.add_development_dependency('rdoc')
end
