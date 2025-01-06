# frozen_string_literal: true

class Book < ApplicationRecord
  belongs_to :publisher
  has_and_belongs_to_many :authors
  has_and_belongs_to_many :genres
  validates :title, presence: true
  validates :published_in, presence: true
end
