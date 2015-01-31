include_recipe 'build-essential'
include_recipe 'git'
include_recipe 'curl'

%W{imagemagick unzip jpegoptim libjpeg-turbo-progs}.each do |p|
  package p
end
