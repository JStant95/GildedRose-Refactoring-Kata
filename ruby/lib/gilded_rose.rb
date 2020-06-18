class GildedRose
  attr_reader :normal_items, :conjured_items, :aged_bries, :backstage_passes

  def initialize(items)
    @items = items
  end


  def create_categories()
    @normal_items = @items.select { |item| !item.name.include?("Aged Brie") and !item.name.include?("Backstage passes") and !item.name.include?("Sulfuras") }
    @conjured_items = @items.select { |item| item.name.include?("Conjured") }
    @aged_bries = @items.select { |item| item.name.include?("Aged Brie") }
    @backstage_passes = @items.select { |item| item.name.include?("Backstage") }
  end

  def update_normal_items()
    update_sell_in(@normal_items)
    @normal_items.map { |item| item.quality -= 1 if item.quality > 0 }
  end

  def update_conjured_items()
    @conjured_items.each do |item|
      item.quality > 1? item.quality -= 2 : item.quality = 0
      item.sell_in -= 1
    end
  end

  def update_backstage_passes()
    update_sell_in(@backstage_passes)
    @backstage_passes.map { |item| item.quality += 1 if item.quality < 50 }
    @backstage_passes.map { |item| item.quality += 1 if item.quality < 50 and item.sell_in < 11 }
    @backstage_passes.map { |item| item.quality += 1 if item.quality < 50 and item.sell_in <6 }
    @backstage_passes.map { |item| item.quality = 0 if item.sell_in < 0 }
  end

  def update_aged_bries()
    update_sell_in(@aged_bries)
    @aged_bries.map { |item| item.quality += 1 if item.quality < 50 }
  end

  def update_sell_in(category)
    category.map { |item| item.sell_in -= 1 }
  end

  def update_quality()
    create_categories()
    update_normal_items()
    update_conjured_items()
    update_backstage_passes()
    update_aged_bries()
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
