module ZaimHistory
  class Collection
    attr_accessor :records

    def initialize(records=[])
      self.records = records
    end

    def print_to_terminal
      puts "日付|カテゴリ1|カテゴリ2|金額|出金|入金|お店|メモ"
        puts '--------------------------------------------------'
      records.each do |r|
        puts r.format_to_terminal
        puts '--------------------------------------------------'
      end
    end

    def add(record)
      self.records << record
    end
  end
end