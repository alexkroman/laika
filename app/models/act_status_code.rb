class ActStatusCode < ActiveRecord::Base
  named_scope :all, :order => 'name ASC'

  include MatchHelper

  def validate_c32(act_status_code)

    unless act_status_code
      return [ContentError.new]
    end

    errors = []
    return errors.compact
  end

end
