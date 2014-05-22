desc 'Setting up config vars for a deployed application'
namespace :heroku do
  task :secrets, :app do |t, args|
    secrets = YAML.load_file Rails.root.join('config/.secrets.yml')

    app = args[:app] || 'e-shop-demo'
    cmd = 'heroku config:set '
    secrets.each do |k,v|
      cmd += "#{k.upcase}=#{v} "
    end
    puts `#{cmd.strip} --app #{app}`
  end
end
