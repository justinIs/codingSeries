require 'json'
require 'curb'

attempts_url = "http://codingseries.xyz/api/index.php/attempts"

SCHEDULER.every '2s' do
  c = Curl::Easy.new(attempts_url)
  c.perform
  attempts = c.body_str
  attempts = JSON.parse(attempts)

  puts attempts.count

  send_event('total_attempts', { current: attempts.count })

end
