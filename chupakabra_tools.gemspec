# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'chupakabra_tools/version'

Gem::Specification.new do |gem|
	gem.name = "chupakabra_tools"
	gem.version = ChupakabraTools::VERSION
	gem.authors = ["Mitrofanov Dmitry"]
	gem.email = ["mdima@it-guru.biz"]
	gem.description = %q{Chupakbara Tools Set for Easy Life}
	gem.summary = %q{Chupakabara Tools}
	gem.homepage = ""

	gem.files = `git ls-files`.split($/)
	gem.executables = gem.files.grep(%r{^bin/}).map { |f| File.basename(f) }
	gem.test_files = gem.files.grep(%r{^(test|spec|features)/})
	gem.require_paths = ["lib"]

	gem.add_dependency "activesupport"
	gem.add_dependency "activerecord"
	gem.add_dependency "active_enum"
	gem.add_dependency "russian"

end
