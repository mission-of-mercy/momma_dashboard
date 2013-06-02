require_relative '../lib/momma/client'

SCHEDULER.every '30s', allow_overlapping: false do |job|
  summary = Momma::Client.summary

  send_event('total-donated', { current: summary["total_donated"] })
  send_event('procedures', { current: summary["procedures"] })
  send_event('top-procedures', { items: summary["top_procedures"] })
end
