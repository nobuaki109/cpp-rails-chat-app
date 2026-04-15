class MessageSearchService
  def self.search_texts(messages, query)
    SearchExt.search(messages, query.to_s)
  end
end