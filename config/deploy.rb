lock "~> 3.18.0"

set :application, "askme"
set :repo_url, "git@github.com:ipirojnoe/askme.git"

set :deploy_to, "/home/client/askme"

append :linked_files, 'config/database.yml', '.env'
append :linked_dirs, 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system', 'public/uploads'

set :branch, 'main'
