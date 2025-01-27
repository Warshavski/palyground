# frozen_string_literal: true

class AuthorsBooks < ApplicationRecord
  belongs_to :book
  belongs_to :author
end
