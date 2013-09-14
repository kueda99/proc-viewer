# -*- coding: utf-8 -*-
require 'spec_helper'

describe Ann do
  describe 'initialize' do
    context 'name: のみが指定されたとき' do
      before(:each) do
        @ann = Ann.new(name:"HPCS 電気故障")
      end

      it "名称を返す" do
        expect(@ann.name).to eq("HPCS 電気故障")
      end
    end

    context "panel: と location: が文字列で指定されたとき" do
      before(:each) do
        @ann = Ann.new(panel: "n1", location: "a1")
      end

      it "Location オブジェクトと関連付ける" do
        expect(@ann.location).not_to be_nil
        expect(@ann.location).to be_a_kind_of(Location)
      end

      it "Location オブジェクトは保存しない" do
        expect(@ann.location).to be_new_record
      end

      it "関連する Location オブジェクトの「場所」を正しく設定する" do
        expect(@ann.location.location).to eq("a1")
      end

      it "Panel オブジェクトと関連付ける" do
        expect(@ann.panel).not_to be_nil
        expect(@ann.panel).to be_a_kind_of(Panel)
      end

      it "Panel オブジェクトは保存しない" do
        expect(@ann.panel).to be_new_record
      end

      it "関連する Panel オブジェクトの番号を正しく設定する" do
        expect(@ann.panel.number).to eq("n1")
      end
    end
  end

  #   describe 'ann.proc_path' do
  #     context 'panel と window が設定されている' do
  #       it "pdf ファイルへのリンクが返される" do
  #         ann = Ann.create!({:panel => "n1", :window => "c6"})
  #         expect(ann.proc_path).to eq("/assets/procs/ann-n1-c6.pdf")
  #       end
  #     end

  #     context 'window が設定されていない' do
  #       it "nil が返される" do
  #         ann = Ann.create!({:panel => "n1"})
  #         expect(ann.proc_path).to be_nil
  #       end
  #     end

  #     context 'panel が設定されていない' do
  #       it "nil が返される" do
  #         ann = Ann.create!({:window => "c6"})
  #         expect(ann.proc_path).to be_nil
  #       end
  #     end
  #   end

  #   context '設定した窓のところにすでに他の警報が割り当てられている' do
  #     before(:each) do
  #       @ann   = Ann.create!(:panel => "n1")
  #       @other = Ann.create!(:panel => "n1", :window => "a1")

  #       @ann.window = "a1"
  #     end

  #     describe '#valid?' do
  #       it 'エラーを発生させる' do
  #         @ann.valid?
  #         @ann.should have(1).error_on(:window)
  #       end

  #       it 'メッセージを設定する' do
  #         @ann.valid?
  #         expect(@ann.errors[:window]).to eq([I18n.t(:ann_already_assigned_to_other_ann)])
  #       end
  #     end
  #   end

  
  #   context '警報にパネル番号が設定されているが、窓番号は設定されていない' do
  #     before(:each) do
  #       @ann = Ann.create(panel: "n1")
  #     end

  #     context '手順書が割り当てられていない' do
  #       before(:each) do
  #         expect(@ann.procedures).to be_empty
  #       end

  #       describe '窓番号を設定して保存する' do
  #         before(:each) do
  #           @ann.window = "a1"
  #           @ann.save
  #         end

  #         it "その警報用に手順書オブジェクトは生成される" do
  #           expect(@ann.procedures).not_to be_empty
  #         end

  #         it "手順書のパスはパネル番号と窓番号から自動的に設定される" do
  #           expect(@ann.proc_path).to eq("/assets/procs/ann-n1-a1.pdf")
  #         end
  #       end
  #     end

  #     context '手順書が割り当てられている' do
  #       before(:each) do
  #         @proc = Procedure.create(ann: @ann, path: "/assets/procs/foo-bar.pdf")
  #         expect(@ann.procedures.size).to eq(1)
  #       end

  #       describe '窓番号を設定して保存する' do
  #         before(:each) do
  #           @ann.window = "a1"
  #           @ann.save
  #         end

  #         it "手順書オブジェクトが生成されることはない" do
  #           expect(@ann.procedures).to eq([@proc])
  #         end

  #         it "手順書のパスは変わらない" do
  #           expect(@ann.proc_path).to eq("/assets/procs/foo-bar.pdf")
  #         end
  #       end
  #     end
  #   end


  #   describe "#panel=" do
  #     context "警報と関連付けられたロケーションが存在しないとき" do
  #       it "Panel オブジェクトと関連付けられたロケーションオブジェクトを生成する" do
  #         ann = Ann.create!
  #         panel = Panel.create!
  #         ann.panel = panel

  #         expect(panel.location).not_to be_nil
  #       end

  #       it "警報と関連付けられたロケーションオブジェクトが生成される"
  #     end

  #     context "警報と関連付けられたロケーションが存在するとき" do
  #     end

  #     context "すでに他のパネルに割り当てられているとき" do
  #     end
  #   end

  describe '#panel_number' do
    context "警報がパネルに割り当てられているとき" do
      it "割り当てらえている警報パネルの番号を返す" do
        panel = Panel.create!(number: "n1")

        # ann = Ann.create!(panel: panel, location: "a1")
        ann = Ann.create!
        ann.panel = panel
        ann.location = "a1"

        expect(ann.panel_number).to eq("n1")
      end
    end

    context "警報がパネルに割り当てられていないとき" do
      it "nil を返す" do
        ann = Ann.create!
        expect(ann.panel_number).to be_nil
      end
    end
  end


  describe "#location=" do
    context "引数が文字列のとき" do
      it "Location の location 属性が引数の文字列に値が設定される" do
        ann = Ann.create
        ann.location = "a1"
        expect(ann.location.location).to eq("a1")
      end
    end
  end

  describe "#panel_location" do
    context "Location の関連がされているとき" do
      it "Location の location 属性が返される" do
        ann = Ann.create
        ann.location = Location.new(location: "a1")

        expect(ann.panel_location).to eq("a1")
      end
    end

    context "Location の関連がされていないとき" do
      it "nil が返される" do
        ann = Ann.create
        expect(ann.panel_location).to be_nil
      end
    end
  end

end
