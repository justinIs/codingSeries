require 'json'
require 'curb'

attempts_url = "http://codingseries.xyz/api/index.php/attempts"

SCHEDULER.every '2s' do
  c = Curl::Easy.new(attempts_url)
  c.perform
  attempts = c.body_str
  attempts = JSON.parse(attempts)

  points = 0

  attempts.each do |attempt|
    begin
      points = points + attempt['points'].to_i
    rescue StandardError => e
      $stderr.puts e
    end
  end

  send_event('total_points', { current: points })

end
