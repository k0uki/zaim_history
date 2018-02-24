require 'test_helper'

class ZaimRecordTest < Minitest::Test

  def test_record_initalize
    record = ZaimHistory::Record.new(dummy_record_hash)
    assert_equal('住まい', record.category1)
    assert_equal('2月24日', record.date)
  end

  private
  def dummy_record_hash
    r = {}
    r[:date] = "2月24日\n"
    r[:category1] = "住まい"
    r[:category2] = "家賃"
    r[:price] = "¥100,000,00"
    r[:from_account] = "銀行"
    r[:to_account] = nil
    r[:place] = nil
    r[:comment] = "今月分"
    r
  end
end
