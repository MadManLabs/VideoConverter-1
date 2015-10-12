require 'streamio-ffmpeg'

def convert(filepath, from, to, subdir)
	movie = nil
	if File.file?(filepath)
		movie = convert_file(filepath, to) if File.extname(filepath) == from
	else
		movie = convert_folder(filepath, to, from, subdir)
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

def convert_folder(folder, to, from, subdir)
	movie = nil
	if subdir
		Dir.glob(folder+'/**/*'+from) do |file|
  			movie = convert_file(file, to) if File.extname(file) == from
		end
	else
		Dir.glob(folder+'/*'+from) do |file|
			movie = convert_file(file, to) if File.extname(file) == from
		end
	end
	return movie
end
