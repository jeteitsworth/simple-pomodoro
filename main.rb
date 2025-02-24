require_relative 'vlc_bind'

RED = "\e[31m"
GREEN = "\e[32m"
YELLOW = "\e[33m"
CYAN = "\e[36m"
BOLD = "\e[1m"
RESET = "\e[0m"
CLEAR_LINE = "\r\e[K"

@media = nil
@player = nil
@vlc_instance = nil
@mp3_path = "alarm.mp3"

def start_timer(seconds)
	puts "#{CYAN}⏳ Starting timer."

	total_length = 30

	seconds.downto(0) do |i|
		percent_complete = (total_length * (1 - i.to_f / seconds)).to_i
		bar = "=" * percent_complete + " " * (total_length - percent_complete)
		color = i <= 5 ? RED : GREEN

		print "#{CLEAR_LINE}#{color}[#{bar}] #{BOLD}#{i} seconds left#{RESET}"
		sleep(1)
	end
	trigger_alarm
end

def play_mp3
	player = build_vlc_player
	VLC.libvlc_media_player_play(@player)

	visual_alarm

	VLC.libvlc_media_release(@media)
	VLC.libvlc_media_player_release(@player)
	VLC.libvlc_release(@vlc_instance)
end

def visual_alarm
	6.times do
		print "#{BOLD}#{RED}🚨 ALARM! 🚨#{RESET}\r"
		sleep(0.5)
		print "#{BOLD}#{YELLOW}🚨 ALARM! 🚨#{RESET}\r"
		sleep(0.5)
	end
end

def trigger_alarm
	puts "\n\n#{YELLOW}🔥 Time's up! 🔥 #{RESET}\n"
	3.times {print "\a"; sleep(0.5) }

	play_mp3
end

def build_vlc_player
	@vlc_instance = VLC.libvlc_new(0, nil)
	return unless @vlc_instance

	@media = VLC.libvlc_media_new_path(@vlc_instance, @mp3_path)
	return unless @media

	@player = VLC.libvlc_media_player_new_from_media(@media)
	return unless @player

end

duration =  10

start_timer(duration)