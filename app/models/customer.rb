class Customer
  attr_accessor :id
  attr_reader :name, :address

  def initialize(attributes = {})
    @id = attributes[:id].to_i
    @name = attributes[:name]
    @address = attributes[:address]
  end

  def self.headers
    %w[id name address]
  end

  def to_a
    [id, name, address]
  end
end
