require 'erb'

class GiftExchange
  attr_reader :players

  def initialize(filename)
    lines = get_players(filename)
    @players = parse_players(lines)
  end

  def get_players(filename)
    File.readlines(filename)
  end

  def parse_players(lines)
    players = lines.map do |line|
      player = line.chomp.split
      [player.first, player.last.to_i]
    end
    players.to_h
  end

  def assign
    from = players.keys
    to1 = players.keys.shuffle
    to2 = players.keys.shuffle
    from.zip(to1.zip(to2)).to_h
  end

  def valid?(assignments)
    assignments.all? do |from, to|
      valid = players[from] != players[to.first] &&
              players[from] != players[to.last]  &&
              to.first      != to.last
      puts "is invalid: #{from} => #{to}" if !valid && !ENV["test"]
      valid
    end
  end

  def self.run(filename)
    gift = GiftExchange.new(filename)
    valid = false
    until valid
      assignments = gift.assign
      sleep 0.1 unless ENV["test"]
      puts assignments unless ENV["test"]
      valid = gift.valid?(assignments)
    end
    puts "is valid. =)" unless ENV["test"]
    gift.compose_emails(assignments)
    assignments
  end

  def invert(assignments)
    assignments.keys.reduce(Hash.new) do |inverse, to|
      inverse[to] = assignments.select do |key, value|
        value.include?(to)
      end.keys
      inverse
    end
  end

  def compose_emails(assignments)
    Dir.mkdir("output") unless Dir.exist?("output")
    erb_template = ERB.new(File.read("email_template.erb"))
    inverse = invert(assignments)
    assignments.each do |from, to|
      counterpart = [inverse[to.first].find { |person| person != from },
                     inverse[to.last].find { |person| person != from }]
      email = erb_template.result(binding)
      output_filename = "output/#{from}.txt"
      File.open(output_filename, 'w') do |file|
        file.puts email
      end
    end
  end
end

unless ENV["test"]
  filename = ARGV[0] || "participants_input.txt"
  GiftExchange.run(filename)
end
