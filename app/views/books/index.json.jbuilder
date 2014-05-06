json.array!(@books) do |book|
  json.extract! book, :id, :title, :chapter, :content
  json.url book_url(book, format: :json)
end
