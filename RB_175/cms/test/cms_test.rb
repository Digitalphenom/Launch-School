ENV['RACK_ENV'] = 'test'
require 'minitest/autorun'
require 'minitest/reporters'
require 'rack/test'

Minitest::Reporters.use!
require_relative '../cms'

class CMSTest < Minitest::Test
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  def setup
    @path = File.expand_path('..', __FILE__)
  end

  def test_index
    get '/'
    assert_equal 200, last_response.status
    assert_equal 'text/html;charset=utf-8', last_response['Content-Type']
    assert_equal true, last_response.body.match?(/history|changes|about/)
  end

  def test_history
    get '/history.txt'

    assert_equal 200, last_response.status
    assert_equal 'text/plain', last_response['Content-Type']
    contents = File.readlines('files/history.txt')
    assert_equal contents.join, last_response.body
  end

  def test_changes
    get '/changes.txt'

    assert_equal 200, last_response.status
    assert_equal 'text/plain', last_response['Content-Type']
    contents = File.readlines('files/changes.txt')
    assert_equal contents.join, last_response.body
  end

  def test_dynamic_filename
    get '/notafile.ext'
    assert_equal 302, last_response.status
    assert_raises StandardError do
      File.readlines("files/#{doc}")
    end

    get last_response['Location']
    assert_equal 200, last_response.status
    assert_includes last_response.body, 'notafile.ext does not exist'

    get '/'
    refute_includes last_response.body, 'notafile.ext does not exist'
  end

  def test_viewing_markdown_document
    get '/about.md'
    assert_equal 200, last_response.status
    assert_equal 'text/html', last_response['Content-Type']

    File.readlines('files/about.md')
    assert_includes last_response.body, '<h1>Ruby is</h1>'
  end
  
  def test_edit
    get '/about.md/edit'
    assert_equal 200, last_response.status
    assert_equal 'text/html;charset=utf-8', last_response['Content-Type']
    
    get '/'
    refute_includes last_response.body, 'has been updated'
  end
  
  def test_updating_content
    post "/changes.txt"
    assert_equal 302, last_response.status

    get last_response["Location"]

    get "/changes.txt"
    assert_equal 200, last_response.status

    assert_includes last_response.body, File.read("#{@path}/changes.txt")
  end
end
