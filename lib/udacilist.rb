class UdaciList
  attr_reader :title, :items
  @@lists = []
  def initialize(options={})
    if options[:title] then
      @title = options[:title]
    else
      @title = "Untitled List"
    end
    @items = []
    @@lists << self
  end
  def add(type, description, options={})
    type = type.downcase
    case type
    when "todo"
      @items.push TodoItem.new(description, options)
    when "event"
      @items.push EventItem.new(description, options)
    when "link"
      @items.push LinkItem.new(description, options)
    else
      # This is where the error handler will go
      raise UdaciListErrors::InvalidItemType, "#{type} is not a valid item type"
    end
  end
  def delete(index)
    maxValidIndex = @items.length
    if index > maxValidIndex then
      raise UdaciListErrors::IndexExceedsListSize,
        "#{index} is not a valid index, must be #{maxValidIndex} or lower"
    else
      @items.delete_at(index - 1)
    end

  end
  def all
    rows = []
    @items.each_with_index do |item, position|
      rows << [position + 1, item.class.name[0..-5]] + item.details
    end
    table = Terminal::Table.new :title => @title,
      :headings => ['#', 'Type', 'Name', 'Details'],
      :rows => rows
    puts table
  end
  def filter(item_type)
    rows = []
    filteredItems = @items.find_all do |item|
      item.class.name[0..-5].downcase == item_type
    end
    filteredItems.each_with_index do |item, position|
      rows << [position + 1, item.class.name[0..-5]] + item.details
    end
    table = Terminal::Table.new :title => @title,
      :headings => ['#', 'Type', 'Name', 'Details'],
      :rows => rows
    puts table
  end
  def self.all_lists
    @@lists
  end

  def print_lists()
  	puts "Here are your lists"
  	UdaciList.all_lists.each {|list| puts list.title}
  	puts "\n"
  end

  def menu()
     cli = HighLine.new
     cli.choose do |menu|
     	menu.prompt = "Please choose an option:"
     	menu.choice(:"Visualize Lists") { print_lists }
     	menu.choice(:"New List") { title = cli.ask("Title???:"); UdaciList.new(title: title); print_lists }
     	menu.choice(:Goodbye) { cli.say("See you soon!") }
     	menu.default = :Goodbye
     end
  end

end
