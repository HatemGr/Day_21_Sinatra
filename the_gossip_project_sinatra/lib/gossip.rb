require 'pry'
require 'csv'


class Gossip
  attr_accessor :author, :content, :comments
  def initialize(author,content,comments)
    @author = author
    @content = content
    @comments = comments
  end

  def save
    CSV.open("db/gossip.csv","a") do |csv|
      csv << [@author,@content,@comments]
    end
  end

  def self.find(gossip_id)
    gossips = CSV.read("db/gossip.csv")
    gossip_id =~ /[a-zA-Z]/ ? (return Gossip.new(nil,nil,nil)) : (gossip_id = gossip_id.to_i - 1)
    if gossip_id < 0 || gossip_id > (gossips.size - 1)
      target_gossip = Gossip.new(nil,nil,nil)
    else
      target_gossip = Gossip.new(gossips[gossip_id][0],gossips[gossip_id][1],gossips[gossip_id][2]) # A automatiser
    end
    return target_gossip
  end

  def self.all
    file = CSV.read("db/gossip.csv")
    gossip_array = []
    file.each {|gossip| gossip_array << Gossip.new(gossip[0],gossip[1],gossip[2])}
    return gossip_array
  end

  def self.update(id,new_author,new_content)    
    puts id
    id = id.to_i
    file = CSV.read("db/gossip.csv")
    file[id-1][0] = new_author
    file[id-1][1] = new_content
    
    CSV.open("db/gossip.csv","w") do |csv|
      file.each{|row| csv << row}
    end
  end

  def self.add_comment(id,comment)
    id = id.to_i
    file = CSV.read("db/gossip.csv")
    puts file[id-1][2].class
    file[id-1][2] << "///" + comment
    #puts file[id-1][2] 

    CSV.open("db/gossip.csv","w") do |csv|
      file.each{|row| csv << row}
    end
  end

  # def delete_gossip
  #   file = CSV.read("db/gossip.csv")
  #   file.delete([@author,@content])
  #   
  # end

end


#binding.pry