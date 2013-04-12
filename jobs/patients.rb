require_relative '../lib/momma/client'

SCHEDULER.every '15s', allow_overlapping: false do |job|
  patients = Momma::Client.patients

  send_event('patients-total',         { current: patients['total'] })
  send_event('patients-today',         { current: patients['today'] })
  send_event('check-outs-per-hour',    { value:   patients['check_outs_per_hour'] })
  send_event('registrations-per-hour', { value:   patients['per_hour'] })

  send_event('patients-in-clinic',     { current: patients['in_clinic'] })
end
