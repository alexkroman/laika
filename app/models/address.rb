class Address < ActiveRecord::Base
  belongs_to :iso_country
  belongs_to :addressable, :polymorphic => true
end
