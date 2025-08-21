# lib/tasks/noop.rake
namespace :db do
  desc 'No-op for db:prepare (Mongoid does not use this)'
  task :prepare do
    puts 'No-op: db:prepare is not needed for Mongoid.'
  end
end
