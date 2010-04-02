begin
  namespace :heroku do
    
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
      
      puts "Compress dump file ..."
      tar_file = "db-#{date}.tar.gz"
      cmd = "tar -cvzf #{tar_file} #{backup_file}"
      result = system(cmd)
      raise("Error compressing dump file: #{$?}") unless result
      
      puts "Encrypt tar file ..."
      enc_file = "db-#{date}.tar.gz.enc"
      cmd = "openssl enc -blowfish -in #{tar_file} -out #{enc_file}"
      result = system(cmd)
      raise("Error encrypting tar file: #{$?}") unless result
            
      puts "Move to Dropbox ..."
      cmd = "mv #{enc_file} ~/Dropbox/kobi/"
      result = system(cmd)
      raise("Error moving to Dropbox: #{$?}") unless result
      
      puts "... done"
    end
  end
end
