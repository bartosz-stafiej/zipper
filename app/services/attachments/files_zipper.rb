module Attachments
  class FilesZipper
    def initialize(files:, password:)
      @files = files
      @password = password
    end

    def call
      enc = Zip::TraditionalEncrypter.new(@password)

      buffer = Zip::OutputStream.write_buffer(StringIO.new(''), enc) do |zip|
        @files.each do |file|
          zip.put_next_entry(file[:filename])
          zip.write(file[:tempfile].read)
        end
      end

      buffer.rewind
      buffer
    end
  end
end
