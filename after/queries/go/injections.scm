; extends

([
  (raw_string_literal_content)
  (interpreted_string_literal_content)
] @injection.content
  (#lua-match? @injection.content "^%s*[Ss][Ee][Ll][Ee][Cc][Tt]%s")
  (#set! injection.language "sql"))

([
  (raw_string_literal_content)
  (interpreted_string_literal_content)
] @injection.content
  (#lua-match? @injection.content "^%s*[Ii][Nn][Ss][Ee][Rr][Tt]%s")
  (#set! injection.language "sql"))

([
  (raw_string_literal_content)
  (interpreted_string_literal_content)
] @injection.content
  (#lua-match? @injection.content "^%s*[Uu][Pp][Dd][Aa][Tt][Ee]%s")
  (#set! injection.language "sql"))

([
  (raw_string_literal_content)
  (interpreted_string_literal_content)
] @injection.content
  (#lua-match? @injection.content "^%s*[Dd][Ee][Ll][Ee][Tt][Ee]%s")
  (#set! injection.language "sql"))

([
  (raw_string_literal_content)
  (interpreted_string_literal_content)
] @injection.content
  (#lua-match? @injection.content "^%s*[Ww][Ii][Tt][Hh]%s")
  (#set! injection.language "sql"))

([
  (raw_string_literal_content)
  (interpreted_string_literal_content)
] @injection.content
  (#lua-match? @injection.content "^%s*[Cc][Rr][Ee][Aa][Tt][Ee]%s")
  (#set! injection.language "sql"))

([
  (raw_string_literal_content)
  (interpreted_string_literal_content)
] @injection.content
  (#lua-match? @injection.content "^%s*[Aa][Ll][Tt][Ee][Rr]%s")
  (#set! injection.language "sql"))

([
  (raw_string_literal_content)
  (interpreted_string_literal_content)
] @injection.content
  (#lua-match? @injection.content "^%s*[Dd][Rr][Oo][Pp]%s")
  (#set! injection.language "sql"))

([
  (raw_string_literal_content)
  (interpreted_string_literal_content)
] @injection.content
  (#lua-match? @injection.content "^%s*[Rr][Ee][Pp][Ll][Aa][Cc][Ee]%s")
  (#set! injection.language "sql"))

([
  (raw_string_literal_content)
  (interpreted_string_literal_content)
] @injection.content
  (#lua-match? @injection.content "^%s*[Tt][Rr][Uu][Nn][Cc][Aa][Tt][Ee]%s")
  (#set! injection.language "sql"))
