require './lib/prime'

RSpec.describe Prime, "#is_prime?" do
  context "for composite numbers" do
    it "returns false" do
      prime = Prime.new

      expect(prime.is_prime?(6)).to be false
      expect(prime.is_prime?(121)).to be false
      expect(prime.is_prime?(1234567890)).to be false
    end
  end

  context "for prime numbers" do
    it "returns true" do
      prime = Prime.new

      expect(prime.is_prime?(2)).to be true
      expect(prime.is_prime?(5)).to be true
      expect(prime.is_prime?(997)).to be true
      expect(prime.is_prime?(8675309)).to be true
      expect(prime.is_prime?(14860723123787)).to be true
    end
  end
end

RSpec.describe Prime, "#index" do
  it "returns the nth prime number" do
    prime = Prime.new

    expect(prime.index(1)).to eq 2
    expect(prime.index(11)).to eq 31
    expect(prime.index(101)).to eq 547
    expect(prime.index(10001)).to eq 104743
  end
end
