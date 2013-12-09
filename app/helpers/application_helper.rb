module ApplicationHelper

  def markdown(text)
    options = [:hard_wrap, :filter_html, :autolink, :no_intraemphasis, :fenced_code, :gh_blockcode]
    Redcarpet.new(text, *options).to_html.html_safe
  end
  
  def link_to_add_fields(name, f, association)
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.fields_for(association, new_object, child_index: id) do |builder|
      render(association.to_s.singularize + "_fields", f: builder)
    end
    link_to(name, '#', class: "add_fields", data: {id: id, fields: fields.gsub("\n", "")})
  end
  
  def error_messages_for(*objects)
    options = objects.extract_options!
    messages = objects.compact.map { |o| o.errors.full_messages }.flatten
    unless messages.empty?
      content_tag :div, class: "alert alert-error" do
        list_items = messages.map { |msg| msg }.to_sentence
      end
    end
  end
  
  def short_date(date)
    date.strftime("%b %e, %Y")
  end

  def long_date(date)
    date.strftime('%b %e, %Y at %l:%M %p')
  end
    
end
