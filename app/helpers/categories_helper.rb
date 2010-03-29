module CategoriesHelper

  # Returns an <optgroup> containing just root elements
  # - option_groups_from_collection_for_select ignores roots, this is a workaround
  # 'category' will be excluded from list
  # - on updating a category it cannot become it's own parent'
  def option_group_for_roots(roots, category)
    ret = '<optgroup label="' + t('activerecord.operations.category.roots') + '">'
    roots.each do |c|
      (c == category) ? ret += '' : ret += '<option value="' + c.id.to_s + '">' + c.name + '</option>'
    end
    ret += '</optgroup>'
  end 
end
