namespace :db do
  desc 'Wipes database clean'
  task :wipe => %w(db:drop db:create db:migrate) do
    puts 'Done.'
  end

  desc 'Recreates database and seeds it with sandbox credentials'
  task :recreate => %w(db:wipe db:seed:sandbox) do
    puts "Done."
  end

  namespace :recreate do
    desc 'Recreates database and seed with fake data'
    task :fake => %w(db:wipe db:seed) do
      puts "Done."
    end
  end

  namespace :seed do
    desc 'Seed ONLY sandbox data'
    task :sandbox => :environment do
      require 'db/sandbox'
    end
  end
end
