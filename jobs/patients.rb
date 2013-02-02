require 'net/http'
require 'json'

today_last = 0
total_last = 0

SCHEDULER.every '30s' do |job|
  http = Net::HTTP.new('mom.dev')
  response = http.request(Net::HTTP::Get.new("/dashboard/patients.json"))
  patients = JSON.parse(response.body)
  if patients
    send_event('patients-total', { current: patients['total'], last: total_last })
    send_event('patients-today', { current: patients['today'], last: today_last })

    today_last = patients['today']
    total_last = patients['total']
  end
end