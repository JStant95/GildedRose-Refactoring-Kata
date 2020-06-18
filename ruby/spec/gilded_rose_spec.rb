require "gilded_rose"

describe GildedRose do
  describe "#create_categories" do
    it "Splits items into their appropiate category" do
      items = [Item.new("Vest", 10, 10), Item.new('Conjured bread', 10, 40), Item.new('Backstage passes to a TAFKAL80ETC concert', 0, 49), Item.new("Aged Brie", 10, 50)]
      shop = GildedRose.new(items)
      shop.create_categories()
      expect(shop.normal_items[0].name).to eq("Vest")
      expect(shop.conjured_items[0].name).to eq("Conjured bread")
      expect(shop.backstage_passes[0].name).to eq("Backstage passes to a TAFKAL80ETC concert")
      expect(shop.aged_bries[0].name).to eq("Aged Brie")
    end

    it "Can deal with multiple items of the same category" do
      items = [Item.new("Vest", 10, 10), Item.new('Shirt', 10, 40)]
      shop = GildedRose.new(items)
      shop.create_categories()
      expect(shop.normal_items.length).to eq(2)
    end
  end

  describe "#update_normal_items" do
    it "A normal item changes quality by 1 after 1 day" do
      items = [Item.new("Vest", 10, 10)]
      shop = GildedRose.new(items)
      shop.create_categories()
      shop.update_normal_items()
      expect(items[0].quality).to eq 9
      expect(items[0].sell_in).to eq 9
    end

    it "A normal item changes quality and sellIn by 2 after 2 days" do
      items = [Item.new("Vest", 10, 10)]
      shop = GildedRose.new(items)
      shop.create_categories()
      shop.update_normal_items()
      shop.update_normal_items()
      expect(items[0].sell_in).to eq 8
      expect(items[0].quality).to eq 8
    end

    it "the quality of a normal item does not go below zero" do
      items = [Item.new("Vest", 10, 1)]
      shop = GildedRose.new(items)
      shop.create_categories()
      shop.update_normal_items()
      shop.update_normal_items()
      expect(items[0].quality).to eq 0
    end
  end

  describe "#update_conjured_items" do
    it "A conjured item's value decreases by 2 after each day" do
      items = [Item.new('Conjured bread', 10, 40)]
      shop = GildedRose.new(items)
      shop.create_categories()
      shop.update_conjured_items()
      expect(items[0].quality).to eq 38
      expect(items[0].sell_in).to eq 9
    end

    it "the quality of a normal item does not go below zero" do
      items = [Item.new('Conjured bread', 10, 1)]
      shop = GildedRose.new(items)
      shop.create_categories()
      shop.update_conjured_items()
      expect(items[0].quality).to eq 0
      expect(items[0].sell_in).to eq 9
    end
  end

  describe "#update_backstage_passes" do
    it "A backstage pass quality increases by 1 each day when the sellIn value is above 10" do
        items = [Item.new('Backstage passes to a TAFKAL80ETC concert', 11, 49)]
        shop = GildedRose.new(items)
        shop.create_categories()
        shop.update_backstage_passes()
        expect(items[0].quality).to eq 50
        expect(items[0].sell_in).to eq 10
      end

      it "A backstage pass quality increases by 2 each day when the sellIn value is between 10 & 5" do
        items = [Item.new('Backstage passes to a TAFKAL80ETC concert', 9, 45)]
        shop = GildedRose.new(items)
        shop.create_categories()
        shop.update_backstage_passes()
        expect(items[0].quality).to eq 47
        expect(items[0].sell_in).to eq 8
      end

      it "A backstage pass quality increases by 3 each day when the sellIn value is below 5" do
        items = [Item.new('Backstage passes to a TAFKAL80ETC concert', 5, 45)]
        shop = GildedRose.new(items)
        shop.create_categories()
        shop.update_backstage_passes()
        expect(items[0].quality).to eq 48
        expect(items[0].sell_in).to eq 4
      end

      it "A backstage pass quality increases by 2 each day when the sellIn value is between 10 & 5" do
        items = [Item.new('Backstage passes to a TAFKAL80ETC concert', 9, 45)]
        shop = GildedRose.new(items)
        shop.create_categories()
        shop.update_backstage_passes()
        expect(items[0].quality).to eq 47
        expect(items[0].sell_in).to eq 8
      end

      it "A backstage pass quality cannot increase past 50" do
        items = [Item.new('Backstage passes to a TAFKAL80ETC concert', 11, 50)]
        shop = GildedRose.new(items)
        shop.create_categories()
        shop.update_backstage_passes()
        expect(items[0].quality).to eq 50
        expect(items[0].sell_in).to eq 10
      end

      it "A backstage pass quality goes to 0 after its sellIn value has past zero" do
        items = [Item.new('Backstage passes to a TAFKAL80ETC concert', 0, 49)]
        shop = GildedRose.new(items)
        shop.create_categories()
        shop.update_backstage_passes()
        expect(items[0].quality).to eq 0
        expect(items[0].sell_in).to eq -1
      end
    end

    describe "#update_aged_bries" do
      it "Aged brie increases in quality by 1 and decreases Sellin by 1 after 1 day" do
        items = [Item.new("Aged Brie", 10, 10)]
        shop = GildedRose.new(items)
        shop.create_categories()
        shop.update_aged_bries()
        expect(items[0].quality).to eq 11
        expect(items[0].sell_in).to eq 9
      end

      it "Aged brie increases in quality by 2 and decreases Sellin by 2 after 2 day" do
        items = [Item.new("Aged Brie", 10, 10)]
        shop = GildedRose.new(items)
        shop.create_categories()
        shop.update_aged_bries()
        shop.update_aged_bries()
        expect(items[0].quality).to eq 12
        expect(items[0].sell_in).to eq 8
      end

      it "Aged brie quality cannot increase beyond 50" do
        items = [Item.new("Aged Brie", 10, 50)]
        shop = GildedRose.new(items)
        shop.create_categories()
        shop.update_aged_bries()
        expect(items[0].quality).to eq 50
        expect(items[0].sell_in).to eq 9
      end
    end
  end
