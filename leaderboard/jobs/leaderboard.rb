require 'curb'

users_url = "http://codingseries.xyz/api/index.php/users"
attempts_url = "http://codingseries.xyz/api/index.php/attempts"

#buzzwords = ['Paradigm shift', 'Leverage', 'Pivoting', 'Turn-key', 'Streamlininess', 'Exit strategy', 'Synergy', 'Enterprise', 'Web 2.0'] 
#buzzword_counts = Hash.new({ value: 0 })

def get_users
   c = Curl::Easy.new(users_url)
   c.perform
   c.body_str
end

def get_attempts
   c = Curl::Easy.new(attempts_url)
   c.perform
   c.body_str
end

def get_data
  users = get_users
  attempts = get_users
end

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
  username_hash = {}

  users.each do |user|
    begin
      user_hash[user['id']] = 0 
      username_hash[user['id']] = user['username']; 
    rescue StandardError => e
    end 
  end

  attempts.each do |attempt|
    begin
      user_hash[attempt['user']] = user_hash[attempt['user'].to_s] + attempt['points'].to_i
    rescue StandardError
    end
  end


  data_hash = {}
  user_hash.each do |id, points|
    username = username_hash[id]
    data_hash[username] = { label: username, value: points }
  end

  send_event('leaderboard', { items: data_hash.values })

#random_buzzword = buzzwords.sample
  #buzzword_counts[random_buzzword] = { label: random_buzzword, value: (buzzword_counts[random_buzzword][:value] + 1) % 30 }
  
  #send_event('leaderboard', { items: buzzword_counts.values })
end
