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


  def render_media_as_thumbnail(asset)
    case asset.media_type.downcase
      when "mp4", "mov", "mpg", "avi", "mpeg"
        "<div class='well'>
          <div class='media-body'>
            <div class='fileupload-new thumbnail pull-left' style='width: 200px; height: 200px;'>
                #{video_tag asset.asset_file.present? ? asset.asset_file : "default-image.jpg", :id => 'asset_file', :size => "200x200", :controls => true}
            </div>
            <h4 class='media-heading'>#{asset.name}</h4>
            #{asset.asset_file} <br/>
            #{asset.media_type}
          </div>
        </div>".html_safe
      when "mp3", "wav", "mpeg"
        "<div class='well'>
          <div class='media-body'>
            <div class='fileupload-new thumbnail pull-left' style='width: 300px; height: 35px;'>
              #{audio_tag asset.asset_file.present? ? asset.asset_file : "default-image.jpg", :id => 'asset_file', :size => "320x35", :controls => true}
            </div>
            <h4 class='media-heading'>#{asset.name}</h4>
            #{asset.asset_file} <br/>
            #{asset.media_type}
          </div>
        </div>".html_safe
      else
        "<div class='well'>
          <div class='media-body'>
            <div class='fileupload-new thumbnail pull-left' style='width: 50px; height: 50px;'>
              #{image_tag asset.asset_file.present? ? asset.asset_file : "default-image.jpg", :id => 'asset_file', :style => "width: 50px; height: 50px;"}
            </div>
            <h4 class='media-heading'>#{asset.name}</h4>
            #{asset.asset_file} <br/>
            #{asset.media_type}
          </div>
        </div>".html_safe
    end

  end


  def render_media(asset)

    case asset.media_type.downcase
      when "mp4", "mov", "mpg", "avi", "mpeg"
        "<div class='well'>
          <div class='fileupload-new thumbnail' style='width: 320px; height: 240px;'>
            #{video_tag asset.asset_file.present? ? asset.asset_file : "default-image.jpg", :id => 'asset_file', :size => "320x240", :controls => true}
          </div>
        </div>".html_safe
      when "mp3", "wav", "mpeg"
        "<div class='well'>
          <div class='fileupload-new thumbnail' style='width: 300px; height: 30px;'>
            #{audio_tag asset.asset_file.present? ? asset.asset_file : "default-image.jpg", :id => 'asset_file', :size => "320x35", :controls => true}
          </div>
        </div>".html_safe
      else
        "<div class='well'>
          <div class='fileupload-new thumbnail' style='width: 200px; height: 200px;'>
            #{image_tag asset.asset_file.present? ? asset.asset_file : "default-image.jpg", :id => 'asset_file', :style => "width: 200px; height: 200px;"}
          </div>
        </div>".html_safe
    end if asset.media_type.present?

    # For some reason the regex is not working so need to revisit at some point.
    #if (asset.media_type.downcase =~ /mp4|mov|mpg|avi|mpeg|/)
    #  "<div class='fileupload-new thumbnail' style='width: 320px; height: 240px;'>#{video_tag asset.asset_file.present? ? asset.asset_file : "default-image.jpg", :id => 'asset_file', :size => "320x240", :controls => true}</div>".html_safe
    #elsif (asset.media_type.downcase =~ /mp3|wav|ogg|/)
    #  "<div class='fileupload-new thumbnail' style='width: 320px; height: 240px;'>#{audio_tag asset.asset_file.present? ? asset.asset_file : "default-image.jpg", :id => 'asset_file', :size => "320x240", :controls => true}</div>".html_safe
    #else
    #  "<div class='fileupload-new thumbnail' style='width: 200px; height: 200px;'>#{image_tag asset.asset_file.present? ? asset.asset_file : "default-image.jpg", :id => 'asset_file'}</div>".html_safe
    #end

  end

  def render_upload_button(f)
    "<div id='file-browse' hidden='hidden'>
        #{f.file_field :asset_file, :id => 'btn_upload'}
    </div>
    <br/>
    <a id='btn_browse' class='btn btn-success'>
      Select File <i class='icon-upload icon-white'></i>
    </a>".html_safe
  end

end
