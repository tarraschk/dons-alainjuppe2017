# This file is used by Rack-based servers to start the application.

require ::File.expand_path('../config/environment', __FILE__)
require 'rack-zippy'

# Set asset_root to an absolute or relative path to the directory holding your asset files
# e.g. '/path/to/my/apps/static-assets' or 'public'
asset_root = 'public'
use Rack::Zippy::AssetServer, asset_root
run Rails.application
