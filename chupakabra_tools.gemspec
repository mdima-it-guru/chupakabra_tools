# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)


Gem::Specification.new do |gem|
	gem.name = "chupakabra_tools"
	gem.version = '0.0.16'
	gem.authors = ["Mitrofanov Dmitry"]
	gem.email = ["mdima@it-guru.biz"]
	gem.description = %q{Chupakbara Tools Set for Easy Life}
	gem.summary = %q{Chupakabara Tools}
	gem.homepage = ""

	gem.files = `git ls-files`.split($/)
	gem.executables = gem.files.grep(%r{^bin/}).map { |f| File.basename(f) }
	gem.test_files = gem.files.grep(%r{^(test|spec|features)/})
	gem.require_paths = ["lib"]

	gem.add_dependency "activesupport", ">= 3.2.16"
	gem.add_dependency "activerecord"
	gem.add_dependency "active_enum"
	gem.add_dependency "russian"
	gem.add_dependency "nokogiri"
	gem.add_dependency "will_paginate"

end
