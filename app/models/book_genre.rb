# frozen_string_literal: true

class BooksGenre < ApplicationRecord
  belongs_to :book
  belongs_to :genre
end
