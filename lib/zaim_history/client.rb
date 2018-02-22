require "mechanize"
require 'logger'
require 'rack'

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

      home_page = agent.get(url)
    end

    private
    def agent
      @agent ||= Mechanize.new
      @agent.log = Logger.new $stderr
      @agent
    end
  end
end
