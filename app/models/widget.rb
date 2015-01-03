class Widget < ActiveRecord::Base 
  attr_accessor :layout_type,:column_per_row,:data
  attr_accessor :template_id
  attr_accessor :reset_parent  
  before_save :set_content_parent
  before_save :validate_tree
  def validate_tree
    if self.id
      pids=self.ancestor_ids
      cids=self.child_ids
      if (pids&cids).size > 0 
       raise ActiveRecord::Rollback
      end      
      if pids.include?(self.id) || cids.include?(self.id)
        raise ActiveRecord::Rollback
      end
    end
  end
  
  has_ancestry 
  has_one  :wpage
  has_many   :kids,:class_name=>'Widget',:foreign_key=>'pid' 
  belongs_to :template
  belongs_to :dad, :class_name=>'Widget',:foreign_key=>'pid'  

  scope :top, lambda {
    where(:ancestry=>nil)    
    #where("ancestry=? or ancestry=?",nil,'')
  }

  def set_content_parent
    self.parent_id=self.pid
    if self.content.nil? || self.content.empty?
      unless template_id.nil? || template_id.empty?
        tpl=Template.find(template_id)
        self.content=tpl.content
      end
    end
  end
  def get_content_me
      self.content
  end
  # Have children, template is layout
  # No children, template is html partial
  def get_content()
    result=''
    if self.children.empty?
      result=self.content
    else
      # Display line by line them if it has childern, but no layout
      if self.content.nil? || self.content.empty?
        self.children.each do |w|
          result +=w.get_content()
          result +='</br>' # Each child takes a new line
        end
      end
    end
    result
  end   
  def get_fname(with_=true)
    if with_
      sprintf("_w%09d.html.erb",self.id)
    else
      sprintf("w%09d.html.erb",self.id)
    end
  end
  def get_partial()
    fname=get_fname(false) 
    "widget/#{fname}"
  end  
  def save_partial()
    fname=get_fname(true)   
    #name=File.join(Rails.root, 'app/views/widget',fname)      
    fname=File.join('app/views/widget',fname)    
    File.write(fname,self.get_content())
  end
  def render()
    sprintf("<%= render partial:'%s',id:%d %>",get_partial(),self.id)
  end
  def kid_list()
    str=''
    kids.each do |x|
      str +='</br>'
      str +=x.name
    end
    str.html_safe
  end
end