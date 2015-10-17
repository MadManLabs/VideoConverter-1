require 'streamio-ffmpeg'

def convert(filepath, from, to, subdir, del)
	movie = nil
	if File.file?(filepath)
		movie = convert_file(filepath, to, del) if File.extname(filepath) == from
	else
		movie = convert_folder(filepath, to, from, subdir, del)
	end
	return movie
end

def convert_file(file, to, del)
	begin
		movie = FFMPEG::Movie.new(file)
		if(to == '.mp4' || to == '.flv' || to == '.mov')
			movie.transcode(File.basename(file,File.extname(file)) + to, "-acodec aac -strict -2") { |progress| puts progress }
		else
			movie.transcode(File.basename(file,File.extname(file)) + to) { |progress| puts progress }
		end

		if File.exist?(file)
			File.delete(file) if del && movie != nil
		end

		return movie
	rescue
		if File.exist?(File.basename(file,File.extname(file)) + to)
			File.delete(File.basename(file,File.extname(file)) + to)
		end
		print "\n\nUnable to convert the video"
	end
end

def convert_folder(folder, to, from, subdir, del)
	movie = nil
	if subdir
		Dir.glob(folder+'/**/*'+from) do |file|
  			movie = convert_file(file, to, del) if File.extname(file) == from
		end
	else
		Dir.glob(folder+'/*'+from) do |file|
			movie = convert_file(file, to, del) if File.extname(file) == from
		end
	end
	return movie
end
