module WatirRobot
  
  #
  # Functionality at the browser level, including browser history and cookie handling
  # 
  module Browser
  
    ### Actions ###
    
    #
    # Start browser
    #
    # @param [String] browser the name of the browser to use, must match a name recognized by WebDriver
    # @return [Object] the browser object with which to drive the browser
    #
    def open_browser(browser = 'firefox')
      @browser = Watir::Browser.new browser.to_sym
      @driver = @browser.driver
      @window_id = 0
      return @browser
    end
    
    #
    # Open browser and go to specific URL
    #
    # @param [String] url the URL to navigate to
    # @param [String] browser the name of the browser to use, must match a name recognized by WebDriver
    # @return [Object] the browser object with which to drive the browser
    #
    def start_browser(url, browser = 'firefox')
      self.open_browser browser
      @browser.goto url
      return @browser
    end
  
    #
    # Get current URL
    #
    # @return [String] URL of the current page
    #
    def get_url
      @browser.url
    end
    
    #
    # Go to specific URL in already-opened browser
    #
    # @param [String] url the URL to navigate to
    #
    def go_to(url)
      @browser.goto(url)
    end
  
    #
    # Go back in browsing history
    #
    def go_back
      @browser.back
    end
  
    #
    # Go forward in browsing history
    #
    def go_forward
      @browser.forward
    end
  
    #
    # Refresh the current page
    #
    def refresh
      @browser.refresh
    end
  
    #
    # Get all cookies defined in the current session
    #
    # @return [Array<Hash>] list of cookies
    #
    def get_all_cookies
      @driver.manage.all_cookies
    end
  
    #
    # Get a cookie by name
    #
    # @param [String] name name of the cookie
    # @return [Hash, nil] the cookie or nil, if it doesn't exist
    #
    def get_cookie(name)
      @driver.manage.cookie_named(name)
    end
  
    #
    # Delete all browser cookies
    #
    def delete_all_cookies
      @browser.clear_cookies
    end
  
    #
    # Delete individual cookie, identified by name
    #
    # @param [String] name name of the cookie
    #
    def delete_cookie(name)
      @driver.manage.delete_cookie(name)
    end
  
    #
    # Close current browser
    #
    def close_browser
      @browser.close
    end
  
    #
    # Maximize browser window (uses JavaScript)
    #
    def maximize_browser_window
      @browser.execute_script(
        "if (window.screen) {
           window.moveTo(0, 0);
           window.resizeTo(window.screen.availWidth, window.screen.availHeight);
         };")
    end

    #
    # Switch to "other" window; assumes there are only 2 open
    #
    def switch_to_other_window
      @window_id = (@window_id - 1).abs
      if @window_id != 0 and @window_id !=1
        puts @window_id
        raise(Exception::WindowMatchError, "You cannot use this keyword when more than 2 windows are open; you must use 'Switch To Window', 'Switch to Next Window', or 'Switch to Previous Window'")
      end

      @browser.windows[@window_id].use
    end

    #
    # Switch to a specified opened window
    #
    # @param [String] loc attribute/value pairs that match an HTML element
    #
    def switch_to_window(loc)
      if loc[0..3] == 'url=' or loc[0..5] == 'title='
        @browser.window(parse_location(loc)).use
      else
        # assume loc is an integer
        # since Robot Framework sends all args as text, the above check for
        # "url=" and "title=" is the best we can do to ensure argument correctness
        loc = loc.to_i
        # the number of the window
        # user-facing numbers are 1-based, internal we use 0-based because @browser.windows
        # is a Ruby array, so minus 1
        @window_id = loc - 1
        if @window_id == -1
          # either the user has been too smart for his/her own good and thinks the windows are 0-based,
          # or they've entered text that doesn't match 'url=' or 'title=', in which case
          # the above loc.to_i will make loc equal 0
          raise(ArgumentError, "You must provide the url or title of the window in the format 'url=' or 'title=', or you must provide the number of the window, starting with 1 for the first window opened.")
        end
        # this will throw its own error if the index is out of range
        @browser.windows[loc].use
      end
    end

    #
    # Switch to "next" window, the order depending on order of original opening.
    #
    # If the "last" window is active and you ask for the next, you will be taken
    # back to the first window (i.e. it wraps around)
    #
    def switch_to_next_window
      @window_id += 1
      if @window_id >= @browser.windows.count
        # wrap back to the first
        @window_id = 0
      end

      @browser.windows[@window_id].use
    end

    #
    # Switch to "previous" window, the order depending on order of original opening.
    #
    # If the "first" window is active and you ask for the previous, you will be taken
    # around to the last window (i.e. it wraps around)
    #
    def switch_to_previous_window
      @window_id -= 1
      if @window_id < 0
        # wrap back to the last
        @window_id = @browser.windows.count - 1
      end

      @browser.windows[@window_id].use
    end

    #
    # Close "other" window; assumes there are only 2 open
    #
    def close_other_window
      @window_id = (@window_id - 1).abs
      if @window_id != 0 and @window_id !=1
        raise(Exception::WindowMatchError, "You cannot use this keyword when more than 2 windows are open; you must use 'Switch To Window', 'Switch to Next Window', or 'Switch to Previous Window'")
      end

      @browser.windows[@window_id].close
    end

    #
    # Close a single browser window
    #
    # If you have multiple windows open and you close a non-active window, the window is simply closed.
    # If you have multiple windows open and you close the active window, by default,
    # the "previous" window will become the active one before closing the specified window
    # (to avoid browser crashes). You can optionally specify which window should be used
    # upon closing the active one.
    # If you have only one window open and you issue this command, it is the same as calling
    # "Close Browser", and the entire browser instance will be closed.
    #
    # @param [String] close_loc the identifier for the window you wish to close, either title, url, or integer
    #
    def close_window(close_loc = :current, active_loc = nil)
      if @browser.windows.count == 1
        # doesn't matter what they enter, bc closing the only window of a browser
        # instance causes the browser to crash
        @browser.close
      end


      if close_loc == :current
        # if the current window is being closed, we have to move to another before closing it
        if active_loc.nil?
          # if new active window is unspecified, make the previous window the new active one
          self.switch_to_previous_window
        else
          self.switch_to_window(active_loc)
        end
      else
        # a specific window to be closed has been specified (though it may still be the active one)
        if close_loc[0..3] == 'url=' or close_loc[0..5] == 'title='
          if @browser.window(parse_location(close_loc)).current?
            # if the current window is being closed, we have to move to another before closing it
            if active_loc.nil?
              # if new active window is unspecified, make the previous window the new active one
              self.switch_to_previous_window
            else
              self.switch_to_window(active_loc)
            end
          end
          @browser.window(parse_location(close_loc)).close
        else
          # assume close_loc is an integer
          # since Robot Framework sends all args as text, the above check for
          # "url=" and "title=" is the best we can do to ensure argument correctness
          close_loc = close_loc.to_i
          # the number of the window
          # user-facing numbers are 1-based, internal we use 0-based because @browser.windows
          # is a Ruby array, so minus 1
          window_id = close_loc - 1
          if window_id == -1
            # either the user has been too smart for his/her own good and thinks the windows are 0-based,
            # or they've entered text that doesn't match 'url=' or 'title=', in which case
            # the above loc.to_i will make loc equal 0
            raise(ArgumentError, "You must provide the url or title of the window in the format 'url=' or 'title=', or you must provide the number of the window, starting with 1 for the first window opened.")
          end
          
          if @browser.windows[window_id].current?
            # if the current window is being closed, we have to move to another before closing it
            if active_loc.nil?
              # if new active window is unspecified, make the previous window the new active one
              self.switch_to_previous_window
            else
              self.switch_to_window(active_loc)
            end
          end
          # this will throw its own error if the index is out of range
          @browser.windows[window_id].close
        end
      end
    end

    #
    # Return the number of open windows
    #
    def get_window_count
      return @browser.windows.count
    end
  
    ### Conditions ###
    
    #
    # Verify that the current URL matches a given string
    #
    # @param [String] url the URL to match against
    #
    def url_should_be(url)
      raise(Exception::UrlMatchError, "The URL #{@browser.url} is not correct; it should be #{url}") unless
        @browser.url == url
    end
  
    #
    # Verify that URL contains certain text
    #
    # @param [String] text the text which should appear in the URL
    # 
    def url_should_contain(text)
      raise(Exception::UrlMatchError, "The URL #{@browser.url} is not correct; it should contain #{text}") unless
        @browser.url.include?(text)
    end
    
  end  
  
end