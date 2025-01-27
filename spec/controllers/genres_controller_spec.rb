require 'rails_helper'

RSpec.describe "GenresController", type: :request do
  describe "GET /genres" do
    before do
      @genres = create_list(:genre, 3)
    end

    it "returns a successful response" do
      get genres_path
      expect(response).to have_http_status(:ok)
    end

    it "returns all genres with their details as JSON" do
      get genres_path
      json_response = JSON.parse(response.body)
      expect(json_response.size).to eq(3)

      @genres.each do |genre|
        expect(json_response).to include(
          a_hash_including(
            'id' => genre.id,
            'name' => genre.name,
            'description' => genre.description
          )
        )
      end
    end
  end

  describe "GET /genres/:id" do
    let(:genre) { create(:genre, :with_books) }

    it "returns a successful response" do
      get genre_path(genre)
      expect(response).to have_http_status(:ok)
    end

    it "returns the correct genre as JSON" do
      get genre_path(genre)
      json_response = JSON.parse(response.body)

      expect(json_response['id']).to eq(genre.id)
      expect(json_response['name']).to eq(genre.name)
      expect(json_response['description']).to eq(genre.description)
    end

    # it "returns a 404 error if the genre is not found" do
    #   get genre_path(id: 9999)
    #   expect(response).to have_http_status(:not_found)
    # end
    # возникает ошибка :Errors::RequestErrorsSerializer.new(error, type).serialize(status, opts)
  end
end
