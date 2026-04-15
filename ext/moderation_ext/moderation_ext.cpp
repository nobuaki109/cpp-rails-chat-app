#include "ruby.h"
#include <string>
#include <vector>
#include <algorithm>

static VALUE rb_mModerationExt;

static std::string to_lower_copy(const std::string& input) {
  std::string result = input;
  std::transform(result.begin(), result.end(), result.begin(),
                 [](unsigned char c) { return static_cast<char>(std::tolower(c)); });
  return result;
}

static VALUE rb_contains_ng_word(VALUE self, VALUE rb_text) {
  Check_Type(rb_text, T_STRING);

  std::string text = StringValueCStr(rb_text);
  text = to_lower_copy(text);

  const std::vector<std::string> ng_words = {
    "spam",
    "scam",
    "fake"
  };

  for (const auto& word : ng_words) {
    if (text.find(word) != std::string::npos) {
      return Qtrue;
    }
  }

  return Qfalse;
}

extern "C" void Init_moderation_ext() {
  rb_mModerationExt = rb_define_module("ModerationExt");
  rb_define_singleton_method(rb_mModerationExt, "contains_ng_word", RUBY_METHOD_FUNC(rb_contains_ng_word), 1);
}