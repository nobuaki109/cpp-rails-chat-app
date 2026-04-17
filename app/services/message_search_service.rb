class MessageSearchService
  def self.search_messages(messages, query)
    return messages if query.blank?

    matched_contents = SearchExt.search(messages.pluck(:content), query.to_s)

    messages.select { |message| matched_contents.include?(message.content) }
  end
end