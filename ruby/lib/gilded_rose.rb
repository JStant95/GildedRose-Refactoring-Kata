class GildedRose

  def initialize(items)
    @items = items
  end

  def update_normal_item(item)
    item.quality -= 1 if item.quality > 0
  end

  def update_conjured_item(item)
    item.quality -= 1 if item.quality > 0
  end

  def update_backstage_passes(item)
    if item.sell_in < 11
      if item.quality < 50
        item.quality = item.quality + 1
      end
    end
    if item.sell_in < 6
      if item.quality < 50
        item.quality = item.quality + 1
      end
    end
  end

  def update_quality()
    @items.each do |item|
      if !item.name.include?("Aged Brie") and !item.name.include?("Backstage passes")
          if !item.name.include?("Sulfuras")
            update_normal_item(item)
          end
          if item.name.include?("Conjured")
            update_conjured_item(item)
          end
      else
        if item.quality < 50
          item.quality = item.quality + 1
          if item.name.include?("Backstage passes")
            update_backstage_passes(item)
          end
        end
      end
      if item.name != "Sulfuras, Hand of Ragnaros"
        item.sell_in = item.sell_in - 1
      end
      if item.sell_in < 0
        if item.name != "Aged Brie"
          if item.name != "Backstage passes to a TAFKAL80ETC concert"
            if item.quality > 0
              if item.name != "Sulfuras, Hand of Ragnaros"
                item.quality = item.quality - 1
              end
            end
          else
            item.quality = item.quality - item.quality
          end
        else
          if item.quality < 50
            item.quality = item.quality + 1
          end
        end
      end
    end
  end
end

class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s()
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end
