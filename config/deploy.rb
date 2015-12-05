require 'mina/bundler'
require 'mina/rails'
require 'mina/git'
require 'mina/scp'

set :domain, 'better-ukraine.eu'
set :deploy_to, '/var/www/better-ukraine'
set :repository, 'git@github.com:Kukunin/better-ukraine.git'
set :branch, 'master'

set :tmp_build, "/tmp/#{domain}-build"
# Optional settings:
set :user, 'deploy' # Username in the server to SSH to.
#   set :port, '30000'     # SSH port number.
#   set :forward_agent, true     # SSH forward_agent.

task :environment do
end

task setup: :environment do
  queue! %(mkdir -p "#{deploy_to}/#{shared_path}/log")
  queue! %(chmod g+rx,u+rwx "#{deploy_to}/#{shared_path}/log")

  queue %(
    repo_host=`echo $repo | sed -e 's/.*@//g' -e 's/:.*//g'` &&
    repo_port=`echo $repo | grep -o ':[0-9]*' | sed -e 's/://g'` &&
    if [ -z "${repo_port}" ]; then repo_port=22; fi &&
    ssh-keyscan -p $repo_port -H $repo_host >> ~/.ssh/known_hosts
  )
end

desc 'Deploys the current version to the server.'
task deploy: :environment do
  to :before_hook do
    # TODO: use queue
    ssh("rm -rf #{tmp_build}", return: true)
    `bundle exec middleman build`
    scp_upload('build/', tmp_build, recursively: true)
  end
  deploy do
    queue %(mv #{tmp_build}/* .)
    invoke :'deploy:cleanup'
  end
end
