require 'streamio-ffmpeg'

def convert(filepath, from, to)
	if File.file?(filepath)
		movie = convert_file(filepath, to) if File.extname(filepath) == from
	else
		Dir.	foreach(filepath) do |file|
			movie = convert_file(filepath + "/" + file, to) if File.extname(file) == from
		end
	end
	return movie
end

def convert_file(file, to)
	begin
		movie = FFMPEG::Movie.new(file)
		movie.transcode(File.basename(file,File.extname(file)) + to) { |progress| puts progress }
	rescue
		if File.exist?(File.basename(file,File.extname(file)) + to)
			File.delete(File.basename(file,File.extname(file)) + to)
		end
		print "\n\nUnable to convert the video"
	end
end
