class CommentsController < PatientDataChildController
  def new
    @comment = Comment.new
    @comment.person_name = PersonName.new
    @comment.address = Address.new
    @comment.telecom = Telecom.new
    render :partial  => 'edit', :locals => {:comment => @comment,
           :patient => @patient}
  end
  
  def edit
    @comment = @patient.comments.find(params[:id])
    render :partial  => 'edit', :locals => {:comment => @comment,
                                            :patient => @patient}
  end
  
  def create
    @comment = Comment.new(params[:comment])
    @comment .create_person_attributes(params)
    @patient.comments << @comment
    render :partial  => 'create', :locals => {:comment => @comment,
                                              :patient => @patient}
  end
  
  def update
    @comment = @patient.comments.find(params[:id])
    @comment.update_person_attributes(params)
    @comment.update_attributes(params[:comment])
    
    render :partial  => 'show', :locals => {:comment => @comment,
                                            :patient => @patient}
  end
  
  def destroy
    @comment = @patient.comments.find(params[:id])
    @comment.destroy
    render :partial  => 'delete.rjs'
  end
end