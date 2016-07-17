class Article < ActiveRecord::Base
  has_many :comments
  has_many :taggings
  has_many :tags, :through => :taggings
  
  def tag_list
    tags.join(", ")
  end
  
  def tag_list=(string)
    tag_names = string.split(",").collect{|s| s.strip.downcase}.uniq
    tag_objects = tag_names.collect { |tag_name| Tag.find_or_create_by(name: tag_name) }
    self.tags = tag_objects
  end
end
