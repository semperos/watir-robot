# Copyright 2008-2009 Nokia Siemens Networks Oyj
# 
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#     http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.


require 'xmlrpc/server'
require 'xmlrpc/utils'
require 'stringio'

# Necessary to parse out documentation and args
require 'yard'


class RobotRemoteServer < XMLRPC::Server
  #
  # Constructor for RobotRemoteServer
  #
  # @param [Object] library instance of a class in which are defined keywords
  # @param [String] host the name or location from which this server will serve content
  # @param [Integer] port the port at which this server will serve content
  # @param [String] yardoc_file the file which YARD expects when loading its Registry
  # @param [Hash] yardoc_options a hash of YARD::CodeObject::Base.method => human-readable label for docs
  def initialize(library, host='localhost', port=8270, yardoc_file = '.yardoc', yardoc_options = [[:docstring, '']])
    @library = library
    # Get YARD registry loaded into memory
    @reg = YARD::Registry
    @reg.load(yardoc_file)
    @reg.load_all
    @reg_options = yardoc_options
    # End yard setup
    super(port, host)  # TODO: Disable logging to stdout
    add_handler('get_keyword_names') { get_keyword_names }
    add_handler('run_keyword') { |name,args| run_keyword(name, args) }
    add_handler('get_keyword_arguments') { |name| get_keyword_arguments(name) }
    add_handler('get_keyword_documentation') { |name| get_keyword_documentation(name) }
    add_handler('stop_remote_server') { shutdown }
    puts "Robot Framework remote library started at #{host}:#{port}"
    serve
  end

  def get_keyword_names
    # Implicit methods can't be used as keywords
    @library.methods - Object.new.methods
  end

  def run_keyword(name, args)
    intercept_stdout()
    result = {:status=>'PASS', :return=>'', :output=>'',
              :error=>'', :traceback=>''}
    begin
      return_value = @library.send(name, *args)
      result[:return] = handle_return_value(return_value)
    rescue Exception => exception
      result[:status] = 'FAIL'
      result[:error] = exception.message
      result[:traceback] = "Traceback:\n" + exception.backtrace.join("\n")
    end
    result[:output] = restore_stdout
    return result
  end

  def get_keyword_arguments(name)
    parent_class = @library.method(name).owner.to_s
    codeobj = @reg.resolve(P(parent_class), "#" + name)
    params = codeobj.parameters
    params_docs = []
    params.each do |param|
      if param[1].nil? # YARD sets the keyword arg to nil if absent
        params_docs << param[0]
      else
        params_docs << param[0] + "=" + param[1]
      end
    end
    return params_docs
  end

  def get_keyword_documentation(name)  
    parent_class = @library.method(name).owner.to_s
    # Allow custom inclusion/exclusion of parts of the documentation
    # The first element is the method, the second is the human-readable label
    doc = ''
    @reg_options.each do |opt|
      doc << opt[1] + ":\n" if opt[1] != ''
      doc << @reg.resolve(P(parent_class), "#" + name).send(opt[0])
      doc << "\n\n"
    end
    
    return doc
  end

  private

  def handle_return_value(ret)
    if [String, Integer, Fixnum, Float, TrueClass, FalseClass].include?(ret.class)
      return ret
    elsif ret.class == Array
      return ret.collect { |item| handle_return_value(item) }
    elsif ret.class == Hash
      new_ret = {}
      ret.each_pair { |key,value|
        new_ret[key.to_s] = handle_return_value(value)
      }
      return new_ret
    else
      return ret.to_s
    end
  end

  def intercept_stdout
    $original_stdout = $stdout.dup
    @output = ''
    $stdout = StringIO.new(@output)
  end
  
  def restore_stdout
    $save_for_close = $stdout
    $stdout = $original_stdout
    $save_for_close.close
    return @output
  end
    
end
