# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_voterTrac_session',
  :secret      => '57db29b61ba2505c4bbccd631510d6fb5d50b58a3d028bcdd96bd261c7dbab5cdb0423d8db2439469c035da08203bf1bcd236d8dd6da558cece4e82ef114adfa'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
