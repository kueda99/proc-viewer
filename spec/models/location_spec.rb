# -*- coding: utf-8 -*-
require 'spec_helper'

describe Location do

  describe "妥当性確認" do
    describe "x" do
      it "数字は妥当" do
        location = Location.new(x: 1)
        location.valid?
        expect(location).to have_no_error_on(:x)
      end

      it "nil は不当" do
        location = Location.new
        location.valid?
        expect(location).to have_any_error_on(:x)
      end

      it "同じ panel_id, x, y の Location オブジェクトの存在は不当" do
        panel = Panel.create!(number: "foo")
        ann   = Ann.create!(name: "foo")
        other = Location.create!(panel: panel, x: 1, y: 1, item: ann)
        loc   = Location.new(panel: panel, x: 1, y: 1, item: ann)
        loc.valid?
        expect(loc).to have_any_error_on(:x)
      end
    end

    describe "y" do
      it "数字は妥当" do
        location = Location.new(y: 1)
        location.valid?
        expect(location).to have_no_error_on(:y)
      end

      it "nil は不当" do
        location = Location.new
        location.valid?
        expect(location).to have_any_error_on(:y)
      end

      it "同じ panel_id, x, y の Location オブジェクトの存在は不当" do
        panel = Panel.create!(number: "foo")
        ann   = Ann.create!(name: "foo")
        other = Location.create!(panel: panel, x: 1, y: 1, item: ann)
        loc   = Location.new(panel: panel, x: 1, y: 1, item: ann)
        loc.valid?
        expect(loc).to have_any_error_on(:y)
      end
    end
  end

  describe "#to_s" do
    it "設定された場所 (location) を返す" do
      loc = Location.new(location: "a1")
      expect(loc.to_s).to eq("a1")
    end
  end

  describe "#location=" do
    describe "b3 を設定した場合" do
      it "#location は b3 を返す" do
        location = Location.new(location: "b3")
        expect(location.location).to eq("b3")
      end
      it "#x は 3 を返す" do
        location = Location.new(location: "b3")
        expect(location.x).to eq(3)
      end
      it "#y は 2 を返す" do
        location = Location.new(location: "b3")
        expect(location.y).to eq(2)
      end
    end
    describe "3b を設定した場合" do
      it "#location は b3 を返す" do
        location = Location.new(location: "3b")
        expect(location.location).to eq("b3")
      end
      it "#x は 3 を返す" do
        location = Location.new(location: "3b")
        expect(location.x).to eq(3)
      end
      it "#y は 2 を返す" do
        location = Location.new(location: "3b")
        expect(location.y).to eq(2)
      end
    end
  end

  describe "#location" do
    describe "x に 3, y に 2 が設定されている" do
      it "\"b3\" を返す" do
        location = Location.new(x: 3, y: 2)
        expect(location.location).to eq("b3")
      end
    end
    describe "x に nil, y に 3 が設定されている" do
      it "nil を返す" do
        location = Location.new(x: nil,  y: 3)
        expect(location.location).to be_nil
      end
    end
    describe "x に 2, y に nil が設定されている" do
      it "nil を返す" do
        location = Location.new(x: 2,  y: nil)
        expect(location.location).to be_nil
      end
    end
    describe "x に nil, y に nil が設定されている" do
      it "nil を返す" do
        location = Location.new(x: nil,  y: nil)
        expect(location.location).to be_nil
      end
    end
  end

  describe "#item=" do
    before(:each) do
      @location = Location.new
      @ann = Ann.create!(name: "foo")
      @subpanel = Panel.create!(number: "bar")
    end

    describe "警報オブジェクトを代入" do
      it "エラーが発生しない" do
        expect { @location.item = @ann }.not_to raise_error
      end
    end

    describe "警報パネルオブジェクトを代入" do
    end
  end

  describe "#==" do
    before(:each) do
      @panel = Panel.create!(number: "foo")
      @item  = Ann.create!(name: "bar")
      @loc_one = Location.new(panel: @panel, item: @item, location: "a1")
      @loc_two = Location.new(panel: @panel, item: @item, location: "a1")
      expect(@loc_one.id).not_to eq(@loc_two.id)
    end

    context "両者のパラメータが同じ" do
      it "true を返す" do
        expect(@loc_one).to eq(@loc_two)
      end
    end

    context "両者のパラメータが一箇所でも違っている" do
      it "true を返す" do
        @loc_two.location = "foo"
        expect(@loc_one).not_to eq(@loc_two)
      end
    end
  end
end
