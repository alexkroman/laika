
LAIKA_VERSION = "1.3.6"
FEEDBACK_EMAIL = "talk@projectlaika.org"
ERROR_EMAIL = "rmccready@mitre.org"

# Extract the subversion revision number from the
# Capistrano REVISION file or the .svn/entries file
LAIKA_REVISION = begin
  revision_path = File.dirname(__FILE__) + '/../../REVISION'
  entries_path = '.svn/entries'
  if File.exists?(revision_path)
    File.open(revision_path, "r") do |rev|
      rev.readline.chomp
    end
  elsif File.exists?(entries_path)
    File.open(entries_path, "r") do |entries|
      entries.to_a[3].chomp
    end
  else
    'x'
  end
end
