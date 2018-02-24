require 'thor'

module ZaimHistory
  class Cli < Thor
    class_option :mail, type: :string, alias: :m
    class_option :password, type: :string, alias: :p

    desc "fetch", "fetch history from zaim"
    option :month, desc: "fetch month", type: :numeric, default: ""
    option :format, desc: "result format", type: :string, default: "terminal"
    def fetch
      unless mail = options[:mail]
        puts "mail:"
        mail = $stdin.gets.chomp
      end
      unless password = options[:password]
        puts "pass:"
        password = $stdin.gets.chomp
      end
      client = Client.new(mail, password)
      client.login

      if result = client.fetch_history(options[:month])
        result.print_with_format(options[:format])
      else
        warn(client.error)
      end
    rescue InvalidFormatError => ex
      warn("指定できないフォーマットです")
    end
  end
end
