require "mechanize"
require 'logger'
require 'rack'
require 'json'

module ZaimHistory
  class Client
    def initialize(mail, password)
      @mail = mail
      @password = password
    end

    def login
      auth_page = agent.get("https://auth.zaim.net/")
      login_form = auth_page.form_with(id: 'UserLoginForm')
      login_form['data[User][email]'] = @mail
      login_form['data[User][password]'] = @password
      page2 = login_form.click_button
      oauth_token = Rack::Utils.parse_nested_query(page2.uri.query)['oauth_token']
      oauth_verifier = page2.search('code')[0].content
      url = "https://zaim.net/user_session/callback?oauth_token=#{oauth_token}&oauth_verifier=#{oauth_verifier}"

      @home_page = agent.get(url)
    end

    def history
      money_page = @home_page.link_with(href: "/money").click
      result = []
      money_page.search('table.list tr').each do |tr|
        if date = tr.children.at('.date .edit-money')
          r = {}
          r[:date] = date.content
          r[:category1] = tr.children.at('.category span').attribute('alt').value
          r[:category2] = tr.children.at('.category .edit-money').content
          r[:price] = tr.children.at('.price .edit-money').content
          r[:from_acount] = tr.children.at('.from_account .account-sm')&.attribute('alt')&.value
          r[:to_account] = tr.children.at('.to_account .account-sm')&.attribute('alt')&.value
          r[:place] = tr.children.at('.place .edit-money span')&.attribute('title')&.value
          r[:comment] = tr.children.at('div.comment .edit-money span')&.attribute('title')&.value
          result << chomp_result(r)
        end
      end
      result.to_json
    end

    private
    def agent
      @agent ||= Mechanize.new
      @agent.log = Logger.new $stderr
      @agent
    end

    def chomp_result(result)
      result.map {|key,val| [key, val&.chomp]}.to_h
    end
  end
end