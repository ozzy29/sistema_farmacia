class Cashier < ApplicationRecord
  require 'uri'

  has_secure_password

  validates :first_name,
            presence: { stritc: true, message: 'Nombre obligatorio' }

  validates :last_name,
            presence: { stritc: true, message: 'Apellido obligatorio' }

  validates :email,
            format: { with: URI::MailTo::EMAIL_REGEXP, message: 'Solo se permiten correos electrónicos válidos' },
            presence: { stritc: true, message: 'Email obligatorio' },
            uniqueness: { message: 'Correo ya existe' }

  validates :dni,
            presence: { stritc: true, message: 'Dni obligatorio' },
            length: { is: 8, message: 'Debe tener 8 digitos' },
            uniqueness: { message: 'Dni ya existe' }

  validates :age,
            presence: { stritc: true, message: 'Edad obligatoria' },
            length: { is: 2, message: 'Debe tener 2 digitos' }

  validates :birth_day,
            # format: { with: /\d{2}\/\d{2}\/\d{4}/, message: 'Fecha Nacimiento debe tener formato DD/MM/YYYY' },
            presence: { stritc: true, message: 'Fecha Nacimiento Obligatorio' }
  validates :token_jwt, presence: false

  validates :password, # este atributo no esta en la base de datos sin embargo se necesita para el bcrypt
            presence: { stritc: true, message: 'Clave obligatoria' },
            length: { minimum: 8, message: 'Debe tener minimo 8 caracteres' }

end
