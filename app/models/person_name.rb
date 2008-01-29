class PersonName < ActiveRecord::Base
  belongs_to :nameable, :polymorphic => true
end
