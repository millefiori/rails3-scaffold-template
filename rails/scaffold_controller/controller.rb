# -*- coding: utf-8 -*-
<% if namespaced? -%>
require_dependency "<%= namespaced_file_path %>/application_controller"

<% end -%>
<% module_namespacing do -%>
class <%= controller_class_name %>Controller < BaseController
	before_filter :load_object, :only=>[ :show, :edit, :update, :destroy ]
	before_filter :setup_object, :only=>[ :new, :create ]

	private
	def load_object
		@<%= singular_table_name %> = <%= orm_class.find(class_name, "params[:id]") %>
	end

	def setup_object
		@<%= singular_table_name %> = <%= orm_class.build(class_name, "params[:#{singular_table_name}]") %>
	end

	public
	# GET <%= route_url %>
	# GET <%= route_url %>.json
	def index
		@list = <%= class_name %>.scoped
	end

	# GET <%= route_url %>/1
	# GET <%= route_url %>/1.json
	def show
	end

	# GET <%= route_url %>/new
	# GET <%= route_url %>/new.json
	def new
	end

	# GET <%= route_url %>/1/edit
	def edit
	end

	# POST <%= route_url %>
	# POST <%= route_url %>.json
	def create
		if @<%= orm_instance.save %>
			redirect_to @<%= singular_table_name %>
		else
			render <%= key_value :action, '"new"' %>
		end
	end

	# PUT <%= route_url %>/1
	# PUT <%= route_url %>/1.json
	def update
		if @<%= orm_instance.update_attributes("params[:#{singular_table_name}]") %>
			redirect_to @<%= singular_table_name %>
		else
			render <%= key_value :action, '"edit"' %>
		end
	end

	# DELETE <%= route_url %>/1
	# DELETE <%= route_url %>/1.json
	def destroy
		@<%= orm_instance.destroy %>

		redirect_to <%= index_helper %>_url
	end
end
<% end -%>
