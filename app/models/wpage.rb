class Wpage < ActiveRecord::Base
  has_many :menus
  belongs_to :widget
  after_create :create_menu
  attr_writer :menu_pid

  scope :by_url, lambda {|url|
    if url.size > 0 && url[0]!='/'
      url ='/'+url
    end
    where(url: url)
  }
  def create_menu
    Menu.create!(pid:@menu_pid||3,name:self.title,wpage_id:self.id,user_id:self.user_id)    
  end
  def menu_list
    self.menus.map{|x|x.name}.join(',')
  end  
end