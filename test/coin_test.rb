require 'test/unit'
require_relative '../lib/game/coin.rb'

# Unit tests for coin.rb
class CoinTest < Test::Unit::TestCase
  def test_pluralize
    single = Coin.new(1)
    none = Coin.new(0)
    plural = Coin.new(2)
    assert_equal('chocolate coin', single.name)
    assert_equal('chocolate coins', none.name)
    assert_equal('chocolate coins', plural.name)
  end

  def test_save_data
    control = Coin.new(42)
    data = control.save_data

    assert_equal(control.class.to_s, data[:item_class])
    assert_equal('Coin', data[:item_class])
    assert_equal(control.quantity, data[:item_quantity])
    assert_equal(42, data[:item_quantity])
  end

  def test_symbol
    assert_equal('*', Coin.new.symbol)
  end
end
