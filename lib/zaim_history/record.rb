module ZaimHistory
  class Record
    attr_accessor :date, :category1, :category2, :price, :from_account, :to_account, :place, :comment

    def initialize(data)
      data = chomp_data(data)
      self.date = data[:date]
      self.category1 = data[:category1]
      self.category2 = data[:category2]
      self.price = data[:price]
      self.from_account = data[:from_account]
      self.to_account = data[:to_account]
      self.place = data[:place]
      self.comment = data[:comment]
    end

    def format_to_terminal
      "#{date}|#{category1}|#{category2}|#{price}|#{from_account}|#{to_account}|#{place}|#{comment}"
    end

    private

    def chomp_data(data)
      data.map {|key,val| [key, val&.chomp]}.to_h
    end
  end
end
