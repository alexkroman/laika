class ProblemType < ActiveRecord::Base
  named_scope :all, :order => 'name ASC'

  include MatchHelper

  def validate_c32(problem_code)

    unless problem_code
      return [ContentError.new]
    end

    errors = []
    errors << match_value(problem_code,'@code','code',code)
    errors << match_value(problem_code,'@displayName','displayName',name)
    return errors.compact

  end

end
