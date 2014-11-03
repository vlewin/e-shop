default = Psych.load_file(Rails.root.join('config/secrets.yml'))
overrides = Psych.load_file(Rails.root.join('config/.secrets.yml'))

default.merge(overrides)[Rails.env].each do |k,v|
  Rails.application.secrets[k] = v
end
