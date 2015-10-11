require  'green_shoes'
require "./lib/convert.rb"

Shoes.app( :width => 500, :height => 500)  do
	@filename = ''
	stack margin_left: 150, margin_top: 10 do
		flow margin_top: 140 do
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
	@from_format = list_box items: ['.mp4', '.mkv', '.avi', '.mov', '.mpeg', '.ogg', '.flv', '.webm']

	para 'Convert To: '
	@to_format = list_box items: ['.mp4', '.mkv', '.avi', '.mov', '.mpeg', '.ogg', '.flv', '.webm']

	@convert = button 'Convert Video'
	@convert.click {
		@movie = convert(@filepath, @from_format.text, @to_format.text)

		if(@movie != nil)
			alert('Conversion Sucessful.')
		else
			alert('Conversion Unsucessful. Please try another format or file.')
		end
	}
	@exit = button 'Exit'
	@exit.click {
		exit()
	}
	end
end
