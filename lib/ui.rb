require  'green_shoes'
require "./lib/convert.rb"

video_types = ['.mp4', '.mkv', '.avi', '.mpeg', '.ogg', '.webm', '.mov', '.flv']

Shoes.app( :width => 480, :height => 620)  do
	@filename = ''
	stack margin_left: 125, margin_top: 10 do
		flow margin_top: 75 do
			para 'Please select a file or a folder'
		end

		flow margin_bottom: 50 do
			@open_file = button 'Open File'
			@open_file.click {
				@filepath = ask_open_file
				if !@p1
					@p1 = para File.basename(@filepath)
				else
					@p1.text = File.basename(@filepath)
				end
			}
		end

		flow margin_bottom: 50 do
			@open_folder = button 'Open Folder'
			@open_folder.click {
				@filepath = ask_open_folder
				if !@p1
					@p1 = para File.basename(@filepath)
				else
					@p1.text = File.basename(@filepath)
				end
			}
		end

	para 'Convert From: '
	@from_format = list_box items: video_types,
	choose: '.mp4'

	para 'Convert To: '
	@to_format = list_box items: video_types,
	choose: '.mp4'

	flow {
		@subdir = check; para "Convert Subdirectories"
	}
	flow {
		@del = check; para "Delete files after conversion"
	}

	@convert = button 'Convert Video'
	@convert.click {
		if(!@filepath)
			alert('Please select a file or folder to convert')
		elsif(!video_types.include?(File.extname(@filepath)))
			alert('Please select a valid video file')
		else
			@movie = convert(@filepath, @from_format.text, @to_format.text, @subdir.checked?, @del.checked?)

			if(@movie != nil)
				alert('Conversion Sucessful.')
			else
				alert('Conversion Unsucessful. Please try another format or file.')
			end
		end
	}
	@exit = button 'Exit'
	@exit.click {
		exit()
	}
	end
end
