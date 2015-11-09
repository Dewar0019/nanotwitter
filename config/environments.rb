configure :production do
  require 'newrelic_rpm'
  puts "[production environment]"
end

configure :development, :test do
  puts "[develoment or test Environment]"
end
