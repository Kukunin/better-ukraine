###
# Page options, layouts, aliases and proxies
###

# Per-page layout changes:
#
# With no layout
page '/*.xml', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false

# With alternative layout
# page "/path/to/file.html", layout: :otherlayout

# Proxy pages (http://middlemanapp.com/basics/dynamic-pages/)
# proxy "/this-page-has-no-template.html", "/template-file.html", locals: {
#  which_fake_page: "Rendering a fake page with a local variable" }

###
# Helpers
###

# Build-specific configuration
configure :build do
  # Minify CSS on build
  activate :minify_css

  # Minify Javascript on build
  activate :minify_javascript
end

activate :external_pipeline,
         name: :webpack,
         command: build? ? 'yarn run build' : 'yarn run start',
         source: '.tmp/dist',
         latency: 1

config[:js_dir] = 'assets/javascripts'
config[:css_dir] = 'assets/stylesheets'

helpers do
  def nav_link_to(link, url, opts = {})
    li_opts = {}
    li_opts[:class] = 'active' if url == "/#{current_page.path}"

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
