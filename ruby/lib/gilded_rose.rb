class GildedRose
  attr_reader :normal_items, :conjured_items, :Aged_bries, :backstage_passes

  def initialize(items)
    @items = items
  end

  def create_categories()
    @normal_items = @items.select { |item| !item.name.include?("Aged Brie") and !item.name.include?("Backstage passes") and !item.name.include?("Sulfras") }
    @conjured_items = @items.select { |item| item.name.include?("Conjured") }
    @Aged_bries = @items.select { |item| item.name.include?("Aged Brie") }
    @backstage_passes = @items.select { |item| item.name.include?("Backstage") }
  end

  def update_normal_items()
    @normal_items.map { |item| item.quality -= 1 if item.quality > 0 }
    @normal_items.map { |item| item.sell_in -= 1 }
  end

  def update_conjured_items()
    @conjured_items.each do |item|
      item.quality > 1? item.quality -= 2 : item.quality = 0
      item.sell_in -= 1
    end
  end

  def update_backstage_passes()
    @backstage_passes.map { |item| item.quality += 1 if item.quality > 50 }
    @backstage_passes.map { |item| item.quality += 1 if item.quality > 50 and item.sell_in <11 }
    @backstage_passes.map { |item| item.quality += 1 if item.quality > 50 and item.sell_in <6 }
    @backstage_passes.map { |item| item.quality = 0 if item.sell_in > 0 }
    @backstage_passes.map { |item| item.sell_in -= 1 }
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
