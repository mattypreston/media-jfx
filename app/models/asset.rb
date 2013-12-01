require 'base64'

class Asset < ActiveRecord::Base
  belongs_to :package
  attr_accessible :package_id, :name, :asset_file, :media_type, :uploaded_over_api, :directory, :expected_chunks, :received_chunks
  mount_uploader :asset_file, AssetUploader

  def convert_to_file(file_to_convert)
    encoded_data = Base64.decode64(file_to_convert)
    encoded_data
  end

  def save_to_disk(name, asset_file)
    directory = "public/uploads/asset/asset_file/#{self.id}"
    Dir.mkdir(directory) unless File.exists?(directory)
    path = File.join(directory, name)
    file = self.convert_to_file(asset_file)
    File.open(path, "wb") { |f| f.write(file)}
    self.directory = directory
  end

  def append_chunk(asset_file)
    @errors = []

    if self.received_chunks + 1 > self.expected_chunks
      @errors << {:error_no => 8, :message => "expected number of chunks has been exceeded."}
    else
      #Only convert to file when you have received all chunked data
      #Keep saving chunks to file.Then when we have everything
      #we need to read file back in completely to memory and then decode from base64.
      #file = self.convert_to_file(asset_file)
      file = asset_file
      path = File.join(self.directory, self.name)
      if self.expected_chunks.eql?(self.received_chunks + 1)
        file = File.new(path, "r")
        file_data = nil
        counter = 0
        while (line = file.gets)
            puts "#{counter}: #{line}"
            counter = counter + 1
            file_data = "#{file_data}#{line}"
            puts file_data
        end
        file.close
        file = "#{file_data}#{asset_file}"
        file = self.convert_to_file(file)
        File.open(path, "wb") { |f| f.write(file)}
      else
        File.open(path, "a") { |f| f.write(file)}
      end


      self.received_chunks = self.received_chunks + 1
      self.save!
    end

    @errors

  end

  def self.validate_asset_request(assets_request)
    @errors = []
    begin
      assets_request.each do |asset|
        if asset[:package_id].present?
          if asset[:file_name].present?
            existing_asset = self.find_by_package_id_and_name(asset[:package_id], asset[:file_name])
            if existing_asset.present?
              if asset[:chunk_number].present?
                if (existing_asset.received_chunks + 1).eql?(asset[:chunk_number].to_i)
                  if asset[:asset_file].nil? or asset[:asset_file].size.eql?(0)
                    @errors << {:error_no => 2, :message => "missing or incomplete asset file which means invalid chunk size for asset #{asset.to_s}"}
                  else
                    if asset[:chunk_size].nil? or asset[:chunk_size].size.eql?(0) or (asset[:chunk_size].to_i != asset[:asset_file].size)
                      #@errors << {:error_no => 2, :message => "invalid chunk size for asset #{asset.to_s}"}
                      puts "Asset file mismatch - bytes #{asset[:asset_file]} sent, bytes received #{asset[:asset_file].size}"
                    end
                  end
                else
                  @errors << {:error_no => 3, :message => "invalid chunk number for asset #{asset.to_s} expecting #{(existing_asset.received_chunks + 1)}"}
                end
              else
                @errors << {:error_no => 3, :message => "invalid chunk number for asset #{asset.to_s}"}
              end
            else
              @errors << {:error_no => 7, :message => "No asset found for asset #{asset.to_s}"}
            end
          else
            @errors << {:error_no => 6, :message => "No file_name found for asset #{asset.to_s}"}
          end
        else
          @errors << {:error_no => 4, :message => "Package not found for id for asset #{asset.to_s}"}
        end
      end
    rescue Exception => e
      @errors << {:error_no => 99, :message => e.message}
      @errors << {:error_no => 5, :message => "No assets in request"}
    end
    @errors
  end

end
