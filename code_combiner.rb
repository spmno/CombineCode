require 'find'

class CodeCombiner

  def initialize
    @code_path = '/home/sunqp/zhuyn'
    @output_filename = 'code.txt'
    @output_file = File.new(@code_path+'/'+@output_filename, 'w')
  end

  def run
    Find.find(@code_path) do |path|
      if is_code(path)
        push_code_to_file(path)
      end
    end
  end

  def is_code(path)
    return (path.include?('.cpp') or path.include?('.java') or path.include?('.h'))
  end

  def push_code_to_file(path)
    puts path
    current_file = File.new(path, 'r')
    current_file.each_line do |line|
      unless (line.include?('//') or line.include?('*') or (line =~ /^\s*(?<=\n)/))
        @output_file.puts line
      end
    end
  end
end

code_combiner = CodeCombiner.new
code_combiner.run