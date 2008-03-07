class CommentsController < PatientDataChildController
  def new
    @comment = Comment.new
    @comment.person_name = PersonName.new
    @comment.address = Address.new
    @comment.telecom = Telecom.new
    render :partial  => 'edit', :locals => {:comment => @comment,
           :patient_data => @patient_data}
  end
  
  def edit
    @comment = @patient_data.comments.find(params[:id])
    render :partial  => 'edit', :locals => {:comment => @comment,
                                            :patient_data => @patient_data}
  end
  
  def create
    @comment = Comment.new(params[:comment])
    @comment .create_person_attributes(params)
    @patient_data.comments << @comment
    render :partial  => 'create', :locals => {:comment => @comment,
                                              :patient_data => @patient_data}
  end
  
  def update
    @comment = @patient_data.comments.find(params[:id])
    @comment.update_person_attributes(params)
    @comment.update_attributes(params[:comment])
    
    render :partial  => 'show', :locals => {:comment => @comment,
                                            :patient_data => @patient_data}
  end
  
  def destroy
    @comment = @patient_data.comments.find(params[:id])
    @comment.destroy
    redirect_to patient_data_url
  end
end