class Ability 
    include CanCan::Ability 
    def initialize(user) 
      user ||= User.new       
      can :manage, :all if user.admin? # Class level 
      # All the following are checking on the object level
      can :manage, :all,:user_id => user.id  
     #can :manage,:all,:group => {:id => user.group_ids} 
      can :manage, :all do |obj|
        if obj.respond_to?(:user_id)
          obj.user_id == user.id
        end
      end               
      can :read, :all do |obj|
        if obj.respond_to?(:group_ids)
          gids_obj=obj.group_ids
          user.read_group?(gids_obj)
        end
      end      
      can :write, :all do |obj|
        if obj.respond_to?(:group_ids)
          gids_obj=obj.group_ids
          user.write_group?(gids_obj)
        end
      end   
      can :manage, :all do |obj|
        if obj.respond_to?(:group_ids)
          gids_obj=obj.group_ids
          user.manage_group?(gids_obj)
        end
      end  
      can :read, :Task do |obj|
        gids_obj=obj.root_task_user_groups
        user.read_group?(gids_obj)
      end
      can :write, :Task do |obj|
        gids_obj=obj.root_task_user_groups
        user.write_group?(gids_obj)
      end 
      can :manage, :Task do |obj|
        gids_obj=obj.root_task_user_groups
        user.manage_group?(gids_obj)
      end                                              
=begin        
        can :create, Article
        can :create, Event
        can :create, Gallery
        can :create, Group        
        can :create, Menu        
        can :create, Medium
        can :create, Type
        can :create, Page              
=end
    end       
end

