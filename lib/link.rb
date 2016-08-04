class LinkItem
  include Listable
  attr_reader :description, :site_name

  def initialize(url, options={})
    @description = url
    @site_name = options[:site_name]
  end
  
  def details
    [format_description(@description), format_name(@site_name)]
  end
end
