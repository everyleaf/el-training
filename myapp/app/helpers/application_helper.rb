module ApplicationHelper
  # build request uri with given URL and query string key/value.
  # param value will be overridden if the param already exits in the URL.
  # e.g.
  # url :string ... 'http://example.com/abc/xyz/?a=b&c=d'
  # param :string ... 'c'
  # value :string ... 'z'
  # return :string /abc/xyz/?a=b&c=z
  def build_request_uri(url, param, value)
    uri = URI(url)
    nested_query = Rack::Utils.parse_nested_query(uri.query)
    new_query = Rack::Utils.build_nested_query(nested_query.merge({ param => value }))
    URI::HTTP.build(path: uri.path, query: new_query).request_uri
  end
end
