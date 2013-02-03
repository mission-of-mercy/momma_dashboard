require 'yaml'

module Momma
  CONFIGURATION ||= YAML.load_file(
    File.join(File.dirname(File.expand_path(__FILE__)), "../../config/mom.yml")
  )
end