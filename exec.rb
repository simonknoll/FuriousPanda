class Photo
  attr_accessor :id
  attr_accessor :orientation
  attr_accessor :tags

  def initialize(id, orientation, tags)
    @id = id
    @orientation = orientation
    @tags = tags
  end
end

class Slide
  attr_accessor :photos

  def initialize(arr)
    @photos = arr
  end

  def tags
    @photos.map(&:tags).flatten.uniq
  end

  def fit_points(other_slide)
    common_tags = (tags & other_slide.tags)
    only_this_tags = tags - other_slide.tags
    only_other_tags = other_slide.tags - tags
    [common_tags.count, only_this_tags.count, only_other_tags.count].min
  end
end

# parse file

lines = File.readlines('input/a_example.txt')
n = lines.shift

puts "n #{n}"
puts "lines #{lines}"

slides = []
v_photos = []

lines.each_with_index.each do |line, i|
  items = line.split(' ')
  o = items.shift
  items.shift # remove count

  p = Photo.new(i, o, items)

  if p.orientation == 'H'
    slides << Slide.new(p)
  else
    v_photos << p
  end
end


v_photos.shuffle.each_slice(2).each do |slice| # todo later non random
  slides << Slide.new(slice)
  puts "add"
end

# create stacks

tags_hash = {}
v_photos.each do |photo|
  photo.tags.each do |tag|
    tags_hash[tag] |= [photo.id]
  end
end

puts slides

# puts slides.inspect
# puts v_photos.inspect