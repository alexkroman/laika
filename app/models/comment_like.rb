module CommentLike

  def self.included(base)

    base.class_eval do

      has_one :comment, :as => :commentable

      def copy
        copied_comment_like = self.clone
        copied_comment_like.save!
        copied_comment_like.comment = self.comment.clone unless self.comment.nil?
        copied_comment_like
      end

      def update_comment_attributes(params)
        self.comment.update_attributes(params[:comment])
      end

      def create_person_attributes(params)
        self.comment = Comment.new(params[:comment])
      end

      def has_any_data
        if self.comment != nil
          if !self.comment.text.blank? 
             return true
          end
        end
        return false
      end

    end

  end

end