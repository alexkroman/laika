class ResultTypeCode < ActiveRecord::Base
  named_scope :all, :order => 'name ASC'

  include MatchHelper

  def validate_c32(result_type_code)

    unless result_type_code
      return [ContentError.new]
    end

    errors = []

    return errors.compact

  end

end
