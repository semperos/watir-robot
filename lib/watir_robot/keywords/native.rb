module WatirRobot
  
  #
  # Native functionality for manipulating the mouse and keyboard via Java's java.awt.Robot class
  # 
  module Native
    require 'java'
    java_import 'java.awt.Robot'
    java_import 'java.awt.event.InputEvent'
    java_import 'java.awt.event.KeyEvent'
    java_import 'java.awt.Toolkit'
    java_import 'java.awt.Dimension'
    java_import 'java.awt.Rectangle'
    java_import 'java.awt.image.BufferedImage'
    java_import 'javax.imageio.ImageIO'
  
    #
    # Move mouse to specific coordinates
    #
    # @param [String] x x-axis coordinate (as string because arg comes from Robot Framework)
    # @param [String] y y-axis coordinate (as string because arg comes from Robot Framework)
    # 
    def move_mouse_to_position(x, y)
      @robot ||= Robot.new
      @robot.mouseMove(x.to_i, y.to_i)
    end
  
    #
    # Left mouse press
    # 
    def press_left_mouse_button
      @robot ||= Robot.new
      @robot.mousePress(InputEvent::BUTTON1_MASK)
    end
  
    #
    # Right mouse press
    # 
    def press_right_mouse_button
      @robot ||= Robot.new
      @robot.mousePress(InputEvent::BUTTON2_MASK)
    end
  
    #
    # Left mouse release
    # 
    def release_left_mouse_button
      @robot ||= Robot.new
      @robot.mouseRelease(InputEvent::BUTTON1_MASK)
    end
  
    #
    # Right mouse release
    # 
    def release_right_mouse_button
      @robot ||= Robot.new
      @robot.mouseRelease(InputEvent::BUTTON2_MASK)
    end
  
    #
    # Left mouse click
    # 
    def click_left_mouse_button
      @robot ||= Robot.new
      press_left_mouse_button
      release_left_mouse_button
    end
  
    #
    # Right mouse click
    # 
    def click_right_mouse_button
      @robot ||= Robot.new
      press_right_mouse_button
      release_right_mouse_button
    end
    
    #
    # Press a key on a given HTML element
    #
    # @param [String] loc id, css or xpath query to identify an HTML element
    # @param [String] the letter to be pressed, or an ASCII code in the format "ascii=65" (the letter 'a')
    #
    #def press_keys_at_location(loc, keys)
    #  @browser.element(parse_location(loc)).focus
    #  
    #  @robot ||= Robot.new
    #  key_codes = parse_key_code(key)
    #  @robot.keyPress(key_code)
    #  @robot.keyRelease(key_code)
    #end
    
    #
    # Press a key (literally press and release).
    #
    # If you want to press a key on a given HTML element, you should use the
    # Press Key keyword, or use the Focus keyword before Press Key Native.
    #
    # @param [String] the letter to be pressed, or an ASCII code in the format "ascii=65" (the letter 'a')
    #
    #def press_keys(keys)
    #  @robot ||= Robot.new
    #  key_code = parse_key_code(key)
    #  @robot.keyPress(key_code)
    #  @robot.keyRelease(key_code)
    #end
  
    #
    # Drag and drop with the mouse
    # 
    # This is at the operating system level. Consider using WebDriver's
    # facilities for drag and drop if you need drag-and-drop within a web page.
    #
    # @param [String] start_x x-axis coordinate of initial mouse press (as string because arg comes from Robot Framework)
    # @param [String] start_y y-axis coordinate of iniital mouse press (as string because arg comes from Robot Framework)
    # @param [String] finish_x x-axis coordinate of final mouse release (as string because arg comes from Robot Framework)
    # @param [String] finish_y y-axis coordinate of final mouse release (as string because arg comes from Robot Framework)
    # 
    def drag_and_drop(start_x, start_y, finish_x, finish_y)
      @robot ||= Robot.new
      move_mouse_to_position(start_x.to_i, start_y.to_i)
      press_left_mouse_button
      move_mouse_to_position(finish_x.to_i, finish_y.to_i)
      release_left_mouse_button
    end
    
    #
    # Take a screenshot of the entire screen
    #
    # @param [String] path the path (including file name) to which to save the screenshot image
    #
    def capture_screenshot(path = nil)
      t = Toolkit.getDefaultToolkit
      s = t.getScreenSize
      rect = Rectangle.new(0, 0, s.width, s.height);
      
      @robot ||= Robot.new
      image = @robot.createScreenCapture(rect)
      if path.nil?
        path = Time.now.to_i.to_s + '_screenshot.png'
      end
      file = java.io.File.new(path)
      ImageIO.write(image, 'png', file)
    end
    
  end
  
end
