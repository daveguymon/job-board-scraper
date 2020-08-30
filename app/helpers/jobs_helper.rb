module JobsHelper
  def parseLinks(description)
    url_regexp = %r{
      (?:(?:https?|ftp|file):\/\/|www\.|ftp\.)
      (?:\([-A-Z0-9+&@#\/%=~_|$?!:,.]*\)|
           [-A-Z0-9+&@#\/%=~_|$?!:,.])*
      (?:\([-A-Z0-9+&@#\/%=~_|$?!:,.]*\)|
            [A-Z0-9+&@#\/%=~_|$])
    }ix

    description = description.gsub(/(Watch)/, "  Watch")
    description.gsub(url_regexp, '<a href="\0">\0</a>').html_safe
  end
end
