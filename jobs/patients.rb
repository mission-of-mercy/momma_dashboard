require_relative '../lib/momma/client'

SCHEDULER.every '15s', allow_overlapping: false do |job|
  patients = Momma::Client.patients

  send_event('registrations-total', { current: patients['registrations_total'] })
  send_event('registrations-today', { current: patients['registrations_today'] })

  send_event('check-outs-total', { current: patients['check_outs_total'] })
  send_event('check-outs-today', { current: patients['check_outs_today'] })

  send_event('check-outs-per-hour',    { value: patients['check_outs_per_hour'] })
  send_event('registrations-per-hour', { value: patients['registrations_per_hour'] })

  send_event('patients-in-clinic', { current: patients['in_clinic'] })
end
