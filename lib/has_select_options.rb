#
# This module extends ActiveRecord::Base with a single class method: has_select_options().
# When you call this method on an ActiveRecord class it will generate the class method select_options().
#
# - This is meant to be used with models whose records are used as the choices in a select dropdown.
# - You can pass finder options to filter or change the order.
# - You can change the generated method name, useful if you need multiple methods
# - You can pass a block to change the output of select_options. The block argument is a single record.
# - The output of select_options can be passed to a form.select helper.
# - You can explicitly pass an array of objects that you'd like to select from instead.
#
# By default, select_options will select all records sorted by name ascending.
# The default output for each record is [name, id].
#
# Examples:
#
#  class IsoCountry
#    # use the default order and output
#    has_select_options
#  end
#  IsoCountry.select_options # => [["Afghanistan", 480326053], ... ["Zimbabwe", 809220305]]
#
#  class IsoState
#    # use a different order and output from the defaults
#    has_select_options(:order => 'iso_abbreviation ASC') {|r| r.iso_abbreviation }
#  end
#  IsoState.select_options # => ['AK', 'AL', ... 'WV', 'WY']
#
#  class CodeSystem
#    # multiple methods
#    has_select_options :name => :select_options
#    has_select_options :name => :medication_select_options,
#     :order => "name DESC",
#     :conditions => {
#       :code => [ # performs a SQL IN
#         '2.16.840.1.113883.6.88',  # RxNorm
#         '2.16.840.1.113883.6.69',  # NDC
#         '2.16.840.1.113883.4.9',   # FDA Unique Ingredient ID (UNIII)
#         '2.16.840.1.113883.4.209'  # NDF RT
#       ]
#     }
#  end
#
module HasSelectOptionsExtension
  def has_select_options(args = {})
    (class << self; self; end).instance_eval do
      method_name = args.delete(:name) || :select_options
      define_method(method_name) do |*x|
        (x.size > 0 ? x[0] : find(:all, { :order => 'name ASC' }.merge(args))).map do |r|
          block_given? ? yield(r) : [r.name, r.id]
        end
      end
      define_method("html_#{method_name}") do |*x|
        send(method_name, *x).map { |r| %{ <option value="#{r[1]}">#{r[0]}</option> } }
      end
    end
  end
end

