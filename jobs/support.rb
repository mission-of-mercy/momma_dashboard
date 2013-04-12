require_relative '../lib/momma/client'

SCHEDULER.every '5s', allow_overlapping: false do |job|
  send_event('support-requests', { items: Momma::Client.support })
end
