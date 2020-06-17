require "gilded_rose"

describe GildedRose do
  # describe "#update_quality" do
  #   it "A normal item changes quality by 1 after 1 day" do
  #     items = [Item.new("Vest", 10, 10)]
  #     GildedRose.new(items).update_quality()
  #     expect(items[0].quality).to eq 9
  #   end
  #
  #   it "A normal item changes sellIn by 1 after 1 day" do
  #     items = [Item.new("Vest", 10, 10)]
  #     GildedRose.new(items).update_quality()
  #     expect(items[0].sell_in).to eq 9
  #   end
  #
  #   it "A normal item changes quality and sellIn by 2 after 2 days" do
  #     items = [Item.new("Vest", 10, 10)]
  #     shop = GildedRose.new(items)
  #     shop.update_quality()
  #     shop.update_quality()
  #     expect(items[0].sell_in).to eq 8
  #     expect(items[0].quality).to eq 8
  #   end
  #
  #   it "the quality of a normal item does not go below zero" do
  #     items = [Item.new("Vest", 10, 1)]
  #     shop = GildedRose.new(items)
  #     shop.update_quality()
  #     shop.update_quality()
  #     expect(items[0].quality).to eq 0
  #   end
  #
  #   it "Aged brie increases in quality by 1 and decreases Sellin by 1 after 1 day" do
  #     items = [Item.new("Aged Brie", 10, 10)]
  #     shop = GildedRose.new(items)
  #     shop.update_quality()
  #     expect(items[0].quality).to eq 11
  #     expect(items[0].sell_in).to eq 9
  #   end
  #
  #   it "Aged brie increases in quality by 2 and decreases Sellin by 2 after 2 day" do
  #     items = [Item.new("Aged Brie", 10, 10)]
  #     shop = GildedRose.new(items)
  #     shop.update_quality()
  #     shop.update_quality()
  #     expect(items[0].quality).to eq 12
  #     expect(items[0].sell_in).to eq 8
  #   end
  #
  #   it "Aged brie quality cannot increase beyond 50" do
  #     items = [Item.new("Aged Brie", 10, 50)]
  #     shop = GildedRose.new(items)
  #     shop.update_quality()
  #     expect(items[0].quality).to eq 50
  #     expect(items[0].sell_in).to eq 9
  #   end
  #
  #   it 'A sulfras quality and sellin value does not change' do
  #     items = [Item.new("Sulfuras, Hand of Ragnaros", 10, 80)]
  #     shop = GildedRose.new(items)
  #     shop.update_quality()
  #     shop.update_quality()
  #     expect(items[0].quality).to eq 80
  #     expect(items[0].sell_in).to eq 10
  #   end
  #
  #   it "A backstage pass quality increases by 1 each day when the sellIn value is above 10" do
  #     items = [Item.new('Backstage passes to a TAFKAL80ETC concert', 11, 49)]
  #     shop = GildedRose.new(items)
  #     shop.update_quality()
  #     expect(items[0].quality).to eq 50
  #     expect(items[0].sell_in).to eq 10
  #   end
  #
  #   it "A backstage pass quality increases by 2 each day when the sellIn value is between 10 & 5" do
  #     items = [Item.new('Backstage passes to a TAFKAL80ETC concert', 9, 45)]
  #     shop = GildedRose.new(items)
  #     shop.update_quality()
  #     expect(items[0].quality).to eq 47
  #     expect(items[0].sell_in).to eq 8
  #   end
  #
  #   it "A backstage pass quality increases by 3 each day when the sellIn value is below 5" do
  #     items = [Item.new('Backstage passes to a TAFKAL80ETC concert', 5, 45)]
  #     shop = GildedRose.new(items)
  #     shop.update_quality()
  #     expect(items[0].quality).to eq 48
  #     expect(items[0].sell_in).to eq 4
  #   end
  #
  #   it "A backstage pass quality increases by 2 each day when the sellIn value is between 10 & 5" do
  #     items = [Item.new('Backstage passes to a TAFKAL80ETC concert', 9, 45)]
  #     shop = GildedRose.new(items)
  #     shop.update_quality()
  #     expect(items[0].quality).to eq 47
  #     expect(items[0].sell_in).to eq 8
  #   end
  #
  #   it "A backstage pass quality cannot increase past 50" do
  #     items = [Item.new('Backstage passes to a TAFKAL80ETC concert', 11, 50)]
  #     shop = GildedRose.new(items)
  #     shop.update_quality()
  #     expect(items[0].quality).to eq 50
  #     expect(items[0].sell_in).to eq 10
  #   end
  #
  #   it "A backstage pass quality goes to 0 after its sellIn value has past" do
  #     items = [Item.new('Backstage passes to a TAFKAL80ETC concert', 0, 49)]
  #     shop = GildedRose.new(items)
  #     shop.update_quality()
  #     expect(items[0].quality).to eq 0
  #     expect(items[0].sell_in).to eq -1
  #   end
  #
  #   it "A conjured item's value decreases by 2 after each day" do
  #     items = [Item.new('Conjured bread', 10, 40)]
  #     shop = GildedRose.new(items)
  #     shop.update_quality()
  #     expect(items[0].quality).to eq 38
  #     expect(items[0].sell_in).to eq 9
  #   end
  # end

  describe "#update_normal_items" do
    it "A normal item changes quality by 1 after 1 day" do
      items = [Item.new("Vest", 10, 10)]
      GildedRose.new(items).update_normal_items()
      expect(items[0].quality).to eq 9
      expect(items[0].sell_in).to eq 9
    end

    it "A normal item changes quality and sellIn by 2 after 2 days" do
      items = [Item.new("Vest", 10, 10)]
      shop = GildedRose.new(items)
      shop.update_normal_items()
      shop.update_normal_items()
      expect(items[0].sell_in).to eq 8
      expect(items[0].quality).to eq 8
    end

    it "the quality of a normal item does not go below zero" do
      items = [Item.new("Vest", 10, 1)]
      shop = GildedRose.new(items)
      shop.update_normal_items()
      shop.update_normal_items()
      expect(items[0].quality).to eq 0
    end
  end

  describe "#update_conjured_items" do
    it "A conjured item's value decreases by 2 after each day" do
      items = [Item.new('Conjured bread', 10, 40)]
      shop = GildedRose.new(items)
      shop.update_conjured_items()
      expect(items[0].quality).to eq 38
      expect(items[0].sell_in).to eq 9
    end
  end
end
