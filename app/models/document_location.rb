class DocumentLocation < ActiveRecord::Base
  has_many :namespaces
end
