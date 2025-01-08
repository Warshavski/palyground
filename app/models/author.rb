# frozen_string_literal: true

class Author < ApplicationRecord
  has_and_belongs_to_many :books
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :biography, presence: true
  validates :born_in, presence: true
end
