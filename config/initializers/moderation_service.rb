class ModerationService
  def self.contains_ng_word?(text)
    ModerationExt.contains_ng_word(text.to_s)
  end
end