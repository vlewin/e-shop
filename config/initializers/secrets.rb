secrets = Psych.load_file(Rails.root.join('config/secrets.yml'))
dot_secrets = Rails.root.join('config/.secrets.yml')

if File.exist? dot_secrets
  if dot_secrets = Psych.load_file(dot_secrets)
    secrets.merge(dot_secrets)[Rails.env].each do |k,v|
      Rails.application.secrets[k] = v
    end
  end
end
