class GroupsController < AdminController
  def index_scope
    scope=params[:scope]
    if scope 
      if scope == 'own'
      elsif scope == 'joined'
      end
    end    
  end  
  def index_last
    @objs.each do |group|
      group.my_role=current_user.role_of_group(group.id)      
    end     
  end   
  def show
    opr=params[:scope]
    group_id=params[:id]
    if opr == 'join'
      current_user.join_group(group_id)
    elsif opr == 'leave'
      current_user.leave_group(group_id)
    end
    @obj=Group.find(group_id)
    @obj.my_role=current_user.role_of_group(group_id)
    render :show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    # Only allow a trusted parameter "white list" through.
    def get_params
      #params.require(:group).permit(:name, :description, :pid, :ancestry, :active, :user_id)
      params.require(:group).permit!

    end

    #def search_col
      #Group.column_names[1]
    #end     
end