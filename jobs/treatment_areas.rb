require_relative '../lib/momma/client'

SCHEDULER.every '30s', allow_overlapping: false do |job|
  send_event('treatment-areas', { items: Momma::Client.treatment_areas })
end
