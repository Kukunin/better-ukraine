###
# Page options, layouts, aliases and proxies
###

# Per-page layout changes:
#
# With no layout
page '/*.xml', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false

sprockets.append_path File.join(root, 'vendor/assets/bower')

# With alternative layout
# page "/path/to/file.html", layout: :otherlayout

# Proxy pages (http://middlemanapp.com/basics/dynamic-pages/)
# proxy "/this-page-has-no-template.html", "/template-file.html", locals: {
#  which_fake_page: "Rendering a fake page with a local variable" }

###
# Helpers
###

activate :autoprefixer do |config|
  config.browsers = ['last 2 versions', 'Explorer >= 9']
end

# Build-specific configuration
configure :build do
  # Minify CSS on build
  activate :minify_css

  # Minify Javascript on build
  activate :minify_javascript
end

helpers do
  def nav_link_to(link, url, opts = {})
    li_opts = {}
    li_opts[:class] = 'active' if "/#{current_page.path}" == url

    content_tag :li, li_opts do
      link_to(link, url, opts)
    end
  end

  def page_url
    "http://better-ukraine.eu/#{current_page.path}"
  end

  def page_id
    # 32bit integer based on page_url
    page_url.hash % 0xffffffff
  end
end
