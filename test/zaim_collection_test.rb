require 'test_helper'

class ZaimCollectionTest < Minitest::Test

  def test_collection_print
    $stdout = StringIO.new
    c = ZaimHistory::Collection.new(create_records)
    c.print_to_terminal
    expected = <<EOS
日付|カテゴリ1|カテゴリ2|金額|出金|入金|お店|メモ
--------------------------------------------------
2月17日（土）|住まい|家賃|¥100,000,00|銀行|||今月分
--------------------------------------------------
2月17日（土）|住まい|家賃|¥100,000,00|銀行|||今月分
--------------------------------------------------
2月17日（土）|住まい|家賃|¥100,000,00|銀行|||今月分
--------------------------------------------------
EOS

    assert_equal(expected, $stdout.string)
    $stdout = STDOUT
  end

  def test_csv_print
    $stdout = StringIO.new
    c = ZaimHistory::Collection.new(create_records)
    c.print_csv
    expected = <<EOS
日付,カテゴリ1,カテゴリ2,金額,出金,入金,お店,メモ
2月17日（土）,住まい,家賃,\"¥100,000,00\",銀行,,,今月分
2月17日（土）,住まい,家賃,\"¥100,000,00\",銀行,,,今月分
2月17日（土）,住まい,家賃,\"¥100,000,00\",銀行,,,今月分
EOS

    assert_equal(expected, $stdout.string)
    $stdout = STDOUT
  end

  private
  def create_records
    records = []
    3.times do
      records << ZaimHistory::Record.new(dummy_record_hash)
    end
    records
  end

  def dummy_record_hash
    r = {}
    r[:date] = "2月17日（土）\n"
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
