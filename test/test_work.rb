require_relative '../lib/redbubble/work'

class TestWork < MiniTest::Test
  def test_valid_work_items
    valid_work_obj = Redbubble::Work.new(
      "http://someurl.com/some_thumb.jpg",
      "Canon",
      "Can01"
    )
    refute valid_work_obj.invalid?, "this is a valid work object"
  end

  def test_invalid_work_items_missing_url
    [nil, "", "   "].each do |bad_url|
      invalid_work = Redbubble::Work.new(bad_url,"Canon","xyz")
      assert invalid_work.invalid?, "this item is missing a url"
    end
  end

  def test_invalid_work_items_missing_make
    [nil, "", "  "].each do |bad_make|
      invalid_work = Redbubble::Work.new("someurl", bad_make, "abc")
      assert invalid_work.invalid?, "this item is having a bad make name"
    end
  end

  def test_invalid_work_items_missing_model
    [nil, "", "    "].each do |bad_model|
      invalid_work = Redbubble::Work.new("someurlll", "some model", bad_model)
      assert invalid_work.invalid?, "this item is having a bad model name"
    end
  end

  def test_invalid_work_items_combination_of_bad_attrs
    assert Redbubble::Work.new(nil, nil, "some model").invalid?, "missing url and make"
    assert Redbubble::Work.new(nil, "some make", nil).invalid?, "missing url and model"
    assert Redbubble::Work.new("some url", nil, nil).invalid?, "missing make and model"
  end
end
