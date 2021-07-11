class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, omniauth_providers: %i[ google facebook ]


  def self.create_unique_string
    SecureRandom.uuid
  end

  def self.find_for_oauth(auth)
    # user = User.find_by(email: auth.info.email)
    sns = Credential.where(uid: auth.uid, provider: auth.provider).first
    unless sns
      @user = User.new(name: auth.info.name,
                      email: auth.info.email,
                      avatar: auth.info.image,
                      password: Devise.friendly_token[0, 20],
                      )
      sns = Credential.new(user_id: @user.id,
                              provider: auth.provider,
                              uid: auth.uid,
                              )
    end
    @user.save
    sns.save
    @user
    sns
  end
end
