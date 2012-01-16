require 'test_helper'

class Ruby2xlsxTest < ActiveSupport::TestCase
  test "truth" do
    assert_kind_of Module, Ruby2xlsx
  end
  
  test "excel mime type" do
    assert_equal :xlsx, Mime::XLSX.to_sym
    assert_equal "application/vnd.ms-excel", Mime::XLSX.to_s
  end
end
