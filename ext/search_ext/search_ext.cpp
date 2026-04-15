#include "ruby.h"
#include <string>
#include <vector>
#include <algorithm>
#include <cctype>

static VALUE rb_mSearchExt;

static std::string to_lower_copy(const std::string& input) {
  std::string result = input;
  std::transform(result.begin(), result.end(), result.begin(),
                 [](unsigned char c) { return static_cast<char>(std::tolower(c)); });
  return result;
}

static VALUE rb_search(VALUE self, VALUE rb_messages, VALUE rb_query) {
  Check_Type(rb_messages, T_ARRAY);
  Check_Type(rb_query, T_STRING);

  std::string query = StringValueCStr(rb_query);
  query = to_lower_copy(query);

  VALUE results = rb_ary_new();

  long len = RARRAY_LEN(rb_messages);
  for (long i = 0; i < len; i++) {
    VALUE rb_message = rb_ary_entry(rb_messages, i);
    Check_Type(rb_message, T_STRING);

    std::string message = StringValueCStr(rb_message);
    std::string lower_message = to_lower_copy(message);

    if (lower_message.find(query) != std::string::npos) {
      rb_ary_push(results, rb_message);
    }
  }

  return results;
}

extern "C" void Init_search_ext() {
  rb_mSearchExt = rb_define_module("SearchExt");
  rb_define_singleton_method(rb_mSearchExt, "search", RUBY_METHOD_FUNC(rb_search), 2);
}