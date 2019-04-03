class Museum
  attr_reader :name, :exhibits, :patrons

  def initialize(name)
    @name = name
    @exhibits = []
    @patrons = []
  end

  def add_exhibit(exhibit)
    @exhibits.push(exhibit)
  end

  def recommend_exhibits(patron)
    @exhibits.find_all do |exhibit|
      exhibit.name.include?(patron.interests.join(', '))
    end
  end

  def admit(patron)
    @patrons.push(patron)
  end

  def patrons_by_exhibit_interest
    exhibits = @exhibits.flat_map do |exhibit|
      exhibit
    end
    patrons = @patrons.flat_map do |patron|
      patron
    end
    exhibits.zip(patrons).to_h
  end
end
