require 'zip'

class ZipUtil
  def self.read_files_from_zip(zip_file_path, file_path_within_zip)
    file_contents = []

    raise "#{zip_file_path} not found" unless File.exist? zip_file_path

    Zip::File.open(zip_file_path) do |zip_file|
      entries = zip_file.glob(file_path_within_zip)
      raise "#{file_path_within_zip} not found in #{zip_file.entries}" if entries.empty?

      entries.each do |entry|
        file_contents << {
          name: entry.name,
          contents: entry.get_input_stream.read
        }
      end
    end
    file_contents
  end
end