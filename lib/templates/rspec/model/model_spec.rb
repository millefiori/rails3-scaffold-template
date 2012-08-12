# -*- coding: utf-8 -*-
require 'spec_helper'

describe <%= class_name %> do

	# <%= class_name %>::PUBLISHED = 1

	unless defined?(<%= class_name %>::PUBLISHED)
		<%= class_name %>.blueprint do
<% for attribute in attributes -%>
			<%= attribute.name %> {}
<% end -%>
		end
	end

	describe ".create" do
		subject { <%= class_name %>.make }
		it { should be_valid }

<% for attribute in attributes -%>
		context "<%= attribute.name %> is nil" do
			subject { <%= class_name %>.make(<%= attribute.name %>: nil) }
			it { should be_valid }
		end
<% end -%>
	end

	describe ".destroy" do
		subject { <%= class_name %>.make!.destroy }
		it { should be_destroyed }

		describe ".find_by_id", "after destroy" do
			let(:id) { <%= class_name %>.make!.id }
			before { <%= class_name %>.destroy id }
			subject { <%= class_name %>.find_by_id id }
			it { should be_blank }
		end
	end
end
