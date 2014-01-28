Octokit.configure do |c|
  c.login = ENV['GITHUB_USERNAME']
  c.password = ENV['GITHUB_USER_SECRET']
end