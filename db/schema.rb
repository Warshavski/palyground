# frozen_string_literal: true

# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 20_241_223_084_352) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'authors', force: :cascade do |t|
    t.string 'first_name'
    t.string 'last_name'
    t.text 'biography'
    t.date 'born_in'
    t.date 'died_in'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index %w[first_name last_name], name: 'index_authors_on_first_name_and_last_name'
  end

  create_table 'authors_books', id: false, force: :cascade do |t|
    t.bigint 'book_id', null: false
    t.bigint 'author_id', null: false
  end

  create_table 'books', force: :cascade do |t|
    t.string 'title', null: false
    t.integer 'weight', default: 0, null: false
    t.integer 'pages_count', default: 0, null: false
    t.text 'description'
    t.string 'isbn13', limit: 13
    t.string 'isbn10', limit: 10
    t.date 'published_in', null: false
    t.bigint 'publisher_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['publisher_id'], name: 'index_books_on_publisher_id'
  end

  create_table 'books_genres', id: false, force: :cascade do |t|
    t.bigint 'book_id', null: false
    t.bigint 'genre_id', null: false
  end

  create_table 'genres', force: :cascade do |t|
    t.string 'name', null: false
    t.text 'description'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'publishers', force: :cascade do |t|
    t.string 'name', null: false
    t.string 'email'
    t.string 'phone'
    t.string 'address'
    t.string 'postcode'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  add_foreign_key 'books', 'publishers'
end
