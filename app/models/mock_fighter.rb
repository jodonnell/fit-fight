class MockFighter
  attr_accessor :hp
  attr_accessor :wins

  def initialize hp
    self.hp = hp
    self.wins = 0
  end

  def save
  end
end
