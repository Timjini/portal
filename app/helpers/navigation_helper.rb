module NavigationHelper
  require 'yaml'

  def nav_items_for_current_user
    role = current_user.role.to_s
    navs = YAML.load_file(Rails.root.join("config/navigation.yml"))
    items = navs[role] || []

    items.map { |item| add_paths(item) }
  end

  private

  def add_paths(item)
    item_with_path = item.merge(path: send(item["path_helper"]))

    if item["children"]
      item_with_path["children"] = item["children"].map { |child| add_paths(child) }
    end

    item_with_path
  end
end
