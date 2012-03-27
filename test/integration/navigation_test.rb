require 'test_helper'

class NavigationTest < ActiveSupport::IntegrationCase

  setup do
    (1..5).to_a.each do |num|
      Article.create(:title => "Some article #{num}")
    end
  end  
  
  test "truth" do
    assert_kind_of Dummy::Application, Rails.application
  end
  
  test 'xlsx request sends a excel as file' do
    visit articles_path
    click_link 'Excel'
    
    assert_equal 'binary', headers['Content-Transfer-Encoding']
    assert_equal 'attachment; filename="articles.xls"', headers['Content-Disposition']
    assert_equal 'application/vnd.ms-excel', headers['Content-Type']
  end
  
  test 'xlsx renderer uses the specified template' do
    visit '/another.xlsx'
    
    assert_equal 'binary', headers['Content-Transfer-Encoding']
    assert_equal 'attachment; filename="another.xls"', headers['Content-Disposition']
    assert_equal 'application/vnd.ms-excel', headers['Content-Type']
  end

  test 'xlsx request sends a excel as file on empty array' do
    visit '/empty.xlsx'
    
    assert_equal 'binary', headers['Content-Transfer-Encoding']
    assert_equal 'attachment; filename="ruby2xlsx_defaults.xls"', headers['Content-Disposition']
    assert_equal 'application/vnd.ms-excel', headers['Content-Type']
  end
  
  test 'should encode special charsets' do
    Article.create(:title => '(")")')
    
    visit '/articles.xlsx'
    
    assert_equal 'binary', headers['Content-Transfer-Encoding']
    assert_equal 'attachment; filename="articles.xls"', headers['Content-Disposition']
    assert_equal 'application/vnd.ms-excel', headers['Content-Type']
  end

  protected

    def headers
      page.response_headers
    end
end

