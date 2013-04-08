module Loader
  def load_res(filename)
    File.join(File.dirname(__FILE__), 'res', filename)
  end
end