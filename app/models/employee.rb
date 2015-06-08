class Employee < ActiveRecord::Base
	include Filterable
	before_save { self.email = email.downcase }
  before_save { self.nombre = nombre.capitalize }
	before_create :create_remember_token

	has_many :requests, dependent: :destroy
	belongs_to :department, :inverse_of => :employees

	#validates :department_id, presence: true
	default_scope -> { order('nombre asc')}
	scope :status, -> (status) { where status: status}
	scope :department, -> (department_id) { where department_id: department_id }
	scope :starts_with, -> (nombre) { where("nombre like ?", "#{nombre}%")}

	validates :nombre, presence: true, length: {maximum: 50}
	validates :cargo, presence: true, length: {maximum: 50 }
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(?:\.[a-z\d\-]+)*\.[a-z]+\z/i
	validates :email, presence: true, format: { with: VALID_EMAIL_REGEX},
				uniqueness: { case_sensitive: false }
	
	validates :password, length: { minimum: 6 }
  validate :only_one_chief_department, on: :create

	has_secure_password

	def Employee.new_remember_token
		SecureRandom.urlsafe_base64
	end

  def Employee.new_password
    SecureRandom.urlsafe_base64.first(8)
  end

	def Employee.digest(token)
		Digest::SHA1.hexdigest(token.to_s)
	end

  def only_one_chief_department
    if role == 2
      dpto= Department.find(department_id)
      if dpto && dpto.employees.where(:role => 2,:status => 't').count >= 1
        errors.add(:department,"No se permiten varios empleados con el rol jefe de departamento para un mismo departamento.")
      end
    end
  end

	private
	def create_remember_token
		self.remember_token= Employee.digest(Employee.new_remember_token)
	end
end
