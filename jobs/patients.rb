require_relative '../lib/momma/client'

SCHEDULER.every '30s' do |job|
  patients = Momma::Client.new.patients

  send_event('patients-total',         { current: patients['total'] })
  send_event('patients-today',         { current: patients['today'] })
  send_event('registrations-per-hour', { value:   patients["per_hour"] })
end