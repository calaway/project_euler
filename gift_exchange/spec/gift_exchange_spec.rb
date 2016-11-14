require './gift_exchange'

RSpec.describe GiftExchange do
  describe "#get_players" do
    it "reads in the file" do
      filename = "names.txt"
      gift = GiftExchange.new(filename)

      all_lines = gift.get_players(filename)

      expect(all_lines.first).to eq("Dad         1\n")
      expect(all_lines.last).to eq("Geoff       5\n")
    end
  end

  describe "#parse_players" do
    it "turns the lines into a hash" do
      filename = "names.txt"
      gift = GiftExchange.new(filename)

      lines = gift.get_players(filename)
      players = gift.parse_players(lines)

      expect(players.count).to eq(8)
      expect(players["Ryanne"]).to eq(3)
      expect(players["Geoff"]).to eq(5)
    end
  end

  describe "#assign" do
    it "returns a from/to assignment hash" do
      filename = "names.txt"
      gift = GiftExchange.new(filename)

      assignment = gift.assign

      expect(assignment.class).to eq(Hash)
      expect(assignment.count).to eq(8)
      expect(assignment.keys.sort).to eq(gift.players.keys.sort)
      expect(assignment.values.sort).to eq(gift.players.keys.sort)
    end
  end

  describe "#valid?" do
    it "(in)validates assignment" do
      filename = "names.txt"
      gift = GiftExchange.new(filename)

      assignment1 = {"Dad"=>"Ryanne",
                     "Mom"=>"Ryan",
                     "Jenn"=>"Stephanie",
                     "Christopher"=>"Jenn",
                     "Ryanne"=>"Geoff",
                     "Stephanie"=>"Christopher",
                     "Ryan"=>"Mom",
                     "Geoff"=>"Dad"}
      assignment2 = {"Dad"=>"Dad",
                     "Mom"=>"Jenn",
                     "Jenn"=>"Ryan",
                     "Christopher"=>"Ryanne",
                     "Ryanne"=>"Mom",
                     "Stephanie"=>"Christopher",
                     "Ryan"=>"Stephanie",
                     "Geoff"=>"Geoff"}
      assignment3 = {"Dad"=>"Stephanie",
                     "Mom"=>"Geoff",
                     "Jenn"=>"Dad",
                     "Christopher"=>"Ryanne",
                     "Ryanne"=>"Jenn",
                     "Stephanie"=>"Christopher",
                     "Ryan"=>"Ryan",
                     "Geoff"=>"Mom"}

      expect(gift.valid?(assignment1)).to be(true)
      expect(gift.valid?(assignment2)).to be(false)
      expect(gift.valid?(assignment3)).to be(false)
    end
  end

  describe "#run" do
    it "generates random assignements until one is valid" do
      filename = "names.txt"
      gift = GiftExchange.new(filename)

      matchies = GiftExchange.run(filename)

      expect(matchies.count).to eq(8)
      expect(gift.valid?(matchies)).to eq(true)
    end
  end
end
