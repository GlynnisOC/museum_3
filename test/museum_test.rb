require 'minitest/autorun'
require 'minitest/pride'
require './lib/patron'
require './lib/exhibit'
require './lib/museum'

class MuseumTest < Minitest::Test

  def setup
    @gems_and_minerals = Exhibit.new("Gems and Minerals", 0)
    @dead_sea_scrolls = Exhibit.new("Dead Sea Scrolls", 10)
    @imax = Exhibit.new("IMAX", 15)
    @bob = Patron.new("Bob", 20)
    @sally = Patron.new("Sally", 20)
    @dmns = Museum.new("Denver Museum of Nature and Science")
  end

  def test_it_exists
    assert_instance_of Museum, @dmns
  end

  def test_it_has_attributes
    assert_equal "Denver Museum of Nature and Science", @dmns.name
    assert_equal [], @dmns.exhibits
  end

  def test_it_shows_exhibits_have_been_added_to_museum
    @dmns.add_exhibit(@gems_and_minerals)
    @dmns.add_exhibit(@dead_sea_scrolls)
    @dmns.add_exhibit(@imax)
    assert_equal [@gems_and_minerals, @dead_sea_scrolls, @imax], @dmns.exhibits
  end

  # def test_it_returns_exhibit_recommendations_based_on_interests
  #   @bob.add_interest(@dead_sea_scrolls)
  #   @bob.add_interest(@gems_and_minerals)
  #   @sally.add_interest(@imax)
  #   @dmns.add_exhibit(@gems_and_minerals)
  #   @dmns.add_exhibit(@dead_sea_scrolls)
  #   @dmns.add_exhibit(@imax)
  #   assert_equal [@dead_sea_scrolls, @gems_and_minerals], @dmns.recommend_exhibits(@bob)
  #   assert_equal [@imax], @dmns.recommend_exhibits(@sally)
  # end

  def test_it_begins_without_patrons
    assert_equal [], @dmns.patrons
  end

  def test_after_patrons_admitted_they_are_returned
    @dmns.admit(@bob)
    @dmns.admit(@sally)
    assert_equal [@bob, @sally], @dmns.patrons
  end

  def test_it_returns_patrons_by_exhibit_interest
    @dmns.add_exhibit(@gems_and_minerals)
    @dmns.add_exhibit(@dead_sea_scrolls)
    @dmns.add_exhibit(@imax)
    @bob.add_interest(@dead_sea_scrolls)
    @bob.add_interest(@gems_and_minerals)
    @sally.add_interest(@dead_sea_scrolls)
    @dmns.admit(@bob)
    @dmns.admit(@sally)
    expected = {
      @gems_and_minerals => [@bob],
      @dead_sea_scrolls => [@bob, @sally],
      @imax => []
    }
    assert_equal expected, @dmns.patrons_by_exhibit_interest
  end
end
