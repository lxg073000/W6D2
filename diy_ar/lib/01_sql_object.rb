require_relative 'db_connection'
require 'active_support/inflector'
# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.

class SQLObject
  puts self
  def self.columns
    if @cols == nil
     cols= DBConnection.execute2(<<-SQL) 
     SELECT * 
     FROM #{self.table_name} LIMIT 0
     SQL
     @cols = cols.first.map! {|ele| ele.to_sym }
    else
      @cols
    end
  end

  def self.finalize!
    @cols = self.columns
    @cols.each do |col|
       define_method(col) {self.attributes[col]}
       define_method("#{col}=") {|val = nil| self.attributes[col] = val}
      end
  end

  def self.table_name=(table_name)
    @table_name = table_name
    
  end

  def self.table_name
    @table_name ||= "#{self}".tableize
  end

  def self.all
    @cols = self.columns
    results = DBConnection.execute(<<-SQL)
    SELECT * FROM #{table_name}SQL


  end

  def self.parse_all(results)
    DBConnection.execute(<<-SQL)

    SQL
  end

  def self.find(id)
    # ...
  end

  def initialize(params = {})
  @cols = self.class.columns
    params.each do |attr_name, value|
      attr_sym = attr_name.to_sym
        raise "unknown attribute '#{attr_sym}'" if !@cols.include?(attr_sym)
        self.send("#{attr_sym}=", value)
    end
  end

  def attributes
    @attributes ||= {}

  end

  def attribute_values
    # ...
  end

  def insert
    # ...
  end

  def update
    # ...
  end

  def save
    # ...
  end
end
