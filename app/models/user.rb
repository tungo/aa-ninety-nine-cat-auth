class User < ActiveRecord::Base
  # add_index :session_token

  after_initialize :ensure_session_token

  def ensure_session_token

  end
end
