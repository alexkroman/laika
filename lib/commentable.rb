module Commentable

  def self.included(base)
    base.class_eval do
      has_one :comment, :as => :commentable, :dependent => :destroy
      include CommentableInstance
    end
  end

  module CommentableInstance
    def clone
      copy = super
      copy.save!
      copy.comment = comment.clone if comment
      copy
    end

    def update_comment_attributes(params)
      comment.update_attributes(params[:comment])
    end

    def create_comment_attributes(params)
      self.comment = Comment.new(params[:comment])
    end

    def comment_blank?
      comment.text.blank? 
    end
  end

end
