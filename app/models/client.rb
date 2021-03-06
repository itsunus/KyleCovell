class Client < ActiveRecord::Base
  has_many :users

  validates :business_name, presence: true, uniqueness: true
  validates :phone, presence: true
  validates :zip_code, numericality: true, :allow_blank => true

  attr_accessor :user_ids

  after_save :associate_users


  private

  def associate_users
    users = User.where(id: user_ids)
    users.each do |user|
      user.update_column(:client_id, self.id)
    end
  end
end
