require 'thor'

module ZaimHistory
  class Cli < Thor
    class_option :mail, type: :string, aliases: :m
    class_option :password, type: :string, aliases: :p
    class_option :debug, type: :boolean, aliases: :d

    desc "fetch", "fetch history from zaim"
    option :month, desc: "fetch month", type: :numeric, default: ""
    option :format, desc: "result format", type: :string, enum:['terminal', 'csv'],  default: 'terminal'
    def fetch
      unless mail = options[:mail]
        puts "mail:"
        mail = $stdin.gets.chomp
      end
      unless password = options[:password]
        puts "pass:"
        password = $stdin.gets.chomp
      end

      client = Client.new(mail, password, options[:debug])
      client.login

      if result = client.fetch_history(options[:month])
        result.print_with_format(options[:format])
      else
        warn(client.error)
      end
    rescue LoggedInFailed
      warn('zaimへのログインに失敗しました。メールアドレスかパスワードが間違っています')
    end
  end
end
