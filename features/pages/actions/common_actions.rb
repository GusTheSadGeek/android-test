module PageObjectModel
  module PageActions
    def expect_page(page)
      page.await
      expect(page).to be_displayed
    rescue => e
      raise RSpec::Expectations::ExpectationNotMetError, "Page verification failed\n   Expected page: '#{page.class.to_s.demodulize}' with trait \"#{page.trait}\"\n \nTimeout: #{e.message}"
    end

    def enter_app_as_anonymous_user
      welcome_page.try_it_out if welcome_page.displayed?
      my_library_page.await
    end

    def enter_app_as_existing_user
      return if my_library_page.displayed?

      if welcome_page.displayed?
        welcome_page.sign_up
      elsif my_library_page.displayed?
        my_library_page.open_menu_and_signin
      end
      sign_in_page.await
      username = test_data['users']['existing']['emailaddress']
      password = test_data['users']['existing']['password']
      sign_in_page.submit_sign_in_details(username, password)
      my_library_page.await
    end

    def expect_text_on_screen(page,message_text,timeout=5)
      expect_page(page)
      expect_text(message_text,timeout=timeout)
    end

    def expect_text(text,timeout=5)
      mark = escape_quotes(text)
      wait_for_text("#{mark}", :timeout => timeout)
    end
  end
end