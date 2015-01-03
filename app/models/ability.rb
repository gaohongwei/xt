class Ability 
    include CanCan::Ability 
 
    def initialize(user) 
      user ||= User.new 
      if user.admin?
        can :manage, :all
      else  
        can :read, :all  
        can :create, :all          
        can :manage, :all do |obj| 
          obj.respond_to?(:user_id) && obj.user_id == user.id
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

        can :manage, Article do |p| 
           p.user_id=user.id
        end                              
        can :manage, Event do |p| 
           p.user_id=user.id
        end 
        can :manage, Gallery do |u| 
           p.user_id=user.id
        end 
        can :manage, Group do |p| 
           p.user_id=user.id
        end 
        can :manage, Menu do |p| 
           p.user_id=user.id
        end 
        can :manage, Medium do |p| 
           p.user_id=user.id
        end 
        can :manage, User do |u| 
           u.id==user.id
        end         
=end
      end 
    end       
end

