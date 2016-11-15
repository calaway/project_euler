ENV["test"] = "true"

require './lib/gift_exchange'

RSpec.describe GiftExchange do
  describe "#get_players" do
    it "reads in the file" do
      filename = "participants_input.txt"
      gift = GiftExchange.new(filename)

      all_lines = gift.get_players(filename)

      expect(all_lines.first).to eq("Dad         1\n")
      expect(all_lines.last).to eq("Geoff       5\n")
    end
  end

  describe "#parse_players" do
    it "turns the lines into a hash" do
      filename = "participants_input.txt"
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
      filename = "participants_input.txt"
      gift = GiftExchange.new(filename)

      assignment = gift.assign

      expect(assignment.class).to eq(Hash)
      expect(assignment.count).to eq(8)
      expect(assignment.keys.sort).to eq(gift.players.keys.sort)
      expect(assignment.values.map { |pair| pair.first }.sort).to eq(gift.players.keys.sort)
      expect(assignment.values.map { |pair| pair.last }.sort).to eq(gift.players.keys.sort)
    end
  end

  describe "#valid?" do
    it "(in)validates assignment" do
      filename = "participants_input.txt"
      gift = GiftExchange.new(filename)

      assignment1 = {"Dad"        =>["Ryanne",      "Ryan"],
                     "Mom"        =>["Jenn",        "Christopher"],
                     "Jenn"       =>["Christopher", "Ryanne"],
                     "Christopher"=>["Mom",         "Mom"],
                     "Ryanne"     =>["Ryan",        "Jenn"],
                     "Stephanie"  =>["Dad",         "Geoff"],
                     "Ryan"       =>["Geoff",       "Dad"],
                     "Geoff"      =>["Stephanie",   "Stephanie"]}
      assignment2 = {"Dad"        =>["Stephanie",   "Ryan"],
                     "Mom"        =>["Mom",         "Christopher"],
                     "Jenn"       =>["Jenn",        "Geoff"],
                     "Christopher"=>["Ryan",        "Jenn"],
                     "Ryanne"     =>["Ryanne",      "Ryanne"],
                     "Stephanie"  =>["Geoff",       "Stephanie"],
                     "Ryan"       =>["Dad",         "Mom"],
                     "Geoff"      =>["Christopher", "Dad"]}
      assignment3 = {"Dad"        =>["Christopher", "Jenn"],
                     "Mom"        =>["Geoff",       "Christopher"],
                     "Jenn"       =>["Ryan",        "Dad"],
                     "Christopher"=>["Stephanie",   "Ryan"],
                     "Ryanne"     =>["Dad",         "Mom"],
                     "Stephanie"  =>["Jenn",        "Ryanne"],
                     "Ryan"       =>["Mom",         "Geoff"],
                     "Geoff"      =>["Ryanne",      "Stephanie"]}

      expect(gift.valid?(assignment1)).to be(false)
      expect(gift.valid?(assignment2)).to be(false)
      expect(gift.valid?(assignment3)).to be(true)
    end
  end

  describe "#run" do
    it "generates random assignements until one is valid" do
      filename = "participants_input.txt"
      gift = GiftExchange.new(filename)

      matchies = GiftExchange.run(filename)

      expect(matchies.count).to eq(8)
      expect(gift.valid?(matchies)).to eq(true)
    end
  end

  describe "#compose_email" do
    xit "composes an email for each participant" do
      filename = "participants_input.txt"
      gift = GiftExchange.new(filename)
      assignment = {"Dad"        =>["Christopher", "Jenn"],
                    "Mom"        =>["Geoff",       "Christopher"],
                    "Jenn"       =>["Ryan",        "Dad"],
                    "Christopher"=>["Stephanie",   "Ryan"],
                    "Ryanne"     =>["Dad",         "Mom"],
                    "Stephanie"  =>["Jenn",        "Ryanne"],
                    "Ryan"       =>["Mom",         "Geoff"],
                    "Geoff"      =>["Ryanne",      "Stephanie"]}

      gift.compose_emails
    end

    describe "#invert" do
      it "inverts assignments hash by finding who has drawn each person" do
        filename = "participants_input.txt"
        gift = GiftExchange.new(filename)
        assignment = {"Dad"        =>["Christopher", "Jenn"],
                      "Mom"        =>["Geoff",       "Christopher"],
                      "Jenn"       =>["Ryan",        "Dad"],
                      "Christopher"=>["Stephanie",   "Ryan"],
                      "Ryanne"     =>["Dad",         "Mom"],
                      "Stephanie"  =>["Jenn",        "Ryanne"],
                      "Ryan"       =>["Mom",         "Geoff"],
                      "Geoff"      =>["Ryanne",      "Stephanie"]}
        inverse    = {"Dad"        =>["Jenn",        "Ryanne"],
                      "Mom"        =>["Ryanne",      "Ryan"],
                      "Jenn"       =>["Dad",         "Stephanie"],
                      "Christopher"=>["Dad",         "Mom"],
                      "Ryanne"     =>["Stephanie",   "Geoff"],
                      "Stephanie"  =>["Christopher", "Geoff"],
                      "Ryan"       =>["Jenn",        "Christopher"],
                      "Geoff"      =>["Mom",         "Ryan"]}

        result = gift.invert(assignment)

        expect(result).to eq(inverse)
      end
    end
  end
end
