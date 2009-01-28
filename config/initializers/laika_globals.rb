
LAIKA_VERSION = "1.3.6"
FEEDBACK_EMAIL = "talk@projectlaika.org"
ERROR_EMAIL = "rmccready@mitre.org"

# Extract the subversion revision number from the
# Capistrano REVISION file or the .svn/entries file
begin
  revision_path = File.dirname(__FILE__) + '/../../REVISION'
  entries_path = '.svn/entries'
  if File.exists?(revision_path)
    File.open(revision_path, "r") do |rev|
      LAIKA_REVISION = rev.readline.chomp
    end
  elsif File.exists?(entries_path)
    File.open(entries_path, "r").enum_with_index do |line,i|
      if i == 3
        LAIKA_REVISION = line
        break
      end
    end
  end
end
