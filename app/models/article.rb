class Article < ActiveRecord::Base
  has_many :comments
  has_many :taggings
  has_many :tags, :through => :taggings
  has_attached_file :image
  validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png"]


  def tag_list
    tags.join(", ")
  end

  def tag_list=(string)
    tag_names = string.split(",").collect{|s| s.strip.downcase}.uniq
    tag_objects = tag_names.collect { |tag_name| Tag.find_or_create_by(name: tag_name) }
    self.tags = tag_objects
  end
end
