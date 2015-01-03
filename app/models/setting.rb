class Setting < RailsSettings::CachedSettings
  #attr_accessible :var
  before_save :remove_extra
  def self.news_header
    {
        title: self['news_header_title'],
        description: self['news_header_description'],
        background_url: self['news_header_background_url'],
        read_more_url: self['news_header_read_more_url']
    }
  end
  def remove_extra
      self.value=YAML.load(value)
  end  
end
