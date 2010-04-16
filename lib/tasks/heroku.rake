namespace :heroku do
  
  namespace :server do    
    desc "Backup db directly to Dropbox via cron"
    task :backup => :environment do
      puts "Postgress dump ..."  
      date = Time.now.strftime("%Y-%m-%d_%H-%M-%S")
      backup_file = "db-#{date}.db"
      db = ENV['DATABASE_URL'].match(/postgres:\/\/([^:]+):([^@]+)@([^\/]+)\/(.+)/)
      system "PGPASSWORD=#{db[2]} pg_dump -Fc --username=#{db[1]} --host=#{db[3]} #{db[4]} > tmp/#{backup_file}"
      
      puts "Encrypting backup file ..."
      require 'crypt/blowfish'
      blowfish = Crypt::Blowfish.new("cs-33-kobi")
      crypt_file = "#{backup_file}.enc"
      blowfish.encrypt_file("tmp/#{backup_file}", "tmp/#{crypt_file}")      
      
      puts "Move backup file to Dropbox ..."
      require "dropbox"
      d = DropBox.new("cs@clair.ro", "almafa-12")
      d.create("tmp/#{crypt_file}", "kobi")
      system "rm tmp/#{backup_file} tmp/#{crypt_file}"      
    end
    
    task :test do
      puts "Encrypting backup file ..."
      require 'crypt/blowfish'
      blowfish = Crypt::Blowfish.new("cs-33-kobi")      
      blowfish.encrypt_file("tmp/ro.yml", "tmp/ro.yml.enc") 
    end
  
  end
  
  namespace :local do
    desc "Backing up Heroku DB to kobi_development and dump to Dropbox"
    task :backup do
      puts "Pulling from Heroku ..."
      cmd = "heroku db:pull"
      result = system(cmd)
      raise("Error pulling from Heroku: #{$?}") unless result
      
      puts "Postgress dump ..."  
      date = Time.now.strftime("%Y-%m-%d_%H-%M-%S")
      backup_file = "db-#{date}.db"
      cmd = "pg_dump kobi_development > #{backup_file}"
      result = system(cmd)
      raise("Error dumping Postgress: #{$?}") unless result
      
      puts "Compressing dump file ..."
      tar_file = "db-#{date}.tar.gz"
      cmd = "tar -cvzf #{tar_file} #{backup_file}"
      result = system(cmd)
      raise("Error compressing dump file: #{$?}") unless result
      
      puts "Encrypting tar file ..."
      enc_file = "db-#{date}.tar.gz.enc"
      cmd = "openssl enc -blowfish -in #{tar_file} -out #{enc_file}"
      result = system(cmd)
      raise("Error encrypting tar file: #{$?}") unless result
            
      puts "Moving to Dropbox ..."
      cmd = "mv #{enc_file} ~/Dropbox/kobi/"
      result = system(cmd)
      raise("Error moving to Dropbox: #{$?}") unless result
      
      puts "Removing temp files ..."
      cmd = "rm db-*"
      result = system(cmd)
      raise("Error removing temp files: #{$?}") unless result
      
      puts "... done"
    end
    
    desc "Pushing local development database to staging server"
    task :restore do
      
      puts "Uploading dev database to staging server ..."      
      cmd = "heroku db:push --app kobi-staging"
      result = system(cmd)
      raise("Error uploading db to staging: #{$?}") unless result
      
      puts "... done"    
    end
  end
  
end

task :cron => :environment do
  Rake::Task['heroku:server:backup'].invoke
end
