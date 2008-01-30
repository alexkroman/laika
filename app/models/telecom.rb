# Encapsulates the telecom section of a C32. Instead of having
# a bunch of telecom instances as part of a has_many, we've
# rolled the common ones into a single record. This should
# make validation easier when dealing with phone numbers
# vs. email addresses
class Telecom < ActiveRecord::Base
  # did you expect telecomable? ;-)
  belongs_to :reachable, :polymorphic => true
end
