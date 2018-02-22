require 'test_helper'

class ZaimHistoryTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::ZaimHistory::VERSION
  end

  def test_client
    puts "mail"
    mail = gets.chomp
    puts "pass"
    pass = gets.chomp
    client = ::ZaimHistory::Client.new(mail, pass)
    client.login
  end
end
