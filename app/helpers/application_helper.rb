module ApplicationHelper
  def edit_button(path)
    link_to(path, :class => 'btn btn-mini') do
        t('.edit', :default => t("helpers.links.edit")) + " <i class='icon-edit'></i>".html_safe
    end
  end

  def delete_button(path)
    link_to(path, :method => :delete,
                  :data => { :confirm => t('.confirm', :default => t("helpers.links.confirm", :default => 'Are you sure?')) },
                  :class => 'btn btn-mini btn-danger') do
      t('.destroy', :default => t("helpers.links.destroy")) + " <i class='icon-trash icon-white'></i>".html_safe
    end
  end

end
