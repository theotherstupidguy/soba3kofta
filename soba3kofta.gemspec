# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "soba3kofta"
  spec.version       = "0.0.0.pre5"
  spec.authors       = ["theotherstupidguy"]
  spec.email         = ["theotherstupidguy@gmail.com"]
  spec.summary       = "pentesting framework" 
  spec.description   = "pentesting framework based on mushin" 
  spec.homepage      = "https://github.com/theotherstupidguy/soba3kofta"
  spec.license       = "MIT"

  spec.files       =  Dir.glob("{lib}/**/*")  
  spec.require_paths = ["lib"]
end
