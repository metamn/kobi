# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_kobi_session',
  :secret      => 'af998e66eafac7fc8e0d029a179b29fb4b21bfa83f9794abebdb8499bdab847224380c0455d9070284cdd95eca31528c2b2cadfeb78919298e53281a6f042f85'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
