spec = Gem::Specification.new do |s|
  s.name = 'kuality-coeus'
  s.version = '0.0.1'
  s.summary = %q{rSmart's test framework for BDD testing of Kuali Coeus}
  s.description = %q{This gem is used for creating test scripts for Kuali Coeus.}
  s.files = Dir.glob("**/**/**")
  s.files.reject! { |file_name| file_name =~ /.yml$/ }
  s.authors = ["Abraham Heward", "Jon Utter"]
  s.email = %w{"aheward@rsmart.com" "jutter@rsmart.com"}
  s.homepage = 'https://github.com/rSmart'
  s.add_dependency 'test-factory', '>= 0.2.0'
  s.required_ruby_version = '>= 1.9.3'
end