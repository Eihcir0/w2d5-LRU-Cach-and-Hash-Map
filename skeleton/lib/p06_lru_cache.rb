require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

class LRUCache
  attr_reader :count
  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    if @map.include?(key)
      update_link!(@map.get(key))
      @map[key].val
    else
      calc!(key)

    end
  end

  def to_s
    "Map: " + @map.to_s + "\n" + "Store: " + @store.to_s
  end

  private

  def calc!(key)
    # suggested helper method; insert an (un-cached) key
    val = @prc.call(key)
    eject! if count == @max
    link = @store.insert(key, val)
    @map.set(key, link)
    val
  end

  def update_link!(link)
    # suggested helper method; move a link to the end of the list
    @store.move_link_to_tail(link)
  end

  def eject!
    key = @store.first.key
    @store.remove(key)
    @map.delete(key)

  end

end#class
