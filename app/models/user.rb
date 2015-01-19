class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password,:username,:companyname,:telephone,:fax,:country,:zipcode,:city,:stateprovince,:address, :password_confirmation, :common, :remember_me
  
  after_destroy :ensure_an_admin_remains
  validates :email, :password, :password_confirmation ,:username,:companyname,:telephone,:fax,:country,:zipcode,:city,:stateprovince,:address, presence: true


private 
	def ensure_an_admin_remains
		if !User.find_by_common(true)
			raise "You can't erase last admin"
		end
	end


end
