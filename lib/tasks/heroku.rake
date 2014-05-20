desc 'Setting up config vars for a deployed application'
namespace :heroku do
  task :secrets do
    secrets = YAML.load_file Rails.root.join('config/secrets.yml')

    cmd = 'heroku config:set '
    secrets['development'].each do |k,v|
      cmd += "#{k}=#{v} "
    end

    puts `#{cmd.strip}`
  end
end
