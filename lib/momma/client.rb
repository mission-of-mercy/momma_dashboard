require 'httparty'
require_relative './configuration'

module Momma
  class Client
    include HTTParty
    base_uri    Momma::CONFIGURATION['url']
    digest_auth Momma::CONFIGURATION['username'],
                Momma::CONFIGURATION['password']

    def self.patients
      get('/patients.json').parsed_response
    end

    def self.summary
      get("/summary.json").parsed_response
    end

    def self.support
      get("/support.json").parsed_response
    end

    def self.treatment_areas
      get("/treatment_areas.json").parsed_response
    end
  end
end
