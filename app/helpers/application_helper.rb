module ApplicationHelper

	def full_title(page_title='')
		base_title = "Static Page"
		if page_title.nil? || page_title.empty?
			base_title
		else
			page_title + ' | ' + base_title
		end
	end
end
