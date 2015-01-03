class Menu < ActiveRecord::Base 
  before_destroy :stop_delete
  before_save :set_default
  after_create :set_order_by
  #has_ancestry 
  belongs_to  :wpage  
  belongs_to  :dad, :class_name=>'Menu',:foreign_key=>'pid'    
  has_many   :kids,:class_name=>'Menu',:foreign_key=>'pid' 

  #elegate :title,:url, to: :page,allow_nil: true
  #delegate :url, to: :wpage,allow_nil: true
  
  alias :parent :dad # only when no has_ancestry
  alias :children :kids # only when no has_ancestry
  attr_accessor :parent_id # only when no has_ancestry

  def stop_delete
   if self.id && self.id < 11
     raise ActiveRecord::Rollback
   end
  end

  scope :top, lambda {
    #where(ancestry:nil).where(active:true)  
    where(pid:nil).where(active:true).order('order_by asc')       
  }
  scope :gt_id, lambda {|id|
    where('id>?',id)    
  }  
  def set_order_by
    if order_by.nil?
      self.order_by=self.id*10
      self.save!
    end
  end
  def set_default
    #self.parent_id=self.pid
    self.active=true if self.active.nil?
    #self.url =self.page.url if self.page 
    if self.id && self.id < 11
      # These menu cannot have parent
     raise ActiveRecord::Rollback if self.pid
    end    
  end
  def title
    page= self.wpage
    if page
      page.title
    else
      self.name
    end
  end
  def get_url()
    return self.url if self.url
    return self.wpage.url if self.wpage
    '/'
  end
end



