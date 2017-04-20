class User < ActiveRecord::Base
  # add_index :session_token

  after_initialize :ensure_session_token

  has_many :cats,
  primary_key: :id,
  foreign_key: :user_id,
  class_name: :Cat


  #all these methods are on server's side
  def ensure_session_token

  end

  def self.generate_session_token
    SecureRandom::urlsafe_base64(16)
  end

  def reset_session_token!
    self.session_token = User.generate_session_token
    self.save
  end

  def password=(password)
    @password = password  # ? why store password in instance var?
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(password_digest).is_password?(password)
  end

  def self.find_by_credentials(username, password)
    user = self.find_by(username: username) # NOT from params, username: from users table column 'username'
    return user if user && user.is_password?(password)
    nil
  end

end
