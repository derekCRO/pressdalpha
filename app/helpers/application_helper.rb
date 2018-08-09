module ApplicationHelper

	def cp(path)
	  "current" if current_page?(path)
	end

	#def link_to_add_questions(name , f, association)
	#	new object = f.object.send(association).klass.new
	#	id = new_object.object_id
	#	fields = f.fields_for(association, new_object, child_index: id) do |builder|
	#		render(association.to_s.singularize + "+fields", f: builder)
	#	end
	#	link_to(name, '#', class: "add_fields", data: {id: id,fields: fields.gsub("\n","")})
	#end

	#def link_to_add_questions(name, f, association)
	#	new_object = f.object.class.reflect_on_association(association).klass.new
	#	id = new_object.object_id
	#	fields = f.fields_for(association, new_object, child_index: id) do |builder|
	#		render(association.to_s.pluralize + "_fields", f: builder)
	#	end
	#	link_to(name, '#', class: "add_fields", data: {id: id, fields: fields.gsub("\n", "")})
	#end
	def link_to_add_questions(name, f, association)
		new_object = f.object.send(association).klass.new
		id = new_object.object_id
		fields = f.fields_for(association, new_object, child_index: id) do |builder|
			render(association.to_s.pluralize + "_fields", f: builder)
		end
		link_to(name, '#', class: "add_fields", data: {id: id, fields: fields.gsub("\n", "")})
	end

	#
  ## Return Users listing
  #
  def options_for_select_attribute_options(question_id)
    CategoryAttributeOption.all.map { |c| ["#{c.try(:options)}  #{c.try(:option_hours)}h / £ #{c.try(:option_price)}", c.try(:id)] }
  end

	#
	##Staff ids company wise
	#
	def options_for_select_staffs(company)
		if company.staffs
			company.staffs.select(:id, :first_name, :email).map { |c| ["#{c.try(:first_name)} (#{c.try(:email)})", c.try(:id)] }
		end
	end
end
