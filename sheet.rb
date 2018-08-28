# Sheet version 1.0.0 (c) 2018
# 
# This class helps you manipulate CSV sheets in Ruby.
# Up-to-date version and documentation available at:
#
# https://github.com/felipedemacedo/ruby-sheet-manipulator
#
# This script is available under the following license :
# GNU GENERAL PUBLIC LICENSE.
#
# See full license and details at :
# https://github.com/felipedemacedo/ruby-sheet-manipulator/blob/master/LICENSE
#
# Version history:
#   * 1.0.0 : August 15 2018
#               First public revision - Felipe de Macêdo Rodrigues (felipedemacedo.cin@gmail.com)
#

class Sheet
	@@debug_mode_on = true

	attr_accessor :path, :file, :header, :data, :data_backup, :load_type

	def initialize(path, column_separator=";")
	  @column_separator = column_separator
	  @path = path
	  open_file()
	end

	def load(params=nil)
	  @data_backup = nil
      print "** LOADING " if @@debug_mode_on
      if !params.nil? && params[:as_array] == true
        puts "AS ARRAY" if @@debug_mode_on
        @load_type = Array
      elsif !params.nil? && params[:as_hash] == true
        puts "AS HASH" if @@debug_mode_on
        @load_type = Hash
      else
        puts "" if @@debug_mode_on
        @load_type = String
      end
      open_file()
      get_header(params)
      @data = Array.new
      while (line = @file.gets)
        if @load_type == Array
          @data << line.split("#{@column_separator}")
        elsif @load_type == Hash
          h = Hash.new
          @header.each do |header|
            h[header] = line.split("#{@column_separator}")[@header.find_index(header)]
          end
          @data << h
        else
          @data << line
        end
      end
      close_file()
	  print_debug()
      return @data
	end

	def load_as_array()
	  load({:as_array => true})
	  return @data
	end

	def load_as_hash()
	  load({:as_hash => true})
	  return @data
	end

	def remove_line_breaks()
	  @data.collect! do |line|
	    if line.instance_of? String
		  line = line.to_s.gsub("\n","")
		elsif line.instance_of? Array
		  line.collect!{|x| x.to_s.gsub("\n","")}
		elsif line.instance_of? Hash
		  line.each do |header, val|
		    line[header] = val.to_s.gsub("\n","")
		  end
		end
      end
	end

	def apply(method_given, columns_to_be_changed=nil)
		if !columns_to_be_changed.nil? && @@debug_mode_on
			puts "****************************SPECIFIC COLUMNS: [#{columns_to_be_changed.join(',')}]"
		end
		backup()
		@data.collect! do |lines|
			if lines.instance_of? String
				lines.split("#{@column_separator}").collect! do |column|
					if columns_to_be_changed.nil? || (!columns_to_be_changed.nil? && columns_to_be_changed.include?(lines.find_index(column)))
					  column = method_given.call(column)
					else
					  column
					end
				end
			elsif lines.instance_of? Array
				lines.collect! do |column|
					if columns_to_be_changed.nil? || (!columns_to_be_changed.nil? && columns_to_be_changed.include?(lines.find_index(column)))
					  column = method_given.call(column)
					  #puts "column: #{column}"
					else
					  column
					end
				end
			elsif lines.instance_of? Hash
				amount_of_columns = @header.size
				column_index = 0
		  		lines.each do |column_name, column_value|
		  			column_index%amount_of_columns != 0 ? column_index += 1 : column_index = 1
		    		if columns_to_be_changed.nil? || columns_to_be_changed.include?(column_index - 1)
		    			lines[column_name] = method_given.call(column_value)
		    		else
		    			lines[column_name] = column_value
		    		end
		  		end
			end
		end
		clean()
		puts "#{method_given.name.upcase} APPLIED !" if @@debug_mode_on
		print_debug()
	end

	def get_line_number(line)
	  return @data.find_index(line) unless line.nil?
	end

	def backup()
		@data_backup = @data.map(&:dup)
		puts "** BACKUP STORED !" if @@debug_mode_on
	end

	# Restores what is in @backup
	def rollback()
		temp = @data.map(&:dup)
		@data = @data_backup.map(&:dup)
		@data_backup = temp.map(&:dup)
		puts "** ROLLED BACK !" if @@debug_mode_on
	end

	def upcase(params=nil)
		apply(method(:apply_upcase), params)
	end

	def downcase(params=nil)
		apply(method(:apply_downcase), params)
	end

	def skip_line_breaks(params=nil)
		apply(method(:remove_line_breaks), params)
	end

	def skip_whitespaces(params=nil)
		apply(method(:remove_whitespaces), params)
	end

	def skip_numeric(params=nil)
		apply(method(:remove_numerics), params)
	end

	def skip_non_numeric(params=nil)
		apply(method(:remove_non_numerics), params)
	end

	def skip_blank_lines()
		apply(method(:remove_blank_lines))
	end

	def uniq()
		backup()
		@data = @data.uniq
		puts "UNIQ APPLIED !" if @@debug_mode_on
		clean()
		print_debug()
	end

	def sort()
		backup()
		@data = @data.sort
		puts "SORT APPLIED !" if @@debug_mode_on
		clean()
		print_debug()
	end

	# For debug purposes
	def print_debug(inspect_mode=false)
		return if !@@debug_mode_on
		puts "  DATA: " if @@debug_mode_on
		if inspect_mode
			puts @data.inspect
		else
			@data.each do |dado|
				puts dado.inspect
			end
		end
		puts "--" if @@debug_mode_on
	end

	def print_debug_backup(inspect_mode=false)
		puts "BACKUP: " if @@debug_mode_on
		if @data_backup.nil?
			puts "** EMPTY BACKUP" if @@debug_mode_on
			return
		end
		if inspect_mode
			puts @data_backup.inspect
		else
			@data_backup.each do |dado|
				puts dado
			end
		end
	end

	private

    def numeric?(value)
      return false if value.to_s.gsub(/\d/, '').length > 0 # remove all numeric characters and check if something remains
      return true if Float(value) rescue false
    end
	
	def apply_upcase(str)
		return str.to_s.upcase
	end

	def apply_downcase(str)
		return str.to_s.downcase
	end
	
	def remove_line_breaks(str)
		return str.to_s.gsub("\n","").gsub("\r\n","")
	end
	
	def remove_blank_lines(str)
		return str if !(str =~ /^ *( *; *)*$/)
	end

	def remove_whitespaces(str)
		return str.to_s.gsub(/^ */,"").gsub(/ *$/,"")
	end

	def remove_numerics(str)
		return numeric?(str) ? "" : str
	end

	def remove_non_numerics(str)
		return numeric?(str) ? str : ""
	end
	
	def get_header(params)
		if !params.nil? && (params[:as_array] == true || params[:as_hash] == true)
			@header = @file.gets.to_s.strip.split("#{@column_separator}")
		else
			@header = @file.gets.to_s.strip
		end
	end
	# Remove empty lines like [nil,nil,nil] or []
	def clean()
		if @load_type == Hash
			@data.delete_if{|x| x.values.uniq == [nil] || x.values.uniq == [] }
		else
			@data.delete_if{|x| x.uniq == [nil] || x.uniq == [] }
		end
	end

	def open_file()
		begin
			@file = File.new(@path)
		rescue Exception => e
			puts e.inspect
		end
		return @file
	end
	
	def close_file()
		begin
			@file.close()
		rescue Exception => e
			puts e.inspect
		end
		return @file
	end
end

# USAGE EXAMPLES:

sheet = Sheet.new("./example_sheets/skip_blank_lines/sheet.csv")
sheet.load_as_hash()
puts "Sheet Header: #{sheet.header.inspect}"

#sheet.skip_blank_lines()
#sheet.skip_whitespaces([0])
#sheet.skip_whitespaces()
#sheet.skip_line_breaks([2])
#sheet.skip_line_breaks()
#sheet.uniq()
#sheet.sort()
#sheet.upcase([0])
#sheet.upcase()
#sheet.downcase([1,2])
#sheet.downcase()
#sheet.skip_numeric([0])
#sheet.skip_numeric()
#sheet.rollback()
#sheet.skip_non_numeric([1])
#sheet.skip_non_numeric()