# Configures your navigation
SimpleNavigation::Configuration.run do |navigation|  
  # Specify a custom renderer if needed. 
  # The default renderer is SimpleNavigation::Renderer::List which renders HTML lists.
  # navigation.renderer = Your::Custom::Renderer
  
  # Specify the class that will be applied to active navigation items. Defaults to 'selected'
  # navigation.selected_class = 'your_selected_class'
    
  # Item keys are normally added to list items as id.
  # This setting turns that off
  # navigation.autogenerate_item_ids = false
  
  # You can override the default logic that is used to autogenerate the item ids.
  # To do this, define a Proc which takes the key of the current item as argument.
  # The example below would add a prefix to each key.
  # navigation.id_generator = Proc.new {|key| "my-prefix-#{key}"}

  # The auto highlight feature is turned on by default.
  # This turns it off globally (for the whole plugin)
  # navigation.auto_highlight = false

  # Define the primary navigation
  navigation.items do |primary|
    # Add an item to the primary navigation. The following params apply:
    # key - a symbol which uniquely defines your navigation item in the scope of the primary_navigation
    # name - will be displayed in the rendered navigation. This can also be a call to your I18n-framework.
    # url - the address that the generated item links to. You can also use url_helpers (named routes, restful routes helper, url_for etc.)
    # options - can be used to specify attributes that will be included in the rendered navigation item (e.g. id, class etc.)
    #
    primary.item :expenses, t('activerecord.models.expense'), new_expense_path do |expenses|
      expenses.item :new, t('menu.expenses.new.title'), new_expense_path do |additional|
        additional.item :category, t('activerecord.models.category'), categories_path
        additional.item :expense_types, t('activerecord.models.expense_type'), expense_types_path
        additional.item :payment_methods, t('activerecord.models.payment_method'), payment_methods_path
      end
      expenses.item :index, t('menu.expenses.index.title'), expenses_path           
    end
    
    primary.item :statistics, 'Statistici', dashboard_path
    
    primary.item :welcome, 'welcome', root_path, :if => Proc.new { controller_name == 'welcome' } do |welcome|
      welcome.item :what_is_kobi, t('welcome.menu.what_is_kobi'), root_path
      welcome.item :tour, t('welcome.menu.tour'), root_path
      welcome.item :faq, t('welcome.menu.faq'), root_path
      welcome.item :tour, t('welcome.menu.contact'), root_path
      welcome.item :tour, t('welcome.menu.blog'), root_path
    end
    
    
    # You can also specify a condition-proc that needs to be fullfilled to display an item.
    # Conditions are part of the options. They are evaluated in the context of the views,
    # thus you can use all the methods and vars you have available in the views.
    #primary.item :key_3, 'Admin', url, :class => 'special', :if => Proc.new { current_user.admin? }
    #primary.item :key_4, 'Account', url, :unless => Proc.new { logged_in? }

    # you can also specify a css id or class to attach to this particular level
    # works for all levels of the menu
    # primary.dom_id = 'menu-id'
    # primary.dom_class = 'menu-class'
    
    # You can turn off auto highlighting for a specific level
    # primary.auto_highlight = false  
  end
  
end
