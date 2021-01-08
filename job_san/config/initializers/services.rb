Dir.glob("app/services/**/*.rb") do |f|
  require_dependency Rails.root.join(f)
end
