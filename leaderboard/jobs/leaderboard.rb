require 'json'
require 'curb'

users_url = "http://codingseries.xyz/api/index.php/users"
attempts_url = "http://codingseries.xyz/api/index.php/attempts"

schools = {
  1 => 'UW',
  2 => 'WLU'
}

SCHEDULER.every '2s' do
  c = Curl::Easy.new(users_url)
  c.perform
  users = c.body_str
  users = JSON.parse(users)

  c = Curl::Easy.new(attempts_url)
  c.perform
  attempts = c.body_str
  attempts = JSON.parse(attempts)
  user_hash = {}

  users.each do |user|
    begin
      user_hash[user['id']] = { label: schools[user['school'].to_i] + ' - ' +  user['username'], value: 0 }
    rescue StandardError => e
      $stderr.puts e
    end
  end

  attempts.each do |attempt|
    begin
      value = user_hash[attempt['user']][:value] +  attempt['points'].to_i
      user_hash[attempt['user']][:value] = value
    rescue StandardError => e
      $stderr.puts e
    end
  end



  data = Array.new
  user_hash.each do |i, result|
    data << result
  end

  data = data.sort_by { |hsh| hsh[:value] }.reverse

  send_event('leaderboard', { items: data })

end
