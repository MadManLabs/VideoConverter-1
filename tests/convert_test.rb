require "./lib/convert.rb"
require "test/unit"
 
class ConvertTest < Test::Unit::TestCase
 
  def test_exception
  	movie  = convert("tests/fixtures/SampleVideo.avi", ".mp4")
  	assert_equal(nil, movie)
  end
 
    def test_conversion
  	movie = convert("tests/fixtures/SampleVideo.mp4", ".avi")
  	assert_not_equal(nil, movie)
  end

  def teardown
  	if File.exist?("SampleVideo.avi")
		File.delete("SampleVideo.avi")
	end
  end
end
