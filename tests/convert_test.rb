require "./lib/convert.rb"
require "test/unit"

class ConvertTest < Test::Unit::TestCase

  def test_exception
    movie  = convert("tests/fixtures/SampleVideo.avi",".avi", ".mp4")
    assert_equal(nil, movie)
  end

  def test_mkv_conversion
    movie = convert("tests/fixtures/SampleVideo.mp4",".mp4", ".mkv")
    assert_not_equal(nil, movie)
  end

  def test_avi_conversion
    movie = convert("tests/fixtures/SampleVideo.mp4",".mp4", ".avi")
    assert_not_equal(nil, movie)
  end

  def test_mpeg_conversion
    movie = convert("tests/fixtures/SampleVideo.mp4",".mp4", ".mpeg")
    assert_not_equal(nil, movie)
  end

  def test_ogg_conversion
    movie = convert("tests/fixtures/SampleVideo.mp4",".mp4", ".ogg")
    assert_not_equal(nil, movie)
  end

  def test_webm_conversion
    movie = convert("tests/fixtures/SampleVideo.mp4",".mp4", ".webm")
    assert_not_equal(nil, movie)
  end

def test_convert_folder
  movie = convert("tests/fixtures", ".mp4", ".avi")
  assert_not_equal(nil, movie)
end

  def teardown
      File.delete("SampleVideo.mkv") if File.exist?("SampleVideo.mkv")
      File.delete("SampleVideo.avi") if File.exist?("SampleVideo.avi")
      File.delete("SampleVideo.mpeg") if File.exist?("SampleVideo.mpeg")
      File.delete("SampleVideo.ogg") if File.exist?("SampleVideo.ogg")
      File.delete("SampleVideo.webm") if File.exist?("SampleVideo.webm")
  end
end
