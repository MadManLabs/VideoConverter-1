require 'streamio-ffmpeg'

def convert(file, to)
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
